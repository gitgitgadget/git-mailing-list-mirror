From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] completion: remove use of dashed git commands
Date: Sun, 20 Apr 2008 12:28:44 -0500
Message-ID: <1208712525-1747-1-git-send-email-dpmcgee@gmail.com>
Cc: git@vger.kernel.org, Dan McGee <dpmcgee@gmail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Apr 20 19:29:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JndM8-00013N-1n
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 19:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbYDTR2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 13:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754319AbYDTR2u
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 13:28:50 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:42794 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbYDTR2t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 13:28:49 -0400
Received: by py-out-1112.google.com with SMTP id u52so2066231pyb.10
        for <git@vger.kernel.org>; Sun, 20 Apr 2008 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=4eI8BqXgccm4Fk1k0I5fEWFkrqqjCLttZdAx0qbdSII=;
        b=FDmhyzP4t9TAkRF2LjK3y5ZcBJQ99KEUYRxauZDmkBuSNQU47GUp83/TzW5qcw4WhVkmk3HjLih8iz3LnXtgOre7lXwI+CQH5AWrypUYrW6opoh/JA+j46WcVyidsZdzw6Qketo0gl6SgXar0QQZeb/7RKBmS9H8paBy6rTNzGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=piGkR5Ip7fEmyL9Wxmh/oI++70/BoK7RjcKDv7FGCoWNswOPzBajZgeiOKDKVhDYiX8VLqrdFqk5lZVkLkXjYr4Wb4szmpRKGnlU5TI0UGyxIkqryaPWlEKe4EPwKYK1fmhqhV0rf4g57Uk37CdEyN9FgRNgg9Bv5Zsk8mXBASs=
Received: by 10.35.8.6 with SMTP id l6mr8815964pyi.66.1208712528279;
        Sun, 20 Apr 2008 10:28:48 -0700 (PDT)
Received: from localhost ( [76.193.177.245])
        by mx.google.com with ESMTPS id f57sm7762654pyh.6.2008.04.20.10.28.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Apr 2008 10:28:47 -0700 (PDT)
X-Mailer: git-send-email 1.5.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79967>

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 contrib/completion/git-completion.bash |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4d81963..3f78630 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -152,7 +152,7 @@ __git_heads ()
 		done
 		return
 	fi
-	for i in $(git-ls-remote "$1" 2>/dev/null); do
+	for i in $(git ls-remote "$1" 2>/dev/null); do
 		case "$is_hash,$i" in
 		y,*) is_hash=n ;;
 		n,*^{}) is_hash=y ;;
@@ -173,7 +173,7 @@ __git_tags ()
 		done
 		return
 	fi
-	for i in $(git-ls-remote "$1" 2>/dev/null); do
+	for i in $(git ls-remote "$1" 2>/dev/null); do
 		case "$is_hash,$i" in
 		y,*) is_hash=n ;;
 		n,*^{}) is_hash=y ;;
@@ -200,7 +200,7 @@ __git_refs ()
 		done
 		return
 	fi
-	for i in $(git-ls-remote "$dir" 2>/dev/null); do
+	for i in $(git ls-remote "$dir" 2>/dev/null); do
 		case "$is_hash,$i" in
 		y,*) is_hash=n ;;
 		n,*^{}) is_hash=y ;;
@@ -223,7 +223,7 @@ __git_refs2 ()
 __git_refs_remotes ()
 {
 	local cmd i is_hash=y
-	for i in $(git-ls-remote "$1" 2>/dev/null); do
+	for i in $(git ls-remote "$1" 2>/dev/null); do
 		case "$is_hash,$i" in
 		n,refs/heads/*)
 			is_hash=y
-- 
1.5.5
