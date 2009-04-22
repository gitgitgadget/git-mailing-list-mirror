From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: [PATCH 2/2] Documentation: git-svn: fix a grammatical error without awkwardness
Date: Wed, 22 Apr 2009 08:51:47 -0600
Message-ID: <1240411907-5002-2-git-send-email-wjl@icecavern.net>
References: <1240411907-5002-1-git-send-email-wjl@icecavern.net>
Cc: "Wesley J. Landaker" <wjl@icecavern.net>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 16:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwdpR-0003Fx-M2
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 16:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbZDVOv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 10:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbZDVOv5
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 10:51:57 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:41794 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752666AbZDVOv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 10:51:57 -0400
Received: from jenova.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 5242A365E5;
	Wed, 22 Apr 2009 08:51:51 -0600 (MDT)
Received: from tonberry.icecavern.net (tonberry.icecavern.net [10.0.0.9])
	by jenova.icecavern.net (Postfix) with ESMTP id 7C40474C002;
	Wed, 22 Apr 2009 08:51:47 -0600 (MDT)
Received: by tonberry.icecavern.net (Postfix, from userid 1000)
	id 607652FDD0; Wed, 22 Apr 2009 08:51:47 -0600 (MDT)
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1240411907-5002-1-git-send-email-wjl@icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117203>

The way the sentence is currently written, there needs to be an "its",
but this leads to: "however the remote wildcard may be anywhere as long
as it's its own" which is awkward to read.

Instead, this patch fixes he grammar in a simpler way.

Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>
---
 Documentation/git-svn.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index b03c1f0..1b18c19 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -695,7 +695,7 @@ listed below are allowed:
 
 Keep in mind that the '*' (asterisk) wildcard of the local ref
 (right of the ':') must be the farthest right path component;
-however the remote wildcard may be anywhere as long as it's own
+however the remote wildcard may be anywhere as long as it's an
 independent path component (surrounded by '/' or EOL).   This
 type of configuration is not automatically created by 'init' and
 should be manually entered with a text-editor or using 'git-config'.
-- 
1.6.2.3
