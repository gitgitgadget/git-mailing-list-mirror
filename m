From: Tony Finch <dot@dotat.at>
Subject: [PATCH v4 1/4] gitweb: Ensure OPML text fits inside its box.
Date: Tue, 20 Aug 2013 17:59:02 +0100
Message-ID: <724e6c13dba3ee00967b4e3f13e472357e24b6c5.1377019362.git.dot@dotat.at>
References: <cover.1377019362.git.dot@dotat.at>
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 20 19:29:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBpjm-00050N-5c
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 19:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590Ab3HTR2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 13:28:38 -0400
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:42960 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab3HTR2h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 13:28:37 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:55898)
	by ppsw-32.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
	with esmtpa (EXTERNAL:fanf2) id 1VBpjQ-0003f8-18 (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 20 Aug 2013 18:28:36 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1VBpjQ-0002ma-9A (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 20 Aug 2013 18:28:36 +0100
In-Reply-To: <cover.1377019362.git.dot@dotat.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232619>

The rss_logo CSS style has a fixed width which is too narrow for
the string "OPML". Replace the fixed width with horizontal padding
so the text fits with nice margins.

Signed-off-by: Tony Finch <dot@dotat.at>
---
 gitweb/static/gitweb.css | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index cb86d2d..a869be1 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -548,8 +548,7 @@ a.linenr {
 
 a.rss_logo {
 	float: right;
-	padding: 3px 0px;
-	width: 35px;
+	padding: 3px 5px;
 	line-height: 10px;
 	border: 1px solid;
 	border-color: #fcc7a5 #7d3302 #3e1a01 #ff954e;
-- 
1.8.3.1.605.g85318f5
