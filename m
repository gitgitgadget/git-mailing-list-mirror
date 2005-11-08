From: Alex Riesen <raa.lkml@gmail.com>
Subject: fix t5000-tar-tree.sh when $TAR isn't set
Date: Tue, 8 Nov 2005 11:45:15 +0100
Message-ID: <81b0412b0511080245m12ed5fe0ha0ed98ca25e2f6e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1488_10961625.1131446715263"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Nov 08 11:46:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZQyf-00026V-0K
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 11:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVKHKpS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 05:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbVKHKpS
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 05:45:18 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:26028 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751258AbVKHKpQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 05:45:16 -0500
Received: by nproxy.gmail.com with SMTP id q29so152736nfc
        for <git@vger.kernel.org>; Tue, 08 Nov 2005 02:45:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=dUN/T28EWolJTidj9E+CGs571A3eJNRhpai+j7EA5NJMqIr9C8KBmED0vvFlFWzrCYhh18uVgy0oN2qbfF2MOCsH3MjSlWG6d7r1Bjzkf+eg2Klz65GoNxGK/0ZalOVfZH4Ge92m3oqWG7JYCxnfK/m3uX9sJEZGfyLMTTLib5s=
Received: by 10.48.80.6 with SMTP id d6mr1171277nfb;
        Tue, 08 Nov 2005 02:45:15 -0800 (PST)
Received: by 10.48.247.3 with HTTP; Tue, 8 Nov 2005 02:45:15 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11324>

------=_Part_1488_10961625.1131446715263
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

$TAR isn't set everywhere. Provide a default (tar)

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

 t/t5000-tar-tree.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

------=_Part_1488_10961625.1131446715263
Content-Type: application/xxxxx; name=TAR-not-set.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="TAR-not-set.patch"

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -25,6 +25,7 @@ commit id embedding:
 '
 
 . ./test-lib.sh
+TAR=${TAR:-tar}
 
 test_expect_success \
     'populate workdir' \


------=_Part_1488_10961625.1131446715263--
