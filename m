From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Document new --date=<format>
Date: Fri, 13 Jul 2007 23:49:12 -0700
Message-ID: <7vk5t3lbtj.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vy7hklzsf.fsf@assigned-by-dhcp.cox.net>
	<20070713225836.17922.32546.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 08:49:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9bRN-0004J1-0W
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 08:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbXGNGtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 02:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbXGNGtO
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 02:49:14 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:45422 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbXGNGtN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 02:49:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070714064913.DAIP1399.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 14 Jul 2007 02:49:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PJpC1X00M1kojtg0000000; Sat, 14 Jul 2007 02:49:13 -0400
In-Reply-To: <20070713225836.17922.32546.stgit@lathund.dewire.com> (Robin
	Rosenberg's message of "Sat, 14 Jul 2007 01:00:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52447>

Now, git-log family can take full range of internally supported date format
to their --date=<format> argument.  Document it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * And the documentation...

 Documentation/git-rev-list.txt |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 20dcac6..08e7573 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -28,7 +28,7 @@ SYNOPSIS
 	     [ \--encoding[=<encoding>] ]
 	     [ \--(author|committer|grep)=<pattern> ]
 	     [ \--regexp-ignore-case ] [ \--extended-regexp ]
-	     [ \--date={local|relative|default} ]
+	     [ \--date={local|relative|default|iso|rfc|short} ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
@@ -96,7 +96,7 @@ include::pretty-options.txt[]
 
 	Synonym for `--date=relative`.
 
---date={relative,local,default}::
+--date={relative,local,default,iso,rfc}::
 
 	Only takes effect for dates shown in human-readable format, such
 	as when using "--pretty".
@@ -106,6 +106,13 @@ e.g. "2 hours ago".
 +
 `--date=local` shows timestamps in user's local timezone.
 +
+`--date=iso` (or `--date=iso8601`) shows timestamps in ISO 8601 format.
++
+`--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
+format, often found in E-mail messages.
++
+`--date=short` shows only date but not time, in `YYYY-MM-DD` fomat.
++
 `--date=default` shows timestamps in the original timezone
 (either committer's or author's).
 
-- 
1.5.3.rc1.4.gaf83
