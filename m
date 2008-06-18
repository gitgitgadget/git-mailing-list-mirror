From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@lavabit.com>
Subject: [PATCH] environment.c: remove unused function
Date: Thu, 19 Jun 2008 08:21:09 +0900
Message-ID: <20080619082109.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 01:47:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K97NT-0001wH-1S
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 01:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614AbYFRXqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 19:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbYFRXqv
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 19:46:51 -0400
Received: from karen.lavabit.com ([72.249.41.33]:37468 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbYFRXqu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 19:46:50 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id B50B2C7B26;
	Wed, 18 Jun 2008 18:21:40 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id XUCABUPVV87Y; Wed, 18 Jun 2008 18:21:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=xNmBkEd0vUQqowsJLEtrvNe11VCNA7H70EezlSdfJqamci6Kwh76In8JsPUbCRBGcLh161HZwmXyGwQDQrgj/2ReyxzfLjkcYEjokw943uP6/xplXRirltyFJ/P5df4yacm3/2pH939NFzCeUI8r8yUaxW4HKTlDGnOp+kLZfU4=;
  h=From:Date:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85425>

Removes get_refs_directory() that is not used anywhere.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 cache.h       |    1 -
 environment.c |    7 -------
 2 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index fdf07b7..64eba9d 100644
--- a/cache.h
+++ b/cache.h
@@ -311,7 +311,6 @@ extern char *git_work_tree_cfg;
 extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
 extern char *get_object_directory(void);
-extern char *get_refs_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
diff --git a/environment.c b/environment.c
index 73feb2d..187248b 100644
--- a/environment.c
+++ b/environment.c
@@ -129,13 +129,6 @@ char *get_object_directory(void)
 	return git_object_dir;
 }
 
-char *get_refs_directory(void)
-{
-	if (!git_refs_dir)
-		setup_git_env();
-	return git_refs_dir;
-}
-
 char *get_index_file(void)
 {
 	if (!git_index_file)
-- 
1.5.5.4
