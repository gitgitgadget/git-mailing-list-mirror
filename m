From: dave@krondo.com
Subject: [PATCH] Documentation: fix and clarify grammar in git-merge docs.
Date: Wed, 16 Jan 2008 18:58:39 -0800
Message-ID: <1200538719-24733-1-git-send-email-dave@krondo.com>
Cc: Dave Peticolas <dave@krondo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 17 03:59:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFKyN-0000Lb-Fr
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 03:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbYAQC6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 21:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbYAQC6n
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 21:58:43 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:11569 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbYAQC6m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 21:58:42 -0500
Received: by wa-out-1112.google.com with SMTP id v27so797583wah.23
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 18:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:sender;
        bh=B6BAFPF3FIVXy40GzSH+Iy+y01nMmblJqmeSTQBiugg=;
        b=h18aHWGtgadvC9EQx6AWLy7w+vfv//mCDQPmtkKvejL7AJ9zz/uSahJeZG0HU7zj7WPgVo/xv3Fk5Homlhf/ZWcHC0Angf7RVyo4s9lgKvqOipSjoUY1YxACdjp3WGU12QEsQ2sW9jc1cjIAqAXJ4jC8gsonh+3BTZMtXfW84g8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:sender;
        b=wW8ni28kR4ek2CHEe/Q8sFQBiDDK8+ULMC57jdKZil32IOwQ7XRjnue8TSU0qOHsfm/yoDZF7s4sI93UlA7A6HxkDG6QIRVobz/LnYxmy9VP/wIoGTata4Yu6G1PPRiaVdn4NJKuPiV+X51sB8U9HrGqMADmmp+x+C0YQwipQfg=
Received: by 10.114.133.1 with SMTP id g1mr1787693wad.81.1200538722344;
        Wed, 16 Jan 2008 18:58:42 -0800 (PST)
Received: from localhost ( [70.231.131.126])
        by mx.google.com with ESMTPS id m28sm2302805poh.7.2008.01.16.18.58.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Jan 2008 18:58:41 -0800 (PST)
X-Mailer: git-send-email 1.5.3.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70817>

From: Dave Peticolas <dave@krondo.com>

---
 Documentation/git-merge.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index ed3a924..4494595 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -74,14 +74,14 @@ it happens.  In other words, `git-diff --cached HEAD` must
 report no changes.
 
 [NOTE]
-This is a bit of lie.  In certain special cases, your index are
-allowed to be different from the tree of `HEAD` commit.  The most
+This is a bit of a lie.  In certain special cases, your index is
+allowed to be different from the tree of the `HEAD` commit.  The most
 notable case is when your `HEAD` commit is already ahead of what
 is being merged, in which case your index can have arbitrary
-difference from your `HEAD` commit.  Otherwise, your index entries
-are allowed have differences from your `HEAD` commit that match
-the result of trivial merge (e.g. you received the same patch
-from external source to produce the same result as what you are
+differences from your `HEAD` commit.  Also, your index entries
+may have differences from your `HEAD` commit that match
+the result of a trivial merge (e.g., you received the same patch
+from an external source to produce the same result as what you are
 merging).  For example, if a path did not exist in the common
 ancestor and your head commit but exists in the tree you are
 merging into your repository, and if you already happen to have
-- 
1.5.3.8
