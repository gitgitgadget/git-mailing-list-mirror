Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0661E1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 18:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfAXSIO (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 13:08:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35758 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbfAXSIN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 13:08:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so7541758wrb.2
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QCX9L9cFenN1e/HCgZ+ef3P9dS/EBc7908tq5w/ROzA=;
        b=ao9AKip/7wftVGfOrOZekgGuq/uU6nDuGF9lhmV8+wNBtTy5j+EBQJwHnDs1PSE8/F
         EtgLYLfnqCTov6WYnrgspWOPxduo91yMj8RvV+F8R52+EdeL6tEsh7eH+fpRjp4CqzvD
         QyG5ahpcciCHXgj5pMlozlGoHqJBfHebQYciCzC/18zAcz8u/dViUOMOkdKD+jMNRrH0
         7x5ApYL+JT4tnHWi4GDjPHMPVRDZmafVr5A/8QIr1wIEpSRVCDiE5uBGqiafFxcx4wRv
         3SL1EyXmRP0fAutboQvHOKD8ubrI9RminMvNt5Q1NW2WcSrKmu5wOS5KlIcVSDffiA/7
         cdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QCX9L9cFenN1e/HCgZ+ef3P9dS/EBc7908tq5w/ROzA=;
        b=s2i1FxgpOK1rCYD/P2P8uI8jdlnZHw6tfWi8IbHl2vpQsxclxdFKAFw1O+q4x8yjIx
         85kJEi5JCvgMoa8sg+ak3NzDjn+SneAe9kQdgokvtLnXt0WJAlZ3GsUV0nFJ/iG84tfF
         nuknFFp8tnjYAsAL0GGmakJFponHwO+7FZ3Ye02NMZ/GiHFpvNBK64xlFGz4sPiMGXZj
         Iaa5Amk96qkHBs+bDk0Mze0gnvyFLHWH1prm5EcPeJzhsxQEL9LNd5E0DFvr1MzCjKWH
         zOEXkIKHTv42o7YJlVQ/MNPS1QmOh4aAcev8iGGKD/4SdlLlrIytSt++UjgWcfSC/zH8
         nJcA==
X-Gm-Message-State: AJcUukf2ZkymBOR3JAa++iOe1+vyM0SUSTlmZ9Qzvkm2qnlqtlQNUwnV
        dGZvAmOjyf/A346P3DGH6EfdpwLXX+E=
X-Google-Smtp-Source: ALg8bN6MBOccqYZgXCF3f4mLGwy3b6h/LenYeRmC+Db/9bGiG8W1TQXZ+/I1iRsi2vC85n1sr3sULg==
X-Received: by 2002:adf:c505:: with SMTP id q5mr8001967wrf.84.1548353290934;
        Thu, 24 Jan 2019 10:08:10 -0800 (PST)
Received: from localhost.localdomain ([2a02:c7f:725a:8000:d453:e483:8d96:f5ed])
        by smtp.gmail.com with ESMTPSA id o5sm41090289wrw.46.2019.01.24.10.08.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 10:08:10 -0800 (PST)
From:   Lucy Phipps <landfillbaby69@gmail.com>
X-Google-Original-From: Lucy Phipps <landfillbaby@outlook.com>
To:     git@vger.kernel.org
Subject: [PATCH] optimize PNGs with FileOptimizer 13.50.2431 (x86) and ZopfliPNG 1.0.2
Date:   Thu, 24 Jan 2019 18:07:55 +0000
Message-Id: <20190124180755.6124-1-landfillbaby@outlook.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Lucy Phipps <landfillbaby@outlook.com>
---
 gitweb/static/git-favicon.png | Bin 115 -> 106 bytes
 gitweb/static/git-logo.png    | Bin 207 -> 204 bytes
 t/test-binary-1.png           | Bin 5660 -> 2603 bytes
 t/test-binary-2.png           | Bin 275 -> 217 bytes
 4 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/gitweb/static/git-favicon.png b/gitweb/static/git-favicon.png
index aae35a70e70351fe6dcb3e905e2e388cf0cb0ac3..673b438c678619fcf9cca8b91a20ade65840e411 100644
GIT binary patch
delta 87
zc-kw@njjIx!NkD8Fkxbb8IUscba4!+U`+nuuOy)-#b;n}K!8#2q|}R-nQd%r3QR^E
pMUo0N5=sYDBbhV(q_%i6GiYATz5Kl5?_{8622WQ%mvv4FO#lkc8KVFI

delta 96
zc-qS<o*)s;#LU3JkTh5P6OiHz@Ck7}0Aw^U{Qv*I>rV{_kge+J;uyklJvoAvh37^G
w8!Mk0N25UWE+g%(#H_3oi57<9z^#l76OSlIpUf{?2-Lvf>FVdQ&MBb@09t1qU;qFB

diff --git a/gitweb/static/git-logo.png b/gitweb/static/git-logo.png
index f4ede2e944868b9a08401dafeb2b944c7166fd0a..6a0d03f605ad2117fbbaecbdd0c5c909d79a3e55 100644
GIT binary patch
delta 140
zc-jGs0CWG(0n7oANPllhL_t(|+U=Er2EZ^3L@&9l{r^9nbt@*&tw*5`o+yt{ElR~S
zH6l<Upm;!o`GU|69gXA!Nm-~%u-Zh3jaz-<kI)ktTaC<K8Db+_9O@%q$HS`)UB!<f
uUhHRNG9>y%%n?P=F-N!w@Nj5CH~~Dc1JS@nEl2<W002ovP6b4+LSTZ_wK^IA

delta 143
zc-jGv0C4}z0nY)DNPlukL_t(|+U=Fm3V<LKL$7yB|NoCmt%o!Sbl^jsmmz}#14WC;
zrb#3%nSkgt4Z(lW0?}6JvIBrlR6{UrMub9*>x2Q(DS4k(yEfN~P-s&pYHHl-foacI
xaYTg7*I)m%Nc4*wB1VNLi#!N$8tDSa9Y=-)A0V3EQvd(}00>D%PDHLkV1n)EJktOG

