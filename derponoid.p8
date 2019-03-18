pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
--ball init funciton
function initball()
	local b={
		x=0,
		y=63,
		dx=2,
		dy=2,
		r=2,
		c=10
	}
	return b
end

--returns generic box table
function getnewbox(x,y,w,h,s,c)
	return {x=x,y=y,w=w,h=h,s=s,c=c}
end

--inits paddle
function initpaddle()
	local p=getnewbox(51,120,24,3,5,7)
	p.dx=0
	p.hc=8
	p.dc=p.c
	return p
end

--p-8 default init
function _init()
	b=initball()
	p=initpaddle()
end

--checks ball collision on
-- generic box table
function ballcollision(box)
	--y
	if b.y-b.r>box.y+box.h then
		return false
	end
	if b.y+b.r<box.y then
		return false
	end
	--x
	if b.x-b.r>box.x+box.w then
		return false
	end
	if b.x+b.r<box.x then
		return false
	end

	return true
end

function handleinput()
	local bpressed=false
	--moving paddle
	--left
	if btn(0) then
		p.dx=-p.s
		bpressed=true
	end
	--right
	if btn(1) then
		p.dx=p.s
		bpressed=true
	end
	--no button pressed,
	--slow down paddle
	if not(bpressed) then
		p.dx=p.dx/1.7
	end
	
	p.x+=p.dx
end

--p-8 default update
function _update()
	b.x+=b.dx
	b.y+=b.dy

	--ball edge collision
	--x
	if b.x+b.r>127 or b.x<0 then
		b.dx=-b.dx
		sfx(0)
	end
	--y-top
	if b.y<0 or b.y+b.r>127 then
		b.dy=-b.dy
		sfx(0)
	end
	p.c=p.dc
	--paddle-ball collision
	if ballcollision(p) then
		b.dy=-b.dy
		p.c=p.hc
		sfx(1)
	end

	handleinput()

	if p.x<0 then
		p.x=0
	end
	if p.x+p.w>127 then
		p.x=127-p.w
	end
end

function _draw()
	cls()
	rectfill(0,0,127,127,1)
	circfill(b.x,b.y,b.r,b.c)
	rectfill(p.x,p.y,p.x+p.w,p.y+p.h,p.c)
end
__sfx__
00010000143501435014350143501a300013000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100001f3501f3501f3501f35025300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
