From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [PATCH] gittutorial.txt: remove reference to ancient Git version
Date: Wed, 12 Nov 2014 10:20:42 +0100
Message-ID: <5463266A.1060706@atlas-elektronik.com>
References: <1325552150.191076.1415782620274.JavaMail.ngmail@webmail22.arcor-online.net> <54632468.8090105@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Ackermann <th.acker@arcor.de>,
	"gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 10:21:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoU6n-0001m6-HP
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 10:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbaKLJU4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Nov 2014 04:20:56 -0500
Received: from mail96.atlas.de ([194.156.172.86]:27259 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbaKLJUy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 04:20:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id B7D8C10166;
	Wed, 12 Nov 2014 10:20:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id de8hjNHoIr_Z; Wed, 12 Nov 2014 10:20:43 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Wed, 12 Nov 2014 10:20:43 +0100 (CET)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 1A47C2716C;
	Wed, 12 Nov 2014 10:20:43 +0100 (CET)
Received: from [10.200.54.122] (10.200.54.122) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.327.1; Wed, 12 Nov
 2014 10:20:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <54632468.8090105@atlas-elektronik.com>
OpenPGP: id=922127AF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 12.11.2014 um 10:12 schrieb Stefan N=C3=A4we:
> Am 12.11.2014 um 09:57 schrieb Thomas Ackermann:
>=20
>> I also re-read the whole document and think it's still up-to-date
>> with Git 2.0. But I might have missed some subtler points.
>=20
> Hhmm..
> At least this is not 100% up to date:
>=20
> diff --git a/Documentation/gittutorial.txt b/Documentation/gittutoria=
l.txt
> [...]

And while at it:

diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutoria=
l-2.txt
index 3109ea8..1901af7 100644
- --- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -368,17 +368,18 @@ situation:

 ------------------------------------------------
 $ git status
- -# On branch master
- -# Changes to be committed:
- -#   (use "git reset HEAD <file>..." to unstage)
- -#
- -#       new file: closing.txt
- -#
- -# Changes not staged for commit:
- -#   (use "git add <file>..." to update what will be committed)
- -#
- -#       modified: file.txt
- -#
+On branch master
+Changes to be committed:
+  (use "git reset HEAD <file>..." to unstage)
+
+        new file:   closing.txt
+
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git checkout -- <file>..." to discard changes in working direc=
tory)
+
+        modified:   file.txt
+


Stefan
- --=20
- ----------------------------------------------------------------
/dev/random says: Make it idiot proof and someone will make a better id=
iot.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"=20
GPG Key fingerprint =3D 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 2=
7AF
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlRjJmoACgkQgptJxZIhJ6+LBgCgmVgJCmJjC86NHopW1rQwk/eA
r04AoIgMfKhB00H8KCHBMAsC5LjCFXY5
=3DbNM+
-----END PGP SIGNATURE-----
