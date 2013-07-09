From: Tony Finch <dot@dotat.at>
Subject: [PATCH 1/4] gitweb: Ensure OPML text fits inside its box.
Date: Tue, 9 Jul 2013 17:43:42 +0100
Message-ID: <E1Uyev6-0003d1-Mg@hermes-2.csi.cam.ac.uk>
References: <20130714234915.GB19057@google.com>
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 11:18:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyevC-0005gz-HI
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 11:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623Ab3GOJSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 05:18:14 -0400
Received: from ppsw-mx-f.csi.cam.ac.uk ([131.111.8.149]:36590 "EHLO
	ppsw-42.csi.cam.ac.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754434Ab3GOJSN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 05:18:13 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:53803)
	by ppsw-42.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1Uyev6-0000l4-8t (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 15 Jul 2013 10:18:12 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1Uyev6-0003d1-Mg (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 15 Jul 2013 10:18:12 +0100
In-Reply-To: <20130714234915.GB19057@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230442>

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
