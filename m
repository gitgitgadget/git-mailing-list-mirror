From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Fail softly if file system does not like test data.
Date: Wed, 31 Jan 2007 23:36:37 +0100
Organization: Dewire
Message-ID: <200701312336.37923.robin.rosenberg.lists@dewire.com>
References: <20070130163219.GA14431@164.242.249.10.in-addr.arpa> <200701310110.04429.robin.rosenberg.lists@dewire.com> <7viremu9gw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1nRwFCwp+fA36ZJ"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 31 23:36:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCO3j-0006Mt-0e
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 23:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbXAaWgA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 17:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbXAaWgA
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 17:36:00 -0500
Received: from [83.140.172.130] ([83.140.172.130]:19576 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbXAaWf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 17:35:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3175F803392;
	Wed, 31 Jan 2007 23:31:18 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12341-03; Wed, 31 Jan 2007 23:31:17 +0100 (CET)
Received: from [10.9.0.8] (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id A14E380338F;
	Wed, 31 Jan 2007 23:31:15 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <7viremu9gw.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38299>

--Boundary-00=_1nRwFCwp+fA36ZJ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

onsdag 31 januari 2007 23:17 skrev Junio C Hamano:
> Your patch does not seem to apply.  I wonder if the test path
> needs to be that looooooooooooong to begin with.
Not really. I had some thought when I did it, but can't recall what it was. 
Perhaps I wanted to verify that the data I was reading from git-diff wasn't 
truncated. I've pruned that part of memory.

> One thing I noticed on Cygwin is that from inside Cygwin
> environment t/trash directory becomes unremovable after the
> original test fails.

one more interesting thing..

> I am wondering what use it would be to have ISO-8859-1 pathnames
> in our test.  As far as the test is concerned I think the point
> is to try non-ASCII paths, so I suspect this patch might be less
> of an impact.
Yes. Anything non-ascii will do.

> Sorry for sending an attachement but in this case the patch text
> is _not_ in any particular encoding (the preimage is ISO-8859-1
> but the postimage is in UTF-8) and transferring it as a textual
> patch over e-mail is not possible without a way to annotate each
> line which encoding it is in.

That patch didn't apply here, not even  Lets try the old uuencode format. 
(this is my patch once again wrapped by uuencode).

-- robin


--Boundary-00=_1nRwFCwp+fA36ZJ
Content-Type: text/plain;
  charset="utf-8";
  name="patch.uu"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch.uu"

begin 644 patch.uu
M8V]M;6ET(#AE-V(W,38P-#@S.3`U,F9F-6-F-S1E-SAD,C=F865B,60Q930W
M.3(*075T:&]R.B!2;V)I;B!2;W-E;F)E<F<@/')O8FEN+G)O<V5N8F5R9T!D
M97=I<F4N8V]M/@I$871E.B`@(%=E9"!*86X@,S$@,C(Z,#,Z,#(@,C`P-R`K
M,#$P,`H*("`@($9A:6P@<V]F=&QY(&EF(&9I;&4@<WES=&5M(&1O97,@;F]T
M(&QI:V4@=&5S="!D871A+@H@("`@"B`@("!-;W-T('5N:7@@9FEL92!S>7-T
M96T@86QL;W<@86QM;W-T(&%N>2!B>71E('-E<75E;F-E+"!B=70@;W1H97(@
M;6%Y(')E:F5C=`H@("`@<V5Q=65N8V5S('1H870@87)E(&YO="!V86QI9"!A
M8V-O<F1I;F<@=&\@=&AE(&QO8V%L92X@5&AI<R!C:&%N9V4@;6%K97,*("`@
M(&9A:6QU<F4@<V]M97=H870@;&5S<R!L:6ME;'D@8GD@=7-I;F<@551&+3@M
M96YC;V1E9"!C:&%R86-T97)S(&%N9"!S:VEP<PH@("`@=&AE('1E<W0@:68@
M=&AE(&QO8V%L(&9I;&4@<WES=&5M(&1O97,@;F]T('-U<'!O<G0@=&AE('1E
M<W0@9&%T82X*("`@(`H@("`@4VEG;F5D+6]F9BUB>3H@4F]B:6X@4F]S96YB
M97)G(#QR;V)I;BYR;W-E;F)E<F=`9&5W:7)E+F-O;3X*+2TM"B!T+W0Y,C`P
M+6=I="UC=G-E>'!O<G1C;VUM:70N<V@@?"`@(#,W("LK*RLK*RLK*RLK*RLK
M*RLK*RLK*RLK+2TM+2TM+2TM+2TM+2T*(#$@9FEL97,@8VAA;F=E9"P@,C,@
M:6YS97)T:6]N<R@K*2P@,30@9&5L971I;VYS*"TI"@ID:69F("TM9VET(&$O
M="]T.3(P,"UG:70M8W9S97AP;W)T8V]M;6ET+G-H(&(O="]T.3(P,"UG:70M
M8W9S97AP;W)T8V]M;6ET+G-H"FEN9&5X(&9D,&$U-30N+F0P9#4S-C4@,3`P
M-S4U"BTM+2!A+W0O=#DR,#`M9VET+6-V<V5X<&]R=&-O;6UI="YS:`HK*RL@
M8B]T+W0Y,C`P+6=I="UC=G-E>'!O<G1C;VUM:70N<V@*0$`@+3$V.2PR,"`K
M,38Y+#(Y($!`('1E<W1?97AP96-T7W-U8V-E<W,@7`H@("`@("`@=&5S="`B
M)"AE8VAO("0H<V]R="`B1R!G+T-64R]%;G1R:65S(GQC=70@+60O("UF,BPS
M+#4I*2(@/2`B=VET:"!S<&%C97,N<&YG+S$N,B\M:V(@=VET:"!S<&%C97,N
M='AT+S$N,B\B"B`@("`@("`I)PH@"BTC(%1H:7,@=&5S="!C;VYT86EN<R!)
M4T\M.#@U.2TQ(&-H87)A8W1E<G,*+71E<W1?97AP96-T7W-U8V-E<W,@7`HM
M("`@("`G1FEL92!W:71H(&YO;BUA<V-I:2!F:6QE(&YA;64G(%P*+2`@("`@
M)VUK9&ER("UP(,4O9V]O+V$O8B]C+V0O92]F+V<O:"]I+VHO:R]L+VTO;B]O
M+W`O<2]R+W,O="]U+W8O=R]X+WDO>B_E+^0O]B`F)@HM("`@("`@96-H;R!&
M;V\@/L4O9V]O+V$O8B]C+V0O92]F+V<O:"]I+VHO:R]L+VTO;B]O+W`O<2]R
M+W,O="]U+W8O=R]X+WDO>B_E+^0O]B]GY7)D971SY6?E<F1E="YT>'0@)B8*
M+2`@("`@(&=I="!A9&0@Q2]G;V\O82]B+V,O9"]E+V8O9R]H+VDO:B]K+VPO
M;2]N+V\O<"]Q+W(O<R]T+W4O=B]W+W@O>2]Z+^4OY"_V+V?E<F1E='/E9^5R
M9&5T+G1X="`F)@HM("`@("`@8W`@+BXO=&5S=#DR,#!A+G!N9R#%+V=O;R]A
M+V(O8R]D+V4O9B]G+V@O:2]J+VLO;"]M+VXO;R]P+W$O<B]S+W0O=2]V+W<O
M>"]Y+WHOY2_D+_8O9^5R9&5T<^5GY7)D970N<&YG("8F"BT@("`@("!G:70@
M861D(,4O9V]O+V$O8B]C+V0O92]F+V<O:"]I+VHO:R]L+VTO;B]O+W`O<2]R
M+W,O="]U+W8O=R]X+WDO>B_E+^0O]B]GY7)D971SY6?E<F1E="YP;F<@)B8*
M+2`@("`@(&=I="!C;VUM:70@+6$@+6T@(D?E<B!D970@<^4@9^5R(&1E="(@
M)B8@7`HM("`@("`@:60])"AG:70@<F5V+6QI<W0@+2UM87@M8V]U;G0],2!(
M14%$*2`F)@HM("`@("`@*&-D("(D0U935T]22R(@)B8*+2`@("`@(&=I="UC
M=G-E>'!O<G1C;VUM:70@+78@+6,@)&ED("8F"BT@("`@("!T97-T("(D*&5C
M:&\@)"AS;W)T(,4O9V]O+V$O8B]C+V0O92]F+V<O:"]I+VHO:R]L+VTO;B]O
M+W`O<2]R+W,O="]U+W8O=R]X+WDO>B_E+^0O]B]#5E,O16YT<FEE<WQC=70@
M+60O("UF,BPS+#4I*2(@/2`B9^5R9&5T<^5GY7)D970N<&YG+S$N,2\M:V(@
M9^5R9&5T<^5GY7)D970N='AT+S$N,2\B"BT@("`@("`I)PHK(R!4:&ES('1E
M<W0@8V]N=&%I;G,@551&+3@@8VAA<F%C=&5R<R!A;F0@;6%Y(&9A:6P@;VX@
M<V]M92!F:6QE<WES=&5M<PHK;6MD:7(@+7`@(L.E+V=O;R]A+V(O8R]D+V4O
M9B]G+V@O:2]J+VLO;"]M+VXO;R]P+W$O<B]S+W0O=2]V+W<O>"]Y+WHOPZ4O
MPZ0OP[8B(#XO9&5V+VYU;&P@,CXF,0HK:68@=&5S="`D/R`M;F4@,`HK=&AE
M;@HK("`@('1E<W1?97AP96-T7W-U8V-E<W,@)T9I;&4@=VET:"!N;VXM87-C
M:6D@9FEL92!N86UE('-K:7!P960L(&9I;&4@<WES=&5M(&ES(&EN8V]M<&%T
M:6)L92!W:71H('1E<W0@9&%T82<@.@HK("`@(')M("UR9B`BPZ4B"BME;'-E
M"BL@("`@<FT@+7)F("+#I2(**R`@("!T97-T7V5X<&5C=%]S=6-C97-S(%P*
M*PDG1FEL92!W:71H(&YO;BUA<V-I:2!F:6QE(&YA;64G(%P**PDG*&UK9&ER
M("UP("+#I2]G;V\O82]B+V,O9"]E+V8O9R]H+VDO:B]K+VPO;2]N+V\O<"]Q
M+W(O<R]T+W4O=B]W+W@O>2]Z+\.E+\.D+\.V(B!\?`HK("`@("`@("`@96-H
M;R`B3&]C86P@9FEL97-Y<W1E;2!D;V5S(&YO="!P97)M:70@=&AI<R!T97-T
M(B`I("8F"BL@("`@("`@("!E8VAO($9O;R`^(L.E+V=O;R]A+V(O8R]D+V4O
M9B]G+V@O:2]J+VLO;"]M+VXO;R]P+W$O<B]S+W0O=2]V+W<O>"]Y+WHOPZ4O
MPZ0OP[8O9\.E<F1E='/#I6?#I7)D970N='AT(B`F)@HK("`@("`@("`@9VET
M(&%D9"`BPZ4O9V]O+V$O8B]C+V0O92]F+V<O:"]I+VHO:R]L+VTO;B]O+W`O
M<2]R+W,O="]U+W8O=R]X+WDO>B_#I2_#I"_#MB]GPZ5R9&5T<\.E9\.E<F1E
M="YT>'0B("8F"BL@("`@("`@("!C<"`N+B]T97-T.3(P,&$N<&YG("+#I2]G
M;V\O82]B+V,O9"]E+V8O9R]H+VDO:B]K+VPO;2]N+V\O<"]Q+W(O<R]T+W4O
M=B]W+W@O>2]Z+\.E+\.D+\.V+V?#I7)D971SPZ5GPZ5R9&5T+G!N9R(@)B8*
M*R`@("`@("`@(&=I="!A9&0@(L.E+V=O;R]A+V(O8R]D+V4O9B]G+V@O:2]J
M+VLO;"]M+VXO;R]P+W$O<B]S+W0O=2]V+W<O>"]Y+WHOPZ4OPZ0OP[8O9\.E
M<F1E='/#I6?#I7)D970N<&YG(B`F)@HK("`@("`@("`@9VET(&-O;6UI="`M
M82`M;2`B1\.E<B!D970@<\.E(&?#I7(@9&5T(B`F)B!<"BL@("`@("`@("!I
M9#TD*&=I="!R978M;&ES="`M+6UA>"UC;W5N=#TQ($A%040I("8F"BL@("`@
M("`@("`H8V0@(B1#5E-73U)+(B`F)@HK("`@("`@("`@9VET+6-V<V5X<&]R
M=&-O;6UI="`M=B`M8R`D:60@)B8**R`@("`@("`@('1E<W0@(B0H96-H;R`D
M*'-O<G0@(L.E+V=O;R]A+V(O8R]D+V4O9B]G+V@O:2]J+VLO;"]M+VXO;R]P
M+W$O<B]S+W0O=2]V+W<O>"]Y+WHOPZ4OPZ0OP[8O0U93+T5N=')I97,B?&-U
M="`M9"\@+68R+#,L-2DI(B`](")GPZ5R9&5T<\.E9\.E<F1E="YP;F<O,2XQ
M+RUK8B!GPZ5R9&5T<\.E9\.E<F1E="YT>'0O,2XQ+R(**R`@("`@("`@("DG
M"BMF:0H@"B!T97-T7V5X<&5C=%]S=6-C97-S(%P*("`@("`@)TUI<VUA=&-H
9:6YG('!A=&-H('-H;W5L9"!F86EL)R!<"@``
`
end

--Boundary-00=_1nRwFCwp+fA36ZJ--
