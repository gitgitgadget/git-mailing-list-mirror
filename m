From: "Brian O'Mahoney" <omb@khandalf.com>
Subject: Re: SHA1 hash safety
Date: Mon, 18 Apr 2005 04:07:32 +0200
Message-ID: <42631664.1050403@khandalf.com>
References: <200504170635.j3H6Z0Ga005661@laptop11.inf.utfsm.cl>
Reply-To: omb@bluewin.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ross@jose.lug.udel.edu, "C. Scott Ananian" <cscott@cscott.net>,
	omb@bluewin.ch, David Lang <david.lang@digitalinsight.com>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:04:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNLcL-0008GK-Sk
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVDRCHy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 17 Apr 2005 22:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVDRCHx
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:07:53 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:478 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261600AbVDRCHp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 22:07:45 -0400
Received: from khandalf.com (80-218-57-125.dclient.hispeed.ch [80.218.57.125])
	(authenticated bits=0)
	by smtp.hispeed.ch (8.12.6/8.12.6/tornado-1.0) with ESMTP id j3I27icb002890
	for <git@vger.kernel.org.>; Mon, 18 Apr 2005 04:07:44 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
    teraflex.teraflex-research.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP
    id j3I27ZfV026634; Mon, 18 Apr 2005 04:07:36 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200504170635.j3H6Z0Ga005661@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Md5-Body: 6b38c40ab074b6eec455e1460f8ea24e
X-Transmit-Date: Monday, 18 Apr 2005 4:8:17 +0200
X-Message-Uid: 0000b49cec9d5cd30000000200000000426316910009f9f6000000010008d083
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@80-218-57-125.dclient.hispeed.ch.
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on smtp-06.tornado.cablecom.ch
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus wants to drive ahead, and ignore the collision issue for now,
and has been dismissive of the risks, he wants a result not heart
searching, and the list comments exhibit a confusion with the
engineering problem of avoiding accidental collisions v deliberate sabo=
tage.

Since this is not a show-stopper, and getting the BK replacement in pla=
ce
is time critical, and if you look at the code it is easy to extend the
content key, LET US just leave this issue for now.

Horst von Brand wrote:
> ross@jose.lug.udel.edu said:
>=20
> [...]
>=20
>=20
>>Linus has already weighed in that he doesn't give a crap.  All the
>>crypto-babble about collision whitepapers is uninteresting without a
>>repo that has real collisions.  git is far too cool as is - prove I
>>should be concerned.
>=20
>=20
> Just copy over a file (might be the first step in splitting it, or a
> header file that is duplicated for convenience, ...)

--=20
mit freundlichen Gr=FC=DFen, Brian.

Dr. Brian O'Mahoney
Mobile +41 (0)79 334 8035 Email: omb@bluewin.ch
Bleicherstrasse 25, CH-8953 Dietikon, Switzerland
PGP Key fingerprint =3D 33 41 A2 DE 35 7C CE 5D  F5 14 39 C9 6D 38 56 D=
5
