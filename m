From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] Documentation: minor consistency fixes in git-difftool.txt.
Date: Tue, 24 Mar 2009 23:14:15 -0700
Message-ID: <1237961655-29147-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 25 07:15:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmMOM-0001wm-Nn
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 07:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbZCYGNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 02:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753812AbZCYGNg
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 02:13:36 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:35780 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789AbZCYGNf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 02:13:35 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2681532rvb.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 23:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=t3Nj71d1P+4iehI05fU9ukQ5P/vCM30ZE6bDUT3o3u0=;
        b=Z+A/IRHUL6u14KcEz/diFDgqRHiUmRpxOyKKGM4jfwNngzyVixFcxjl+boY1oyNF5F
         QvXr9HyGzDHoAZ3xtoAmAWyvCOHvAEbvULPDqVHNMivwY+dZAkLZDZQz6SXOWheFW/B5
         RWEAsG+yONH09f/m6bShzRBSSNOJkSdy/W/qI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Gy7G47IZ/yDb0HU2A3sTi5y0m5z5FQbkILK44pWNsMy4HLWJJA/hdq7LanIUTe6TrV
         T9Jsncq7xKPuG0UOxwbnvJfMjgZFdHmpsnJYjn0AtZg7GzgOnnPsIXtrBXKNMehfXaS2
         YyDCi9Ur2sRR4XC9ZSUahicOiGJ4F3pFtXbDM=
Received: by 10.114.81.1 with SMTP id e1mr6207792wab.212.1237961613746;
        Tue, 24 Mar 2009 23:13:33 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m31sm7211313wag.64.2009.03.24.23.13.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Mar 2009 23:13:33 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.303.g63699
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114565>

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/git-difftool.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 5ae02f8..23070c1 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 'git-difftool' is a git command that allows you to compare and edit files
-between revisions using common diff tools.  'git difftool' is a frontend
+between revisions using common diff tools.  'git-difftool' is a frontend
 to 'git-diff' and accepts the same options and arguments.
 
 OPTIONS
@@ -23,7 +23,7 @@ OPTIONS
 -t <tool>::
 --tool=<tool>::
 	Use the diff tool specified by <tool>.
-	Valid merge tools are:
+	Valid diff tools are:
 	kdiff3, kompare, tkdiff, meld, xxdiff, emerge,
 	vimdiff, gvimdiff, ecmerge, and opendiff
 +
@@ -50,7 +50,7 @@ variables available: `$LOCAL` is set to the name of the temporary
 file containing the contents of the diff pre-image and `$REMOTE`
 is set to the name of the temporary file containing the contents
 of the diff post-image.  `$BASE` is provided for compatibility
-with custom merge tool commands and has the same value as `$LOCAL`.
+with custom 'git-mergetool' commands and has the same value as `$LOCAL`.
 
 See linkgit:git-diff[1] for the full list of supported options.
 
-- 
1.6.2.1.303.g63699
