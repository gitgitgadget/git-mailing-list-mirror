From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [PATCH] gittutorial.txt: remove reference to ancient Git version
Date: Wed, 12 Nov 2014 10:12:08 +0100
Message-ID: <54632468.8090105@atlas-elektronik.com>
References: <1325552150.191076.1415782620274.JavaMail.ngmail@webmail22.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Ackermann <th.acker@arcor.de>,
	"gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 10:12:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoTya-0005vJ-5p
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 10:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbaKLJM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 04:12:26 -0500
Received: from mail96.atlas.de ([194.156.172.86]:16141 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbaKLJMW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 04:12:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 1466510169;
	Wed, 12 Nov 2014 10:12:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NCg4cp_rWq98; Wed, 12 Nov 2014 10:12:10 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Wed, 12 Nov 2014 10:12:10 +0100 (CET)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 03CD627169;
	Wed, 12 Nov 2014 10:12:09 +0100 (CET)
Received: from [10.200.54.122] (10.200.54.122) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.327.1; Wed, 12 Nov
 2014 10:12:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <1325552150.191076.1415782620274.JavaMail.ngmail@webmail22.arcor-online.net>
OpenPGP: id=922127AF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 12.11.2014 um 09:57 schrieb Thomas Ackermann:
>  
> I also re-read the whole document and think it's still up-to-date
> with Git 2.0. But I might have missed some subtler points.

Hhmm..
At least this is not 100% up to date:

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 8262196..8715244 100644
- --- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -107,14 +107,15 @@ summary of the situation with 'git status':

 ------------------------------------------------
 $ git status
- -# On branch master
- -# Changes to be committed:
- -#   (use "git reset HEAD <file>..." to unstage)
- -#
- -#      modified:   file1
- -#      modified:   file2
- -#      modified:   file3
- -#
+On branch master
+Changes to be committed:
+Your branch is up-to-date with 'origin/master'.
+  (use "git reset HEAD <file>..." to unstage)
+
+        modified:   file1
+        modified:   file2
+        modified:   file3
+


Stefan
- -- 
- ----------------------------------------------------------------
/dev/random says: The drunker I sit here, The longer I get.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')" 
GPG Key fingerprint = 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 27AF
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlRjJGgACgkQgptJxZIhJ6+MfQCeI4iZ3HSkT0Lsk1sh1ckHLBzK
ROwAnAog8We8VLs6trwJsSQqZWDg7ndN
=YC26
-----END PGP SIGNATURE-----
