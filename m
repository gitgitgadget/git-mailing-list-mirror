Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 18685 invoked by uid 111); 1 Oct 2008 14:08:17 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 01 Oct 2008 10:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbYJAOIL (ORCPT <rfc822;peff@peff.net>);
	Wed, 1 Oct 2008 10:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbYJAOIK
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 10:08:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:55342 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYJAOIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 10:08:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so409891fgg.17
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 07:08:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to:sender;
        bh=JPlSzw47yQLH76mdMqY8PJRMdVegC20oDgl0rYFMftg=;
        b=Dut7UQCm1q3mZH/3jaaC5bCiQ1DLZEXKAzhAzzfWWtfK0oyVcroM9GB8bhTD2Uxf+c
         aaInWKuYufCXdvZHzSY0SRlA7hfwD3Lh4KTIfhU1cIoDMsZrslfpLvpji9k+1zCsBXHT
         at5YrwCPifvbdnFqfZ73Ws3/i9963+61YBh5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:sender;
        b=X1F/YMRAgFqAOQ/w62qpEN0JzvzLRhE2Ms63FRWxOrvxt0vOGuQfAbqj8N4nqWvNTG
         H7WxhBtOqO+bS0ciND8SrABGQKQ94jRtZNNKmD2OIslipcuccgS0BFYDwX0WMaoWgI9X
         uF2i93M4Y81BLOT499pMSvg5OzFgO6aZgD/vY=
Received: by 10.180.222.14 with SMTP id u14mr4254170bkg.47.1222870085968;
        Wed, 01 Oct 2008 07:08:05 -0700 (PDT)
Received: from localhost.localdomain (shr01.u.parknet.dk [84.238.113.244])
        by mx.google.com with ESMTPS id p10sm5501477gvf.7.2008.10.01.07.07.48
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Oct 2008 07:07:54 -0700 (PDT)
From:	Jonas Fonseca <fonseca@diku.dk>
To:	Petr Baudis <pasky@suse.cz>
Cc:	git@vger.kernel.org
Subject: [TG PATCH] README: Fix spelling and reflect recent depend support
Date:	Wed,  1 Oct 2008 16:07:39 +0200
Message-Id: <1222870059-22077-1-git-send-email-fonseca@diku.dk>
X-Mailer: git-send-email 1.6.0.2.569.g798a2a
To:	Petr Baudis <pasky@suse.cz>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
 README |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/README b/README
index 35a9f98..903face 100644
--- a/README
+++ b/README
@@ -22,7 +22,7 @@ version control of patches (reordering of patches is not
 version-controlled at all). But there are several disadvantages -
 for one, these tools (especially StGIT) do not actually fit well
 with plain Git at all: it is basically impossible to take advantage
-of the index efectively when using StGIT. But more importantly,
+of the index effectively when using StGIT. But more importantly,
 these tools horribly fail in the face of distributed environment.
 
 TopGit has been designed around three main tenets:
@@ -45,7 +45,7 @@ them.
 
 As mentioned above, the main intended use-case for TopGit is tracking
 third-party patches, where each patch is effectively a single topic
-branch.  In order to flexibly accomodate even complex scenarios when
+branch.  In order to flexibly accommodate even complex scenarios when
 you track many patches where many are independent but some depend
 on others, TopGit ignores the ancient Quilt heritage of patch series
 and instead allows the patches to freely form graphs (DAGs just like
@@ -252,6 +252,7 @@ tg delete
 	depending on it.
 
 	TODO: '-a' to delete all empty branches, depfix, revert
+	TODO: subcommand removing dependencies smoothly
 
 tg depend
 ~~~~~~~~~
@@ -344,7 +345,7 @@ tg export
 	in the cleaned up history (corresponding basically exactly
 	to `tg patch` output for the topic branch).
 
-	The command has two posible outputs now - either a Git branch
+	The command has two possible outputs now - either a Git branch
 	with the collapsed history, or a quilt series in new directory.
 
 	In case of producing collapsed history in new branch,
@@ -449,7 +450,6 @@ tg update
 
 	TODO: tg update -a for updating all topic branches
 
-TODO: tg depend for adding/removing dependencies smoothly
 TODO: tg rename
 
 
@@ -479,10 +479,10 @@ whatever Cc headers you choose or the post-three-dashes message.
 When mailing out your patch, basically only few extra headers
 mail headers are inserted and the patch itself is appended.
 Thus, as your patches evolve, you can record nuances like whether
-the paricular patch should have To-list/Cc-maintainer or vice
+the particular patch should have To-list/Cc-maintainer or vice
 versa and similar nuances, if your project is into that.
-From is prefilled from your current GIT_AUTHOR_IDENT, other headers
-can be prefilled from various optional topgit.* config options.
+From is pre-filled from your current GIT_AUTHOR_IDENT, other headers
+can be pre-filled from various optional topgit.* config options.
 
 	.topdeps: Contains the one-per-line list of branches
 your patch depends on, pre-seeded with `tg create`. (Continuously
-- 
tg: (67ae5b2..) jf/readme-update (depends on: master)
