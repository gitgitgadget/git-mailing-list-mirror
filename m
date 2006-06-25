From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] correct documentation for git grep
Date: Sun, 25 Jun 2006 18:07:15 +0200
Message-ID: <E1FuX8l-0001H5-2z@moooo.ath.cx>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx> <20060625184757.f8273820.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 18:07:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuX8u-00047M-S0
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 18:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWFYQHV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 12:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWFYQHV
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 12:07:21 -0400
Received: from moooo.ath.cx ([85.116.203.178]:8634 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751123AbWFYQHU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 12:07:20 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
Mail-Followup-To: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060625184757.f8273820.tihirvon@gmail.com>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22636>

---
> git grep -e --bla
> 
> It's not very well documented.
Let's change that!

 Documentation/git-grep.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 7b810df..62a8e7f 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	   [-n] [-l | --files-with-matches] [-L | --files-without-match]
 	   [-c | --count]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
-	   [-f <file>] [-e <pattern>]
+	   [-f <file>] [-e] <pattern>
 	   [<tree>...]
 	   [--] [<path>...]
 
@@ -71,6 +71,11 @@ OPTIONS
 -f <file>::
 	Read patterns from <file>, one per line.
 
+-e::
+	The next parameter is the pattern. This option has to be
+	used for patterns starting with - and should be used in
+	scripts passing user input to grep.
+
 `<tree>...`::
 	Search blobs in the trees for specified patterns.
 
-- 
1.4.1.rc1.gc594
