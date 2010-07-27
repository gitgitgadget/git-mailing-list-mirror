From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] t/t6035-merge-dir-to-symlink.sh: Remove TODO on passing test
Date: Tue, 27 Jul 2010 16:54:58 +0000
Message-ID: <1280249698-11001-1-git-send-email-avarab@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 27 18:55:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdnR3-0008Of-Lv
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 18:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046Ab0G0QzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 12:55:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49213 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab0G0QzO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 12:55:14 -0400
Received: by wyf19 with SMTP id 19so3266701wyf.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 09:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=hIU4EoS5YeSkJGIOU9MJ5y5/JEZl++LxOkwPthV1bC0=;
        b=ucwi6nNwnaWRhv1eJraBrk74YvFLPl7i4rfbmBeZhb+PDP8cG4o1AUp8bPXjLQ0XXz
         BUPC0xDw2NoPhXZ9YTSAkjEV/0qGiOdF9rvNMn0wv3dUwc1CEKBLz04NIno2QzJoLwds
         OxSRNju2nPfu2r0UOOt+w2TTO21Cq59MdRxP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=tCikYo9C4/tQy64iYcswjfHGdcAHxXBwnLns3UnxamvPL+0CRUMao0cmV5L7MaUn76
         UHrtq2jVtUlZdUhapdiBouuLbH/hn5eA9ENLKoyb5mb8h90T4jUr6H8/XfNc0nrlQ+ba
         Y8WfnQtnE3iW8R8wCO81BOSsj3bbnasVRbaM0=
Received: by 10.216.235.106 with SMTP id t84mr9221734weq.46.1280249712994;
        Tue, 27 Jul 2010 09:55:12 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p45sm2842219weq.21.2010.07.27.09.55.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 09:55:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151955>

Various merge-recursive cases were fixed in "merge-recursive: Fix D/F
conflicts" by Elijah Newren. Some tests were changed from
test_expect_failure to test_expect_success, but one fell through the
cracks.

Change that test to use test_expect_success.
---
 t/t6035-merge-dir-to-symlink.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
index 272bab5..dc09513 100755
--- a/t/t6035-merge-dir-to-symlink.sh
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -72,7 +72,7 @@ test_expect_success 'Handle F/D conflict, do not lose a/b-2/c/d in merge (resolv
 	test -f a/b-2/c/d
 '
 
-test_expect_failure 'Handle F/D conflict, do not lose a/b-2/c/d in merge (recursive)' '
+test_expect_success 'Handle F/D conflict, do not lose a/b-2/c/d in merge (recursive)' '
 	git reset --hard &&
 	git checkout master^0 &&
 	git merge -s recursive baseline^0 &&
-- 
1.7.1
