From: dave@krondo.com
Subject: [PATCH] Documentation: fix and clarify grammar in git-merge docs.
Date: Tue, 15 Jan 2008 21:16:05 -0800
Message-ID: <1200460565-16797-1-git-send-email-dave@krondo.com>
Cc: Dave Peticolas <dave@krondo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 06:16:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF0dk-0004kP-Tg
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 06:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbYAPFQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 00:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbYAPFQL
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 00:16:11 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:35862 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbYAPFQK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 00:16:10 -0500
Received: by rv-out-0910.google.com with SMTP id k20so104491rvb.1
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 21:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:sender;
        bh=txoNcriaGm/l0yqsmykm4DtdahNuqEdJBpeILNsVum8=;
        b=v9vGxCjdwoH9u7uzcSGfRbJzHsoexx5FHxhLp5owmT9WjtmYyvy7QtrkVJzY+3imNesitMnTQoHDkrMOI1FbodRCX3+wII/ttMzeNE2zIqKMZSz4r+m3ZT0uYrsvuvGU/5rkwicyMoq0XqYUmgqegBs/b82nFfalvYd8IyrDdkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:sender;
        b=f+M4bFtPrdfIie5ohL0U3oSqZxcHowe7oS3Gmq5rTs2V++5C/2SOG+VCQ3O7UstrH+9xQMnoGCFHdlguAKdZEKawIgs0FZgVdBXUPXHwik8LhCbvPf5YX1EToflpivoPYxc3up7yx7UqxLkyXkB1S54vInRiKAdSmBePAdR/+2w=
Received: by 10.140.82.38 with SMTP id f38mr278850rvb.27.1200460569684;
        Tue, 15 Jan 2008 21:16:09 -0800 (PST)
Received: from localhost ( [70.231.131.126])
        by mx.google.com with ESMTPS id l31sm1108349rvb.27.2008.01.15.21.16.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Jan 2008 21:16:08 -0800 (PST)
X-Mailer: git-send-email 1.5.3.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70633>

From: Dave Peticolas <dave@krondo.com>


Signed-off-by: Dave Peticolas <dave@krondo.com>
---
 Documentation/git-merge.txt |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index ed3a924..abf63fe 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -74,19 +74,18 @@ it happens.  In other words, `git-diff --cached HEAD` must
 report no changes.
 
 [NOTE]
-This is a bit of lie.  In certain special cases, your index are
-allowed to be different from the tree of `HEAD` commit.  The most
-notable case is when your `HEAD` commit is already ahead of what
-is being merged, in which case your index can have arbitrary
-difference from your `HEAD` commit.  Otherwise, your index entries
-are allowed have differences from your `HEAD` commit that match
-the result of trivial merge (e.g. you received the same patch
-from external source to produce the same result as what you are
-merging).  For example, if a path did not exist in the common
-ancestor and your head commit but exists in the tree you are
-merging into your repository, and if you already happen to have
-that path exactly in your index, the merge does not have to
-fail.
+This is a bit of a lie.  In certain special cases, your index is
+allowed to be different from the tree of the `HEAD` commit.  The
+most notable case is when your `HEAD` commit is already ahead of
+what is being merged, in which case your index can have arbitrary
+differences from your `HEAD` commit.  Also, your index entries may
+have differences from your `HEAD` commit that match the result of
+a trivial merge (e.g., you received the same patch from an external
+source to produce the same result as what you are merging).  For example,
+if a path did not exist in the common ancestor and your head commit
+but exists in the tree you are merging into your repository, and if
+you already happen to have that path exactly in your index, the merge
+does not have to fail.
 
 Otherwise, merge will refuse to do any harm to your repository
 (that is, it may fetch the objects from remote, and it may even
-- 
1.5.3.8
