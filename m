From: Thomas Schneider <thosch97@gmail.com>
Subject: [PATCH] gitweb: Update logo and favicon
Date: Mon, 13 Apr 2015 01:40:40 +0200
Message-ID: <1428882040-13938-1-git-send-email-thosch97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Schneider <thosch97@gmail.com>,
	Jason Long <jason@jasonlong.me>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 01:41:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhRV1-0000ji-Hu
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 01:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbbDLXk6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Apr 2015 19:40:58 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34663 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbbDLXku (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 19:40:50 -0400
Received: by widjs5 with SMTP id js5so52482512wid.1
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 16:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=cylNmw9KaTt+hZrsuTc7QbL4j+aiIap9ueuEfX9Lj3M=;
        b=ykjIx/LWt63l9dO+jYpgFiNKNYpZzg1IPTCpBFWVGEZhtM011fFvUGkEvxvMYiRv3W
         IDL2M8vONhIfTl2ffA+ZTVrKq5jnNIDOOcd18L16H1tu3nVMuA33RryksbV8lVHTIjLD
         3GsYy0py+s8cPTCO0M6dKji6A+WnCb2FqHxB6d3LsCHUWFCxKNbChVJTaH1gfkm/aaiK
         nZsKU9fOJIbzD71xJYTGcHteyNVE5ZTFx/ssTpzrUwfy3pEqqpYqjpymIalhQ/Rt1l72
         dhF11hlAQCzUMh106jNtfSGaRfkFptPlvWDI+TPzAAZigsQzOoQXCfru3h+2xPh0DbQ+
         TIMg==
X-Received: by 10.194.63.172 with SMTP id h12mr22118981wjs.48.1428882049345;
        Sun, 12 Apr 2015 16:40:49 -0700 (PDT)
Received: from tatooine.fritz.box (p4FCC5C29.dip0.t-ipconnect.de. [79.204.92.41])
        by mx.google.com with ESMTPSA id dx11sm8916246wjb.23.2015.04.12.16.40.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2015 16:40:48 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.30.ga4238fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267057>

The new images were downloaded from https://git-scm.herokuapp.com/downl=
oads/logos
and converted with ImageMagick:
  convert -resize 72x30 Git-Logo-2Color.eps git-logo.png
  convert -resize 16x16 Git-Icon-1788C.eps git-favicon.png
The old logo was only 27 pixels in height, the 3 additional pixels are =
necessary
for the slightly different aspect ratio of the new one.

Graphics were created by Jason Long <jason@jasonlong.me> and are licens=
ed under
the CC-BY 3.0 license <https://creativecommons.org/licenses/by/3.0/>

Signed-off-by: Thomas Schneider <thosch97@gmail.com>
---
View new logos at:
  https://git.qsuscs.de/cgit/git.git/tree/gitweb/static?h=3Dts/gitweb-l=
ogo
=46etch ref ts/gitweb-logo from:
  git://qsuscs.sculptor.uberspace.de:63913/git.git

I wonder whether mentioning creator (CC'ed) and license in the commit m=
essage is
enough, or whether we should state it e.g. in gitweb/README =E2=80=A6

 gitweb/static/git-favicon.png | Bin 115 -> 14907 bytes
 gitweb/static/git-logo.png    | Bin 207 -> 1968 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/gitweb/static/git-favicon.png b/gitweb/static/git-favicon.=
png
index aae35a70e70351fe6dcb3e905e2e388cf0cb0ac3..775d6f46de8896b02d094ca=
9488295e75a740be3 100644
GIT binary patch
literal 14907
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
)
z_?Ym7f*Smm`7u!y!wcHbST#+ft>QNt`bT&Y-(boV&*Gol+znLABG%}M^%@Ua+Xg$w
zAwcIFbO{Q!sc{OV#56tL)i1QohvL^G=3D@M*2A`M#xjP>Nkhb@7%Do7!AxZ6;JK^U}`
zlrjBL^p?!u@nHepa%E>Cq*Zp^gkdd4m^HbV<99MIB7BEtj!UmL*^L(_Fd;$JJLoH4
zaOgyJm}chp1D*@Wo3F_U=3DvW?kT=3DZbdK_0RN<##rd$eB1|Wax5|vIzw~mG%lHlkg)b
z_AD!GXi54ZB1%}ozX*hJMQHelsdUV~?k8lm%$%aCkix_vI=3DV~RSBJ=3Dd)xk9&XAI(+
z@uKcXAnq&F0H^|o_p5Frb0xBikunGJh(^%fMq9x9X!go`G43!Q2ND@wS&~w7zivf0
zhK6_K<sPgRQ7Y^(^WowoM)>1M<Kfe_9yJbQhlj((yZ0DjRgroUk|9MykV`h0>#XF(
z=3D8=3D8PR=3D6EBM<U&&zM5yY+B;MU4z266niLu&z2W{@05oatf=3D7~7@+E6VpsA*!RY=
C<y
z-Ez_(m{YQ{kDr1}eXA!7`Go}<kW}|Zb6losz>b=3DnKXwRb3zDG}c<&diexlfv^fax^
zz!gfSB(>q856sGWAauvveHUN|BTT45jslSrbccxeyx0aV+WQQBMhG?6zJw=3DD=3DOkB)
zn3<0mkPg{LtJKo8Z3JaIpfe51*w1EKwzDgqdOJlShDR4|lz_8yk@Qzed1|$ney_du
z=3D%&PHysl3PADneZ3*o?VWX?r5%~}X3J9`j*PyK{Jnr7xntnQgbF_oCcEUm8|@-d5z
zOjN>Ewp}ckVqg)soMttYDtpqiKC<|8n!>hE-PLiCoqi)@p@aQ|bFYI$l&wW`71|mo
zTxW=3DT*jttnE&=3DmNF~!Ltj%Mx~&VrlG3Z9_yo^TE`reBf@k~T#&1rS=3DV)|h<Q&D5V=
%
z2X)|<tEPHce&t7yn1kO3`v$mDE=3Dx&{U7x$Gt`GSHpkYbl8eiF-@Th~Cg)`0=3DC}y~z
zl0dTC8C^^wUvW*R&Os&t`ZL&8%7u!L`tV1GgL@(#Gt~v`Oqp2J1u%!-TNRk~3zJ(2
zm#BGr)_gejMfR+suiI3E<%TKGiyKp16?GPpIf>9;OdADw!>ua%h>?{5c6L@k1f|@j
zI3|4`&d^=3DPMY{yY;x%~3qRyDQmZbSc%s*(5_e5byH7_5?YFf#b+{T<9zlP7<G+92>
zA$Jvv&Zg#xNk#KQ7qW3NM%-ednUJl#B9NU^3=3D1Sp#n*)*CQge#5Hbr&BW^?EZiIwI
zpg*~Hz{Cn2C_`%u3ya3@o^W0Ihp<qeMB1Wvg$FONGt^UjgaQ^FUcX@QiM0T4N5bMx
z(tDp>0%9NCQz$-Q#0Z9UBUT(lrzPI0@z6(R(-P=3D}D+H&JeVbM$ME)%fU$tn3v!vQA
zgGz1Y0=3DU$&`UCU}+JGs<^yY9mO<qYBH14c8me;G^J%#6MB#X|hfHSuUFQI)wWPN=3Dy
zIfFL<b31#w42!>tVJP&c6Sq}iMiS&Ew>t9bgXitN2n~~6i6;CBXd~}A*ZEO+I_3)r
zMsBG`y2y<Btit}d3JVL8?_Gc%v>5#^>V3sur$6w_FJnZST~fLy=3Dp%Tyl7+Uzu=3DE0>
z=3D*D84P1SGv6_}~j6Qz#L*_mj9X$1^AD!)7-4U@Y|YcnA-L!3RFqCDrMXZkZlbWj_c
z)3}2c#&IG?*;`3Xs&~^+AT*3n;_K&DfLnN7!n^>UY38D~=3D*DlF;X&eG{?PTkeu?RF
zUPiSp$VEa(T+VMXpGq3k8(|YXAiT(wc9JRMykTO(!e?nr+4KH+8pbs@!600QJ3K$9
zl#^G6-OHaaxvBGGsq@e&a*mTYL!*<C(hFaH_Qom#i6aOrb0$Hy6yvk5fH{guzaplG
zs8``Lx@B6OY(FceHJYU@Vq*%|8m$e~2PM&BB)gtZjK99q$>PxkN8r&#H-5B;wTt;)
zV2ie89ERkpO$O^`R^+y5&$sXDJ_<!=3DT^0T3Q_0;=3DZW?=3Do*AOG9ZAqZ<n(~G=3D+D=
|q$
zO-PU*RZUbQ-6wqQZZg%*AIZgA<QBs0eA){p?5O1OK<a!mNLKgjFmP~KA;m0tZPj#k
z+V=3D8ln4@~cfuISA#akM?pcPV|7F{1KxWmbvR!I1Hts$(bV#70+N>K6A15vhV@}#we
zS!~DLmF#npswdx80`2Du1${ex9NUj}GscBJ<l>m31LBy;9VFQIsnR<k{NCV-L0%kY
zakig#l;x&o$v!qC&LXAU>L}<v;(Pd8pc(4`bGj`TkaYw>;obnYUcWMB!$c0LhTU?m
zcppZ}!k>t;uVW|@5vm2-;yHHkj&!*7)JU=3DX@U62O;v>K1Wa<74`O#2n;;1VB`~gC!
zE0DCY-tMSK@{p!9vq=3D);Q-ENK^Rn+qlBZ6HCkjzY#-MrjbRsXcXGOAjT80qD$)#1d
zrSD<RI7}*W<x2KKj$(`rn&|i?Rkg6)X;`a%a;abIng_!-l&q|3uAO>nP_(e!Fy~js
z=3D{Z6u{4=3D^Xjj!sx?J+S5xKpdWa>15{X6>UqRcs`h?mZGU+=3DQ=3D_YS$#ZW<q(!0R=
{56
z5#u6=3D7t$`tmZjZIR8{P4@<k)9iz5*xDTj`9B{-6ZQG{Y=3DCeZA`M=3Dvku2dOZV#!e+=
w
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
k
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
}
zuWs?f<%qVcqApvf;;swJ6<5nJUNysz5PXYGwu+D8x)pnB8n`{r!$&{4di9PIhxbyY
zxAP;S`&SQj;T~Z-1Zqal*sw~c$SdD)Nup%8TwB2wtBsBw6{&cF8MF=3DcuOsbEq11xJ
zax>$Pssj_M-!X~52-@3UQGmffE|P`h!}v5zFMsRw`ctE#Hm6Usxl=3DC+Cew?TvAuV?
z_=3DXin-)6aldC43=3D%hLF2a9j#?N*m<8zw8ANnOfauVGIc)JcJO>>UupOz02AQjvQ*+
z6KJ%4b`hV1C-x8v!4jC~azFq~xi(CPm%}la-Gx+Ku~2}?!Mt~lv9a5Vu1@DcX_U>b
zuuFpSOWch?R5P7COBlIIrX?glHBAINbuHYs2lgU+CdZWahun1IL}h|w1>{(gmH-Fj
zDnu)|yiumVy^*Jsp{G@1zQ<8k-=3DSqmmK-7(aACpyK#G*pGtCW|B(Sd@5^0UvZ8xL1
zBRlyP8Z7>piHBG0D|4FT;IcgTc1?P1BJA%@N|KV(PR&@PS9Oc8NUF;NoiaG=3DKuGD(
zr*QTgGhxH!ZVty9*I5M`ivR%gU>$pOJxvNe17{(vhY3er4kQQPcO#R0b@v#*c_|R=3D
zb)D$5%bzaxO;|6nh!u73p9U51-KjR8nDMe&xanSRL1CkwJ!Iy-cu57A%l$TVCC*z|
zh~vrjPfpP4b!NcWPFC=3Dv_^Z{IEVO0wry<O<e<SewEzW-)UUWg!jh%X_q_luAByV#n
zM3(MYczW;RV#Z1w``7E<_m{q{Ba%k(FC)hKXW^@!O4}ydxFlU~=3DTzY97Uc9Lc5al|
zSC2dsDeaGRHMF;WQJ?j=3Dhi>pRm3XQXX#1>W+jBd*6&=3DG!Qrvjr#2#|lt>eTdC2A;9
z4Qa}I@6&$Ho&^&Bta)VaNKd%!MK_d{QQqjrOuf{(K526blVQKor*w$ABG`t@qh`vB
zmh{SL)Mvr)SGj3AdT4m56=3D_xC?fu066#i!}N^*nc+P?HnleZV~sP$+xfQE28Z`h0i
z!^EF>m3$goYYjo>!OCy=3D+gae(vO^dbP8__iwsA^l-<!RjcW~E4H<d#$&*JgUiV+oa
z`%Pm{a>^+_lqjF0CvI+h+8(d%_!VsYJR<ZZEYp?YjybrqVB@efJotvAW&RHl(@4i{
z__(8XdHZ9yDMNd`G3#)nYQDTxx~N3%ON5+P#ImC$c&;%c6p;`XcaP<~RZKTsyfB9K
zcFX1UV@Dh8wNDP}kbtCDFoNSud&OO_2-&JMLCJ@?iB<J4Tq|nWrpZKp$gM+GmqZ9N
zzCL)slly{(t!wtApJg#tB&Nf@y3!o_(SC1(Gz6bWs!sSNT~!B~qNJaNM@^kDeOQw0
zJDItn&nSQ8saB&hc;@w8Up9f(pC>jtOPC%$tlOR&c1v75EkCy$hKrE+J(YHKvmBo|
z625jxr?yxJT(6AZEsS42+wx$OOm#gxDSo*y3_G%nMTU7bxot3D?iCgeaMFI<^9m3n
zqjAt-tp5?vDc&*R_7bJUerHG4n|0OUi(NiheT9xY?-<@cV3$S7pcL{rcCy*~aiZ45
z??!X@L@hO4<nos;L|y2n+L6fi@Ai=3D&s5PAxM%&u{0HwgiZXW*^jG@=3Dkj>B|yXy8`s
zVA+FE(@NR1v!U><7np^G*1z+x*7LNAJoY5sj|_jKJNDM)Ia^t<9dvkcET2?xD6yBM
z=3Df%aHgHR0Bxd#`Vs6je95Ph~(0=3D(Y3m=3D$TC$Lza%O{czU*o@<BjtA``*c+b=3D-X=
2m{
zO7|yYlr4^#Qrt~uJh>H}$Bz`FM&1kW-gTA(jh*UrQW}IQH(-TSm~dz|#-1|+;TKW6
z@y9p0I`TZcgfB!Gq{E>yq+LVDKiN%aiFlb@dsgBE_<ucpL|2yn?HK~k=3D#)97Lr571
zUT2cHWQzx_{btA)`k_A)8aveT1d_}+B6cuT{&Omk*Wtw7xauUF=3DPIT+G<%{2ErK<y
z-13-N9=3D6HzN-0Ak{9J$8lyL)fH>?Moy_4Vf_X%x)^W!X}F}s0;PK@Mm=3DA+-gTPBJA
z*@wO^d|{{I-?R5C*vi3r@2)S;@%2+e4Z@V6XFR#IXPn)|@6+q&NR;c@5+<fSzI=3D;B
z<MB|`0PgY2y|%KCVV@b)2*DaY&0}Xb+jk*>=3D5=3D7^%NegF_e2vPu839TH;NQ{PiBK%
z{ntKMu^$1A{?})tU=3Dkts&N74T#f6n`mm}K#lrpt(^JaRVnHfrx%Nhm{E)*9=3D&^uR_
zDy4iJ>t4|jqtXAm#UFc{IT~P6*Xx_w<nV2~6Rc}h*X5CPkHbJKN^F!}<&JYwG|<(c
z&Ere7@Ufa}Hh{ITTl&Pjp_Es|DD3-$U1ye0gRaTfWgm}6?85L{V4cxGw~F&X{6gm1
zrCoVtXm%<#VxmOa(5|;s(R%wSkKhUe{#ms7{TMpotI@)6Epqx+94w1>3D@Mjbo#!Z
z>9-VA?I0n1LpGTJ=3D;#az$FcPv#!rCT{wr%?48K-|Ay}GExIzYHBki|5+r-<okNQ74
zS}F;;j5Z=3D&ekXldEu+!crYL0<%>Q+V=3D8<=3DqdiR3=3Dz%q6io`)20w5Yh2s&^moCy=
Ha7
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
M
zl?hs`CGW#XyGTuj57q)l{px8lx6V+L$M5{@Gvl$Ldz8?lGtp|~VbN=3DO^s%8SdrWDB
zHMzYd1XI>P;!=3DrSfTk$CalP52^`zZ%xh>rmKcl5ikgYwAlTg8)5*bv%lAJy^4ZFr?
z08jadx{<J96o8LD^nQSc%1uh!&D_Mzg5S)=3D;@tq)S=3DqRlSUH*4I5b#U`PsPnIXM_u
z+4)&nOU5gB{)J%gXb!UU{;vshN$9cf1k%4pFyps$bg?&a1DH5D*@4VV+(3>FEKZKD
zZmwo7ASX8smo1uiEX`k7Cs%$TNX^1k+|k{^9OPgn?&t;JV`Jv!<>B%A+j8+RurjcM
z5mf&=3D(nR=3DAih_lQg&jc5+|ks6iG!JyR7yo%`mYW$3>LHKJC5g{ICUpSHwi~OM;9hm
z!24MxGgk{Y(!W_o5{`~`8t<o;j6S)6>_BebMjD*#q-^g}ti^dl_U{sc|0coqf0IxY
zlb2GKkbak8=3DOAVM;kIY+uEX|kI_&?Ij)bF&1t~i-2OBBtmTG0qJDK6%$Q=3DI%SxiRp
zJ(s_E@3CK$k0rd*82^pN`Jd4K%G~uIIaBYmMZfci{*A{4P!UtoP*##6W#i%HC6#!>
zhr@dZviuv68}L3nGcPCW--h=3DuL;A1OE--b#JN55p(8b)6U(C)8fI#}M*T4LRX&&o)
zCt&<FmaCg2$e!OCz{AJR%=3D-7$<boIS?nVFKUUvtO8$iVo<lyFt7G;C|uT)O}H{1WD
z=3DIs^Iy?gooK~=3DM`<TrOTbGNr}aFdk;yq{uYHV2vWOSAJxv$64TvhuLAa`UpW@k(>E
z^GQi@i?MOCbFhnZZEFp@pP>7XA|MA>Hxmali+_rM{vSm2rC`F}Ma2GhB#tg1E0BYU
zo#ekqBqjOZN5sW)TJkPN`<K{z7W@)_*SO?A>ztj5m4k_$TjRaRIo>~<?`8j9=3DNupO
z|JoS-F2(=3DFadgpmua19|7pbhBox7`>i;0_~3#o)U7c-lr<u27bh5mmIqiEq~^1i2-
z{1*fLwZFU%M8v@R`#%P!`1gMD-*d<kZROrMf3MSfaEglj|H-UKbNu(SLKWi9@vkDX
z|H(T2UqrqnHATFO{Jl>9h(!7Sf1P6a?S|jQ{@yCz#WYl`_<<&_njlw@shx$ghlPui
z%lk77kT$V%weZFp+<(VX{ByGZ6|3Q5;^69J;$q=3Do=3DKT*izrN64MS=3DPs;7TecRu--=
R
VHgNE2{ksbwE2Sh^BW@h>KLG1QmQerz

delta 97
zcmdm8QanK-nu(c#fgx$G_$MI68Q>G*dH~31VEF(4f7hQH4j^0A)5S4_<9c!gD+|w!
x4mMUkHI7Ds=3Dv_wIU5Qy)DH1IV#erKH873Z4jy{=3DRwh*X+!PC{xWt~$(69A<H9wh((

diff --git a/gitweb/static/git-logo.png b/gitweb/static/git-logo.png
index f4ede2e944868b9a08401dafeb2b944c7166fd0a..aebf3374ab8aa9d3d3602fd=
7d89dd9a0dc39a486 100644
GIT binary patch
delta 1967
zcmV;g2T=3DIW0k98{7k?fI1^@s6k2+Yb00004XF*Lt006O%3;baP0000WV@Og>004R>
z004l5008;`004mK004C`008P>0026e000+ooVrmw00006VoOIv0RI600RN!9r;`8x
z2FFQ6K~!ko&DncwUUePE@z?XL9lO%4a~m3PfM!$3FgioRrGHL@L_<QH3YiyVFlUS;
zcws;k1usP64G|;45R4ay=3DpSaOx5R*G8Z{~;Kow=3DkW>wsVTkTd>ZP)hkkMHlar>D=3D=
g
z?J~c~$#c&0`<?Tg^FH6p=3Dlgp~TCjml8=3D#DBxCIq_9N)nBvYn5$a=3DBw>UF$8ut+)~=
k
z@mpMtCwqEZyMI>O4B)&QpTUdL(5)E8{R5jeRQ^vOb%~d_Fdd(V_u(3h=3DRi)gBEWJB
zKiVeV$d__(U?px(;K~W)@wU@*a57tm_QH4ba6aCQ3$dWuL)W$3124i`(OG5MiUf}E
zq~jfKeHg*~+;@9$v@mZOzJm35CPCVppHSC>5}bMI0)NA}9>1zFJ%e<)<L^no#GUv%
zp2x%Zs_EgiCT(qMI7_JkoU#b3n{gLz!^`n?;hNR#AhzQ><|uI&b49&Go15E?m*NCG
zheK7K{nPkZ+J6SG!@h=3Dqa&Wfbiz2Ls(gia}AI2)2n?C0hQnds+M^?geyiF9CET8Vd
zChSkg6@MI>2B_dUUobW24B?X^l*WZyUL?x=3DNpl4$!6{)a&cQ3weN@no-RWNPb`(Fu
zDWaqo)5jAc3bx@rc$M(3{P}(9vxNU*`xHP8;AHl@1Z6NCm+?JZT4ip3g7ocXAtg8+
z_z<oVVN%W0E4lrW2%(KQ8~0S1|6}1H_u+~r-hb05E}NiSfRlw)HCs?1U%|g>%<U8*
zd4=3DW^_X)yFZxRVKgEJ~BQyxl5c=3D9k_Nc$rqOe%%zj-}6kV3$bVc^eU)xhri?VX#zy
zbCvL%<#irlL<q&(a3p<qhInh|)i|dg*Wp|0cvAA7H()20rmu(bAiC3jmk@o+()i=3D}
zgnuZ{e@r0O;SRh$clmCScNPncv<08djqesRCZB@_$}Penw8iy!4VK^%Q32kowgl)D
zUb#hMPr4`vhX{?U@q@H~qo|^porVGYUgV`=3DJelsPnjI3AYM}7_Sc0=3DJZTm4?7CNU{
zIGMF4P;H`2UYBlY8-6Oe=3DL{f~L|EmmCx1P7R^G?cix^Gg9oX2@8{;_%P_;tm=3D2ROm
z<*(Dz8=3Dmuie7*%ZOvZObDD0bXt#H%LxIhTTJvAU*uC_=3DWD;%Gg?c_@Ts>1n;ixB3@
z%AzapoW(UNBBr;CvOFjfV7JIQMeD>zu)4;zo+^B|SqQkLX**xM)N<~e-E)Uzs(-b~
z$?sWOyXkWMV4b=3D1YK(P@Bz$T*K11Z6T?xioQ=3D8>y@$+K^sEm)QU8Y;H4)L}ZrQ=3Dg=
X
zRVdn^=3D>GQ>2U2MK2{+)cxuF$8FrHh0vrmNgv&RZh8}1cJ@b<!ww`yg45ND=3D`I|s!~
zJeVHn9@BG8W)=3DKIh`LjShYtw-HGfYi-2?bFc8DZiF?*Yj_F{{Zh1dfks~6XL>cObC
zzfhF@YBnfVAHRmtYFa4W++uu6Xch^;wI&7X5dJ9|(D54A$Uqmtk9Dn|@YIpQ`08};
z-%l(~#({FW(F*Pt4d{Uea4L8RPvbvgDPgq1ISt_?D+xXI0h4NdNF?c3h<{M)NH?G5
zqH+ODCtfW=3DJZ~q7He^+r`!~^VWwrpH!z1{G=3D<BYT&;m)9l<+R~!>tc*!k=3D?D)UCF=
P
z9u!*Xt_E;)t+!C<sEswIjGJsZjtDXLsOa^2()f)+mz`*8AsEMDd{a2W3Zd9*E!)7;
z6XB8bqz6Q!Sj&^1OY}4A$A4dD3n$r8p`B{wl(NVbOGHSVg{`7lzBtY4NE?yovaOP!
zWqR*m0{L(PH=3DgEXz1%~%x7Kn;3GWo1w6ZW|Ki-1hq~kThgU*^IoGeVv6lHyF!xN_3
z4{=3D#KZ(W^veWESNtV2kNlN0=3DZiz3s9BlQ-{>Op!!EE^1^ITx5J-G2`!ICnP-CjrVT
z;VmLrKPuLf7K!FG^N!Ub&*atrAJTm^%Atrv-OQp~qb1i8-hnSyfmF+81SbJnBV7Jv
z!sWM`uEt9uf!`piU1pEt!k%9JP5)pMR&&ulmy^CLa#Ay5a>j6ytu*-}O2YM53OSOk
z|Fq-9A{6u1n|^;zt$*&{KFfAKW?<8X3=3D;J{>9D9EJ7x%n=3D;59h$+RS1%o|0o^@6BM
z%SE0!J$K$-u>{gcZnSKrW+vsr?d@VAst75Ab2r9j`cFp6L0iRw+^Qx{sR+-xSrm%O
zTz2wJ11dn;EIcXe#s@@L?U)Um1c(Uxvqc~GTD(M*^>&kGxPM=3D)KRtpUNwQ<E;j{#(
z0O?AhI_HaubBCFSRW(SNEfFEL)Kq0XkRVO`Q+h1m!2bXqM+Qt3My2ck001R)MObuX
zVRU6WV{&C-bY%cCFflbPFf=3DVOGgL4zIx#ppF*z$RGCD9YSCq)E0000bbVXQnWMOn=3D
zI&E)cX=3DZr<GAJ-HH7zhPEiyG!FgH3dH###pD=3D;xSFfau!<xT(q002ovPDHLkV1iK@
Bq;3EJ

delta 192
zcmV;x06+h*56=3DOR7k?WF0{{R3=3DqWiY0000OP)t-s|NsABU|q1UssMlh&dtZb008Ld
z=3DJ)sZl?<mx0001TNkl<Zc-rli(F%Yd6hp6fOaK3mORa}A2z1~>otGhl0|P~i$)-sp
zEt!DmG!4Oj(E`y{=3D&}QVPE<oMZAOGbjq8K~(J6VKR=3DYOWiaAhdQzvR_-0Fd8&sT9o
ugv{4p|FlT-iyR_Gg(r(V2yhzd0>~Xlh6EoVn%+|Y0000<MNUMnLSTY&Tu__<

--=20
2.4.0.rc1.30.ga4238fc