diff --git a/t/test-binary-1.png b/t/test-binary-1.png
index 7b181d15cebb4c86a6ad7fed3dbf30ce2223b4c5..01ff8b2df92e1a3d7245672d249613a250c949bd 100644
GIT binary patch
literal 2603
zc-jFg3e@$9P)<h;3K|Lk000e1NJLTq006WA006WI0{{R33KRAK00069P)t-spdj$L
zSoF}4_~*y_|Ns9`5O@Fp04NANco?+5zrTQhfIvV%002P0|NnqMK)=6$zrX)zNPNFQ
zK!AY1zkq=MzkvUMfd9Y0fPg>%0D%Ahzd!&$KmY(hKmb5MfB-;106>6%zrR3$zd(S1
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
N002ovPDHLkV1l1d8j1h_

literal 5660
zc-lpG1yoe;^Zo)$N(e0J(p}QEfPi$DQW8>2hjdCvBQ2c^N=U=fEQ%l<OE*Zj)FMj$
z_VYjAbN=_7_s)Cf+&g#PnP=v?6Q`@KLPS7I0001p)KnGq(GvdO!oxw|WyWxX&;rL=
zLq!o#3}6JD5q?UcKx^<lR8719fafg#Ee!uJvc6~~uD6<&67C!}76@A+ze^|xt)lZ*
zGWJ$*cXhRM^9Cq*+F5zq*)sY$dOI+_a<F4mQPa{rwPkYy04T!L6y;y}FP#*)x`19U
z4?K2;EPnZ}m4_D*|7mH8Eb&57u38Jik~sH^?kl_U(~Q48dvnsHNa~{}zdt5Nt}*E5
zikv5GD3NPue*dxh7f`vl7%RR~(J)J59p_3~+O<^D1-DxcdEsKe+S1fy4;}Avtqaw!
zJo)YY2lCCU;K*zbVvpIWj!VXv>ZvF%gb^3Uo{Hx{HuQcc9lxw_w{~z~g<>)9VYESF
z9Gq}_*o5t%FVT#8d*scY-TdptZBgpXqn{gtNC=55me$ro4Z(adx7mm2&Hfc!(~-Qt
zlU{8#Y|nbzoE2hkeI~#OrBwm3l``6d^zzd=F+P^lx+@O&E;?8;eo8OsT?%S%b8B~*
zG}a>Ic5(kKK7O=yc|w^zJuA^l_j)6D1(1tvTZ&T<&$#ZdQ&@QxfxB=}TA`O+BX`18
zoaI7@6~>nAxoZrLnKR3oBJb`Liv;6JPVcvuSN4KNp)g-Mhfdn>cnfGZB?SF}95~6v
zur@(awR4tHWfd_F=|5dTPk7CH@n&i<PZY8C!&k+SpK={9<2OdtPjnCOvk#0XP~#W2
zDh43z63*QBp|9I;61|oSFanuD)m+pZh@rl}9S5VmXxouhOk?po7RJyAZLNouh}_v8
z;8<XKOE`P=DNo_{#?1P`Pc3bdL?`1*%~M`f&H6adt79HM!qVi+J3ALxhd3{k)`?Mw
zU}U6CG;O3xAjGQqk?UBY{VhB$Q2-sMOc%nS=i?*0@&Ovnu*vbX1DR@`P>XQWG}h$@
zWn_hXQ+PFQ<RRBRd!YqHMq6yThrN4UM~ni9k*eC4*1C%cr%B%YNnO{{GWWVT!2b^I
z*D<&2cVR@+8QL97e|x@qY<U3@!EGE7l57OoR!-cGKZfg1VVzg3WZ~-+iOM;}VreJ%
zjUr_kI26Dh;kXA>kUA@wDl3^L&J``Pn(?nZFWt1Ns|s?w9}a2q8P;GW!(YAKPEFq3
zD~QSuH?dQ6PpjD7YR7PGVJexd*t42D3^uJl<8<C;QyZqsZVGS|X8U3iE_PUe`hLbT
z)0Np1;O`)+kdlzQe@7etOpDLS&YWxJ4gL7ef;LDgUy^dKMZc}PZs9_dEN*2j0mey?
z%OGj%sJOigLmRAIcutmh(<nD|dJdmGOTu@^j22B_zk<ITfN=4foPgiwCbw~wNqe_g
ziD$h`^gbUgcylG)?qJDhqID`{v~0KJlTsy61%dApwB9E`{oMXC-RGz^@+Lp~X=2=9
z?WM3&ddQq`!=|P`KHf3i9JImaHZRn1cxaSurx*E|vy86Tq=Ii&A*i`Hzt!KpPZYD+
zvOt;fY5k1anA?}q^mMb7=}xPal(k4xJrEERgOiqi#fjII)<M?LKY+-o)33LUD^rh6
zrh6`}!*MD00)2iqVS(F9)uMq>si$}zvMamMcW)+jS7OOOsCY0vH0?T9_fNz#+g$&q
z1{A~LGkTr)5n-#He)e}EmX-{d;bCr?_tR@fe+H1y<n)WC;}`Vue0N3EZ}Lp&UV*R$
zO$tT05|qh3AWT0Svvf~|X$w-G5lf;Gr!(ZCu=)a;HAB>nM*Vs6jX0B9nq;;TsdY4=
z0&kgwn|S8S_cFf{8=={nb?*Ie1M#)=7<A#c6pp{5sO?F+ff#fKf%GCPI18KJh|tcC
z1={9;Y4NWJ1024&^uwn$)|;7ZtIAtM;P&B?WTa-D-(2i~XrwJQ5MjA$*bE944|ZcL
zC*<ij*%5XXUe$X-V;qZ598~o{OzLEqC6RKB06h?$D_BX7am2IH;2*qqu%trDrOAJg
z5YeZ{f5M6ELU@&Jca(6Zu*SVfw#y0ENCUn*cIW;mSYd7zV<p8CzY9c`STV*kW9m;0
zeU_r-p_3(xTd=s^B0%z1qU~mHZ2FKKPJpO543$rK2W+9)*>s7~MEXg}H_oi0c~=6$
zlH0^0tscGKY3xg=n~1<Ny&Xi&4OY^(ArGYwT5d_u;0h?%3DNP-n0FV9bknprCT>Sr
zLt2Y>Wpqe^7^jcxk3xt!PF>ytwWIeRqv@2D`PhpC`V-Q0q>C7YaCxuo{YIVom20t1
z#$#GTW4u`P^L&ii?1-49eZ&j-7<|eqWNy#0D#@1`tesSL`vxs^giY|oshoqc;D8=8
z(y;|aB|;!${NcQD2iJ#I3ZPf1+>P*U7w=Y>GNIX<MnpPI2FH8@HhDRgR&F0xXh`XU
zS=9mu8L2l%QCf*+oGX-^!<Ba<)1-5OW?t$Lc4Eq9J*GNHqp#m_z4I1)k`WWvczjC^
z9P;M+YWU_HLNT1q6qCxN#-ES8Xt5~Vr@>wtPgS6Dl9v;4dT@9Cf*TM*sS*yQb2<j6
z!6}Kmyj8W0E}t6ZnX1V^BOp!+Dx0&r@>0?<8F?+8VM@--TYFwgjdmZZiB%7|8l5`N
zBx2Y?KE0Ya^c9KTrCPSTj#Nf`nS^nB{a!R?38;*G#lKw4Nd_93*XeJq#_h8|ddrRU
z&6nJC7)<4}&&hY77N@Q<nt$VaHQYV|%~xshH>5-~ZE}qa9V)9?%gU|{3XkN3i_tFU
zTmqp|>XGL@dRr_CIH&emGH4pi>+lt!9dnRVO8u45?jb^}#7ZUzXB0*^=a-K%1qUAV
z15IGxpM!x28A-U^;(7j%*OMjWVtXC(V-_V41Ha(!oTgoV7Au~M&QmY2L#GhIkiCzh
zsFbcJv&~I3$Nk{%*DrazGBrz6W>v^L`Si4j1sA(SF5AJ<MZ(#ROpyaF;)@QLK-io|
zLC<!<5GGmNP}rGt>MQqb(V%P{r#CrKy<~_oIXN6gyO0M+Q_L<6x2+I&vgep>E|)bm
zbZnL<(H~93gQ*lUO%2|Ge;89$B^r|_+}QGztuK(ZH6Z0uJ=IChscAbXL4Sbb#bJhk
zBSz2fg&h0+)E8EUMMHxuC%cAFR`bA#J3%0PQ1YIf6sSn9hsVWV(kAwd;oG@f*ymIN
zuZ|z%Jk4~!1MO{g2;^<3_KF@zQ_R#8J0zszOR`%&XCB+8a$Vrz)%8}3rta**npb3X
z>eI1ziAn6Yq~#j-l^K%{;@TE96`zXCJ8!QD&;qz{<kA>FPX%E{0iJ7sC}OPvNE7&k
zh~%jFd=TrPI*@)j#Kz5&mXuLo=G|a?g#I1XB$Q*Ykx=P|rxaF>ZjmBI5pM$r;+Yd-
z@g@na;<|C|Luk`h$r@i0athMKE4vguWQ$oO>x_$#>eS8Zg6uq%%UXPSca7e{2Zx`)
zlz7<{^uq*m`G%yCHXO&Qj&Dt6PE`5mJ)ilT7&59g{!S?u6?Eiu+rBBjMbj#$Iyq+e
zF_FwU#UXH6V|f4sXlQs;Rd;b=9v2_^-lgxbowIJ%wP!q3V(@lEwJ_qV#~|Do`;E-d
z`ry{OF*s`4V?^yb@7N_@*f_`K*reD%(2dz@nei*&Y5Mb=&YmW|$qqXkwRlh2KsoK?
z$)^fJfhjKc;GD4WYoXEa3;lBrGn5rdN*IbcxAo=PrgPU6!ZJU`j>(~87<@1FMw8zY
zgk|$8=%rD3=r>xg3tMR!lDMLV%Ef*%s4jS%eO$94^LH{jkW)@+rUz|jo3O<>hQ4*$
z+=X>KHDHS2cuP+{5n?}d9PSk(=oH1^mK3=45)yqVRStPU!a<6{8eLH!iqWBbE%UC!
z6#)=V;JY(apqt6FBOkq+5kp2^h5R&LH#(MF9;Qi}%%FIrGtMF1H~Vya{sFp@#%#w4
zNeF1_lXp*}%jXv0c*d!Wf}*A_KD$I4O<afpy|sgwH!~N-JcZWIR`<@Zk?cCIY{iMH
z>d%F^0GI&KP$xx3U{!stV<-AEh3)?|4`_I3aLXwL@07inQ%BWC0IVcshch0%XY3}0
z*kZm{ic*_(mAvv_uYT%g*4&qYkrp?>7E^6E#66wYIW;E{7Ovi<Q8LPjFAE{7QX1VA
zB~UA&{hzSK@rZvYVueD8<W`}vq3Kc2ay7xcKy#KGU(7Rd&NZbA-gHGNBjstS@@vmK
zn*mjaa6w=F)b%thc^=_mv$Nbod$=>^SBp+q+oax`M#;U=PA=@^dY4b~WtgEH(xMux
z_2iq)Z&(c!{MlSN@i3VoKD$FUKt&@1dMKFtGKr#DklirpJT?JAJz{!a9Z0mHOb2%g
zot^VC+D?{Iyc=!spR=LO?{L3*F(x6QAlDQq!NK9D9dM#4c-A-JfD%43&!g(=S`PQ)
z^XpJ(I$UYP(%KXjqW-t4h?nopdMMKn=_uX9R;*_5^8e2T{}UKm%sY`61%Fv!n*epn
zJ*(Xs`ABulK@!}-3j@XT9$@qh`QOVuJ=CK>1XEs9Ukir08EM~-*{E#GtmL#|X(tmh
zK=I=MY5wonQolz59PK2}Z!fN+G9)!F>unXNFP$zbuT(p3PE^4KV;>~0uVSymh}WNf
zZxsK*>CE{#lbJ?eXIY?oNhr4G$(-J{5LbSa2uY}Wk-R{<W@R<(DS8`@HnoD=v3ZUu
z{rB7(w5p0vo)$o{O5OK?K}Y517WQup^K*ZUua72?Z!zrnROcvo@rrMXlroFOh*0@o
z0*uecMVzq7{A&E|a}UmXLCB3~m=&%}6Pk?^2J<Z-reKBdG{sp6(z5Iv+aOKEabo?w
z+=NN4$|7MJ3%4_;2sn@$CvYfQz$AA&`{M-^Z+|nMu?CO^p6$vF1{ncQFakH62t-xK
zNAUcj!wM}`)^fJHK6(rgdRIuuz4l@?dZnKeqx&w5AIX-04^2zZ6}}iCM2)`TI@R>l
zslIE70kgrmRsY)xVreaxsk+5y$i}m%O0r?*D$1p+77}R<0^4D7OCN;D<0^xSt6Atx
zGwsm-m%WznI}D#Yj%4z2a&!Nft9gU(koI`B7IeC?)a>kkz3Ruc&DhRTXx0BSfokCX
zs0x{IWtQ~6`E3y9ze3?7N&@q`WsCx|4tu6Z98G=E_<Pn%GP$;vblQDOO!eGMjuZ4_
zOnm+0;h|Htc_*chkB|TDNh=4!Z!A~T8169HR^;R7SK8bxy0u<aQxnCA7yY{dfuJ)t
zH;*0IN@pL>0TD#i2mkY234Oc=d1_LeEHq%%bzKm=f4uiwonH+)MMwmq_CFWJ^jev9
z`ns-6lxgKf_w<bR*0E~6f8Sd8;%1*k`W`i1CTrvD%v0#UiLVn0-iEo(pr5M`x%DlZ
zcj`IL!r$57udsK~mRtVpy4;fZAz-pZ$-%{?4~s-PY_Z9H>+avBMDSmM7Pr;-bPgS-
zKodZ2VO>)bdC;F@nrmSty<*Pz%Ak<L%5q(O{fOGy=N~_Q{QTg16XH-=U;h*xT?KP<
zx+rjawL!Ty?CV!<3d(8=1T918onU-?JUimg;cS(0r!U{1({=YD=i$cuhzW;5c@yHa
z+O_{qJ?gje4)@RTVky2b07O9nYi_1!U4Jh{lk@@4;hFb75;k+4C+@B+Q61XS2X~yV
z54eO1fiX_B(19)Qw%2m3F>6mFRFMlZP*6~)JhdOsA3_z<2t!jg?g+j8{KSWchjk4N
z#l}l_el$ZT3TqB(u0CfRF#f~a54rsVYi*@MAP|31(>h*<rXyMWIw9Yj=bx8d*LNpv
z>lIJO*dbo?%UT=_aTIBWtWQlv81t6h1}f<xr=~V(I4>?9AXqk=`Vts2*jEcS$ySSv
zc7U*r4XbL?W&$a{-}&$oF$g5SK+4a0_UmhEdip=3_x#57Z_VtdpG>R;9`Sw3$}0W*
z88|jJR=X}$16tbNK*!+&8cX>yL6k<dW<5<4FB1IL0&sbZYBg&>?;rl{?H?Rib^p$?
zd><$3JogKAFx^p?&Z_1W<^FK@&%xF8XUO$x`R#+x(cBk;FNQUyQ8zb%uU@}~q4Si*
zZ`ogIP=0pOx?WOO=e}}l5qj_AvQQr$Hm;PBk-<cn0E59WIJENt02B&Ejp<(kfj}C6
zRF_Ye>y(z3vhX15x^K9N>7`@029j<3{i$(@!QaENa2tI$`}_M>u8}e_G7Fu4{IwPc
z2$$Q;vpMK!cDM>d2<QpbbJSh4P-SBy*?RCLQH$$xbY>=HzLcN#rO(dJj{im!)!CE=
z|A9qaZ7nfF@EOMYe>+qLuJ1<pS_Nj!|ARznDOMfg53TR<f?(wmKeo>M7r(o2-K0@S
z1>;sXI=9XfvH9>8L}qDM7g+Wlm0p?0!_Uu<HGXl}Yz#^scz5^rUGU@mwM6KHGywsD
z$F!EX)xp#k<1T+evN&Kw&-N#F5P?bI$_2W-vpi7ydT7{eCCfg@$;)Hxj^)J+538>P
z>=k5-jpcB_0?L9v?LBv_vq*5{9Gy_{@e%!6RV5l)v?kBZ%`Ht1LD&70tE;Puy1Hwn
z3VSJJ3<*PjcgU^Bzl$9;g-*!lClLaUF;Nis?S`r0?D~50USW`%S!N^}Z0K$hi_WXb
zrQgA?`cG1USEhj-{^!g~OG{@*b>Fnrmx)M7O6%%KibDR-;Nalsb2Vw@iIL`f+Bqw8
za&po)Npj)l<NMk30aws@j#nsOZSqI_nDt^Ih&bkaGl9PZUC!t%+lpKu*Ji0KgToO)
z*G^@}WjaMk@$m$)C9&V`Puy*JWwGc8qC~z;d~wG3o-gTjc6T{J?$}Q6DIy|*p07bq
zD0#oLBul5I&ogT=k(j@J9ksT$mfuYo#~#J{A4$^SKwe}sI;WbE^MsDdkzA1@S+Dzs
z8HADO(5oA=wX+*OWQYHLw2G`&_tg4-jU5Xg^{A?wZWi`$fRvEPgIE&q%UdPCTEo*!
zxlI`8efnV4_<ZOc&BpjsBo>Ft`7-In6zd*pIaLBpqDxpJ0B<ppv<$VRAx`(`@E6xt
zc!5itD8|LQ!WOIi+rU1HVvJu^d>`5ZGtsZzdS4xLb}v~=(+XgtenkPTAH66_=N+$7
z`YcQ5(}RgDR3)(Bw1MEDOInknKJ$UKE~vyzJ)sC7|85)daL*m!L?%0NcWP9(xy>=J
zW!dZbZ+}Rqb_==012RbG9T<(7vuFScQx(siZCR37mL1~`eF|KPKCg@6&m$I|`Wf6p
zSGCJK)|*CTHChED+F=d3_hn5Q-<5yPxQqk;ie^m8+UI?D9l@Vo?dlz+0$86UYWwv~
zc7`q>35t*8%6VRa<%Tw;N4rF0b=3g>HUQ1XAiZFLaM%Oz;VuAlFI#Uk7C`GjHpDf_
sZt`C;NRh1n6KI-bE>`<bG#WgTFr20ZTb_|v0nnG4lD1;)%eN8#2U^3?i2wiq

diff --git a/t/test-binary-2.png b/t/test-binary-2.png
index ac22ccbd3ee9f03a3b38249ac8efdbe96b5da2cd..58ab836772add93d955b9aa5ff2fecad034348d8 100644
GIT binary patch
delta 201
zc-jHU05<=V0@(qO7=H)@0002!DLE_v000|MOjJc6006)M004jhU|?Oaud2??$LQ$h
z_xJYy|Nm#HuT}s600DGTPE!Ct=GbNc003-BL_t(|+U=Er1^^)tMCWF!`u{IJw=SH8
zvkgHHo)u3Eh1SP1y#nY%Kr6tIU?;RAbUDERlG2b%v06Gr$3n$9F%fzr|5hV|w}$8h
zt3z|-=Qy!iyo8eo@!>opOPJ~xF`za@#{d))P$1(5*S|91fh3x(00000NkvXXu0mjf
DSangj

delta 259
zc-p(kIGJgJL_G^L0|SHZ%`3V<N;<$N#8rWTAt51l!}?VW4Gibb9zVdq@Z!a@@87@u
z|Nq~px+V#zjIkuhFPOpM*^M+1C&}C0g`tC0)&t1lEbxddW?<kJ24O~qS#u<Sg6t)p
zzOL-oSeZo)P4pi<p8ymp^mK6y(Kw&%@xDfZ#Y;j$i$g0bIN^l?4@=vYMb|D|;E-tZ
zG?5lwdE!PB$LkMTMrLMtW@c=GViuyN%u^FKuDi+9s2Rjk(!k0iyqe=x!GzPg1ySu%
zlXi$4^pUvZ+1hbO>A(ZGfWSoz%##%y7aVZlVPLpavaL*+)$b6{b_P#ZKbLh*2~7ab
C1Xf`H

-- 
2.20.1.windows.1

