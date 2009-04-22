From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: [PATCH 1/2] Documentation: git-svn: fix spurious bolding that mangles the output
Date: Wed, 22 Apr 2009 08:51:46 -0600
Message-ID: <1240411907-5002-1-git-send-email-wjl@icecavern.net>
Cc: "Wesley J. Landaker" <wjl@icecavern.net>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 16:54:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwdpT-0003Fx-07
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 16:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbZDVOwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 10:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbZDVOv7
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 10:51:59 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:41800 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752783AbZDVOv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 10:51:59 -0400
Received: from jenova.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 5F839365E6;
	Wed, 22 Apr 2009 08:51:51 -0600 (MDT)
Received: from tonberry.icecavern.net (tonberry.icecavern.net [10.0.0.9])
	by jenova.icecavern.net (Postfix) with ESMTP id 7F4C874C004;
	Wed, 22 Apr 2009 08:51:47 -0600 (MDT)
Received: by tonberry.icecavern.net (Postfix, from userid 1000)
	id 4E6602FDD1; Wed, 22 Apr 2009 08:51:47 -0600 (MDT)
X-Mailer: git-send-email 1.6.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117202>

Without this fix, the output looks like:

"Keep in mind that the  (asterisk) wildcard of the local ref (right of
the :) *must be the ..." -- with half the sentence spuriously bold.

This is probably working around an asciidoc bug, but it's better to fix
this than to leave the documentation in an unreadable state.

Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>
---
 Documentation/git-svn.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 9229d45..b03c1f0 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -694,7 +694,7 @@ listed below are allowed:
 ------------------------------------------------------------------------
 
 Keep in mind that the '*' (asterisk) wildcard of the local ref
-(right of the ':') *must* be the farthest right path component;
+(right of the ':') must be the farthest right path component;
 however the remote wildcard may be anywhere as long as it's own
 independent path component (surrounded by '/' or EOL).   This
 type of configuration is not automatically created by 'init' and
-- 
1.6.2.3
