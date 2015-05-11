From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/4] t/t91*: do not say how to avoid the tests
Date: Mon, 11 May 2015 13:54:19 +0200
Message-ID: <9d6d4650dda2044f970916619670bded8fe9c9ed.1431344881.git.git@drmicha.warpmail.net>
References: <0727016B-E495-4577-A174-E0EA85910BD3@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 13:54:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrmIA-0004D7-Uf
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 13:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbbEKLya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 07:54:30 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43806 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753199AbbEKLy0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 07:54:26 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 0647820A4A
	for <git@vger.kernel.org>; Mon, 11 May 2015 07:54:26 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 11 May 2015 07:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:in-reply-to:in-reply-to:message-id:references
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=ioozr
	OnafwIwp9sWwyjq4YeWWds=; b=iR0PwsOTqK0UwPgQayM3BdsAIJOqRvlc5eBaz
	mhXppCs8SibA0o0HHR/6vXNAORMRWkv6feT4fV9abjl8rZEMOh9KkwBg8X1Ss8QD
	0AWIlxvcnxCMJRG5UQwu7uBdcL4UxtEUtgIrYFyXfqYYa/b/UQnZZbFRxzspTq37
	x2O3l4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:in-reply-to
	:message-id:references:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=ioozrOnafwIwp9sWwyjq4YeWWds=; b=jETiK
	iob79Bh7kyQtr0EzZ+W2ek7avlKbxwO9uCKoUBqpBHbEZFgLBOoRSVPOB7L46WXs
	KDPrOGXkNrnqBQ9ZSWGifrfwYfTAlpc6d79J3CvdVg0C8+gXh3SA4ireZ+MyHp7P
	dB0l7dTHxE6iDKSNXNAuZYG+faHhNexzzmoKbU=
X-Sasl-enc: rTAC2WUDkoKOg5EeiXK3idiXcqTwe+aq4GzkApLgYz+a 1431345265
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9A74168011D;
	Mon, 11 May 2015 07:54:25 -0400 (EDT)
X-Mailer: git-send-email 2.4.0.rc3.332.g886447c
In-Reply-To: <0727016B-E495-4577-A174-E0EA85910BD3@gmail.com>
In-Reply-To: <cover.1431344881.git.git@drmicha.warpmail.net>
References: <cover.1431344881.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268771>

Some of the tests "say" how to stop the svn tests from running, some do
not.

The test suite is directed at people reading t/README where we keep all
information about running the test suite (partly, with options etc.).

Remove said "say" occurences.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    Note on the side while messing with svn tests.

 t/t9100-git-svn-basic.sh               | 2 --
 t/t9158-git-svn-mergeinfo.sh           | 2 --
 t/t9160-git-svn-preserve-empty-dirs.sh | 1 -
 3 files changed, 5 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 4fea8d9..3e34b42 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -8,8 +8,6 @@ GIT_SVN_LC_ALL=${LC_ALL:-$LANG}
 
 . ./lib-git-svn.sh
 
-say 'define NO_SVN_TESTS to skip git svn tests'
-
 case "$GIT_SVN_LC_ALL" in
 *.UTF-8)
 	test_set_prereq UTF8
diff --git a/t/t9158-git-svn-mergeinfo.sh b/t/t9158-git-svn-mergeinfo.sh
index 13f78f2..a875b45 100755
--- a/t/t9158-git-svn-mergeinfo.sh
+++ b/t/t9158-git-svn-mergeinfo.sh
@@ -7,8 +7,6 @@ test_description='git svn mergeinfo propagation'
 
 . ./lib-git-svn.sh
 
-say 'define NO_SVN_TESTS to skip git svn tests'
-
 test_expect_success 'initialize source svn repo' '
 	svn_cmd mkdir -m x "$svnrepo"/trunk &&
 	svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
index b4a4434..0ede3cf 100755
--- a/t/t9160-git-svn-preserve-empty-dirs.sh
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -11,7 +11,6 @@ local Git repository with placeholder files.'
 
 . ./lib-git-svn.sh
 
-say 'define NO_SVN_TESTS to skip git svn tests'
 GIT_REPO=git-svn-repo
 
 test_expect_success 'initialize source svn repo containing empty dirs' '
-- 
2.4.0.rc3.332.g886447c
