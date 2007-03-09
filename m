From: Jeff King <peff@peff.net>
Subject: [PATCH] Documentation: s/seperator/separator/
Date: Fri, 9 Mar 2007 15:21:41 -0500
Message-ID: <20070309202141.GA4074@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 21:22:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPlbI-0000NI-Tn
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 21:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933043AbXCIUVp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 15:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933173AbXCIUVp
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 15:21:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2304 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933043AbXCIUVo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 15:21:44 -0500
Received: (qmail 25282 invoked from network); 9 Mar 2007 15:22:03 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 9 Mar 2007 15:22:03 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Mar 2007 15:21:41 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41808>


Signed-off-by: Jeff King <peff@peff.net>
---
This is obviously a ridiculously minor patch; is there some place other
than Junio for collecting little typo patches?

 Documentation/git-fast-import.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 77a14bb..a7d255d 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -451,7 +451,7 @@ in octal.  Git only supports the following modes:
 In both formats `<path>` is the complete path of the file to be added
 (if not already existing) or modified (if already existing).
 
-A `<path>` string must use UNIX-style directory seperators (forward
+A `<path>` string must use UNIX-style directory separators (forward
 slash `/`), may contain any byte other than `LF`, and must not
 start with double quote (`"`).
 
@@ -461,8 +461,8 @@ quoting should be used, e.g. `"path/with\n and \" in it"`.
 The value of `<path>` must be in canoncial form. That is it must not:
 
 * contain an empty directory component (e.g. `foo//bar` is invalid),
-* end with a directory seperator (e.g. `foo/` is invalid),
-* start with a directory seperator (e.g. `/foo` is invalid),
+* end with a directory separator (e.g. `foo/` is invalid),
+* start with a directory separator (e.g. `/foo` is invalid),
 * contain the special component `.` or `..` (e.g. `foo/./bar` and
   `foo/../bar` are invalid).
 
-- 
1.5.0.3.927.g2432c
