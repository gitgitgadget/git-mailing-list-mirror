From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: [PATCH 2/2] Documentation: git-clean: make description more readable
Date: Sat, 25 Apr 2009 09:13:41 -0600
Message-ID: <1240672421-10309-3-git-send-email-wjl@icecavern.net>
References: <1240672421-10309-1-git-send-email-wjl@icecavern.net>
Cc: "Wesley J. Landaker" <wjl@icecavern.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 17:15:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxjbD-0005Hn-DJ
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 17:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062AbZDYPN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 11:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbZDYPN4
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 11:13:56 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:46681 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752749AbZDYPNw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 11:13:52 -0400
Received: from jenova.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id CD0FC3659D;
	Sat, 25 Apr 2009 09:13:44 -0600 (MDT)
Received: from tonberry.icecavern.net (tonberry.icecavern.net [10.0.0.9])
	by jenova.icecavern.net (Postfix) with ESMTP id 31027293C47;
	Sat, 25 Apr 2009 09:13:42 -0600 (MDT)
Received: by tonberry.icecavern.net (Postfix, from userid 1000)
	id 6F44A2FD55; Sat, 25 Apr 2009 09:13:41 -0600 (MDT)
X-Mailer: git-send-email 1.6.2.4
In-Reply-To: <1240672421-10309-1-git-send-email-wjl@icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117558>

The existing text is a little bit awkward. This rewrites the description
section to be more readable and friendly.

Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>
---

This is a more major change, but since at least I and one other person I
know have both stumbled on this section, I think making it more readable
and friendly is a good change.

 Documentation/git-clean.txt |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 932d44d..43b2de7 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -12,14 +12,17 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Removes files unknown to git.  This allows cleaning the working tree
-of files that are not under version control.  If the '-x' option is
-specified, ignored files are also removed, allowing the removal of all
-build products.
+
+This allows cleaning the working tree by removing files that are not
+under version control.
+
+Normally, only files unknown to git are removed, but if the '-x'
+option is specified, ignored files are also removed. This can, for
+example, be useful to remove all build products.
+
 If any optional `<path>...` arguments are given, only those paths
 are affected.
 
-
 OPTIONS
 -------
 -d::
-- 
1.6.2.4
