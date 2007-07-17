From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: [PATCH] Document "git stash message..."
Date: Tue, 17 Jul 2007 17:15:42 +0900
Message-ID: <20070624192215.6117@nanako3.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 10:16:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAiEi-0006qq-FJ
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 10:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933393AbXGQIQN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 04:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933388AbXGQIQN
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 04:16:13 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:46046 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933373AbXGQIQK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 04:16:10 -0400
Received: from fe0.bluebottle.com (internal.bluebottle.com [206.188.24.43])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l6H8G7kB014425
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 17 Jul 2007 01:16:07 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:date:subject:message-id:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=bnt07dsjNLncPQ7ZG8Jie8Fr6kn8Ued5WctNJVyZTn8Tvtv8xT0n5lAchk298GcDx
	iC3Qlno5s+1N9MQBVej5Aw0WIQL+yUmngNtN4rJUISVlmltd0Nkdj9bkfo4Q+It
Received: from nanako3.mail.bluebottle.com (siraly-gw2.selyeuni.sk.133.111.195.in-addr.arpa [195.111.133.92] (may be forged))
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l6H8G2bH001497
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 17 Jul 2007 01:16:06 -0700
X-Trusted-Delivery: <23bb41db9f456aa903b12bdbc8b62584>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52748>

The command was recently updated to take message on the command line, but
this feature has not been documented.

Signed-off-by: Nanako Shiraishi <nanako3@bluebottle.com>
---
 Documentation/git-stash.txt |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index ad95ed9..4404361 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -8,7 +8,8 @@ git-stash - Stash the changes in a dirty working directory away
 SYNOPSIS
 --------
 [verse]
-'git-stash' (save | list | show [<stash>] | apply [<stash>] | clear)
+'git-stash' (list | show [<stash>] | apply [<stash>] | clear)
+'git-stash' [save] [message...]
 
 DESCRIPTION
 -----------
@@ -22,7 +23,9 @@ The modifications stashed away by this command can be listed with
 `git-stash list`, inspected with `git-stash show`, and restored
 (potentially on top of a different commit) with `git-stash apply`.
 Calling git-stash without any arguments is equivalent to `git-stash
-save`.
+save`.  A stash is by default listed as "WIP on 'branchname' ...", but
+you can give more descriptive message on the command line when
+you create one.
 
 The latest stash you created is stored in `$GIT_DIR/refs/stash`; older
 stashes are found in the reflog of this reference and can be named using
@@ -48,8 +51,8 @@ list::
 	based on.
 +
 ----------------------------------------------------------------
-stash@{0}: submit: 6ebd0e2... Add git-stash
-stash@{1}: master: 9cc0589... Merge branch 'master' of gfi
+stash@{0}: WIP on submit: 6ebd0e2... Update git-stash documentation
+stash@{1}: On master: 9cc0589... Add git-stash
 ----------------------------------------------------------------
 
 show [<stash>]::

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email account with anti spam protection.
http://www.bluebottle.com/tag/2
