From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: (broken ?) output of "git diff --color-word"
Date: Wed, 06 Nov 2013 22:02:36 +0100
Message-ID: <527AAE6C.9000808@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 06 22:02:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeAFP-0002m7-UG
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 22:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756488Ab3KFVCk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Nov 2013 16:02:40 -0500
Received: from mout.gmx.net ([212.227.17.22]:62248 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756212Ab3KFVCj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 16:02:39 -0500
Received: from [192.168.178.21] ([78.54.129.126]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0LvEZe-1VmJCB3HJS-010McL for <git@vger.kernel.org>;
 Wed, 06 Nov 2013 22:02:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:Rd41bIkZclm9IX+DJEWo4orkdh9AZU4o7oqlwDf0L9dNsrTd6H0
 UcwaTsIQld06bVnbu9/yDxRn6MEWTUyLVUdIPVLz3iINoKDcjZX/eg472kPavQUB6Ja9wi8
 UOOFqv48NzdYuFlIo04Vab1+WNYTuuHwb1ulvzZSH2pc4EfrOW+A+02UZ5AshhbV7Q8ckRL
 g2+920hFtEUj6rAQgok0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237370>

I just commented out few lines, "git diff" is fine :


@@ -144,10 +145,10 @@ StartUML || exit 2
 SHARES=3D""
 if [[ $VICTIMS -eq 1 ]]; then

-#      SHARES=3D"/tmp"
-#      SHARES=3D"$SHARES /mnt/hostfs"
-#      SHARES=3D"$SHARES /mnt/nfsv2"
-#      SHARES=3D"$SHARES /mnt/nfsv3"
+       SHARES=3D"/tmp"
+       SHARES=3D"$SHARES /mnt/hostfs"
+       SHARES=3D"$SHARES /mnt/nfsv2"
+       SHARES=3D"$SHARES /mnt/nfsv3"
 #      SHARES=3D"$SHARES /mnt/nfsv4"

        echo $SHARES | grep -q hostfs



but "git diff --color-words" places the "#" somehow obscure :


@@ -144,10 +145,10 @@ StartUML || exit 2
SHARES=3D""
if [[ $VICTIMS -eq 1 ]]; then

#       SHARES=3D"/tmp"#
        SHARES=3D"$SHARES /mnt/hostfs"#
        SHARES=3D"$SHARES /mnt/nfsv2"#
        SHARES=3D"$SHARES /mnt/nfsv3"
#       SHARES=3D"$SHARES /mnt/nfsv4"

        echo $SHARES | grep -q hostfs


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
