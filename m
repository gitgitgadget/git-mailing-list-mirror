From: newren@gmail.com
Subject: [PATCH] Update t3508 status
Date: Mon, 28 Jun 2010 19:31:31 -0600
Message-ID: <1277775091-13313-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, chriscool@tuxfamily.org,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 03:30:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTPeb-0003y3-9t
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 03:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab0F2BaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 21:30:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57896 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab0F2BaS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 21:30:18 -0400
Received: by iwn7 with SMTP id 7so620887iwn.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 18:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=QZ6scUOEianlZ5gHWzwen0fP0N181B9WyTorW7DF8Ik=;
        b=iprt4R4A+ARbKPvNAD27xn10BPuV4C9c63XKp9wRcvYtyg7V+ulKZELu45E56endHN
         hmNb/uFSzAgwWuzexJ+xh+p9mlsYJMI37r+FvP7wlK6uo+UVtP23Iy7nLMgmXlhqaZ6o
         QrpT+vTVN23xXuMrMXBbDwnfkigWZspldq7Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hyYtQ+pej0g6wtEcOvRBOg+RBAWuySB34E5/glXsqX9YLnp7Z1vr+m6EX9qvqXJ+C5
         edthCB+jitpq1aZ9oZ2B23BsmHnWxArdS3+PPzhxZSojx9ftiqXzEP8PT1hqhajXdLmw
         /i0eLp/lW0WcZVZIMjN81QGZ6QB0LhBL9ZesY=
Received: by 10.231.33.140 with SMTP id h12mr5747598ibd.59.1277775010900;
        Mon, 28 Jun 2010 18:30:10 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id 35sm17673201ibs.22.2010.06.28.18.30.09
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 18:30:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.207.ga9fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149880>

From: Elijah Newren <newren@gmail.com>

Test #8 of t3508-cherry-pick-many-commits.sh has been fixed since
3af0bba8bff88ec1b078aae966a59af26c7a0718.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3508-cherry-pick-many-commits.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 93d7189..f90ed3d 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -82,7 +82,7 @@ test_expect_success 'revert fourth fourth~1 fourth~2 works' '
 	git diff --quiet HEAD first
 '
 
-test_expect_failure 'cherry-pick -3 fourth works' '
+test_expect_success 'cherry-pick -3 fourth works' '
 	git checkout -f master &&
 	git reset --hard first &&
 	test_tick &&
-- 
1.7.2.rc0.207.ga9fc
