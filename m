From: Matthias-Christian Ott <matthias.christian@tiscali.de>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 18:59:42 +0200
Message-ID: <426D21FE.3040401@tiscali.de>
References: <426CD1F1.2010101@tiscali.de> <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 18:56:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ6rm-0003TR-2I
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 18:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVDYRAU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 25 Apr 2005 13:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVDYRAU
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 13:00:20 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:10733 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262635AbVDYQ7z
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 12:59:55 -0400
Received: from [169.254.101.1] (213.54.101.65) by webmail.tiscali.de (7.0.036.1) (authenticated as matthias.christian@tiscali.de)
        id 4263597F0004068C; Mon, 25 Apr 2005 18:59:51 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050406)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
>=20
> On Mon, 25 Apr 2005, Matthias-Christian Ott wrote:
>=20
>>The "git" didn't try store small variables, which aren't referenced, =
in=20
>>the processor registers. It also didn't use the size_t type. I correc=
ted=20
>>a C++ style comment too.
>=20
>=20
> What kind of ancient C standard are you working against?
>=20
> // isn't "C++" any more, and "register" variables are sooo 60's, man.
>=20
> Pass the toke,
>=20
> 		Linus
>=20
"register" and "auto" variables aren't relicts of the 60's,  they're a=20
part of the ISO-C 99 standard, I'm following, "man".

And if you think "register" variables are outdated, please remove the=20
CONFIG_REGPARM option from the Kernel source.

Removing a "//" comment makes sense in this case because a "//" comment=
=20
between hundrets of "/* */" comments looks extremly ugly and shows that=
=20
the source is "patchworked" and unstructured.

Today a lot of people forget about the basic rules of coding. You too. =
:)

Matthias-Christian Ott

Literature:
[1] Dr.-Ing. Ludwig Cla=DFen, Dipl.-Math. Ulrich Oefler: Unix und C: Ei=
n=20
Anwenderbuch; VEB Verlag Technik Berlin; 1990
[2] Erik de Castro Lopo, Peter Aitken, Bradley L. Jones: Teach Yourself=
=20
C for Linux Programming in 21 Days; SAMS Publishing; 1999

