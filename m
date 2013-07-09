From: Tony Finch <dot@dotat.at>
Subject: [PATCH 2/4] gitweb: vertically centre contents of page footer
Date: Tue, 9 Jul 2013 18:08:37 +0100
Message-ID: <E1Uyev8-0003dE-LM@hermes-2.csi.cam.ac.uk>
References: <20130714234915.GB19057@google.com>
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 11:18:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyevH-0005ld-PB
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 11:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629Ab3GOJSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 05:18:16 -0400
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:46852 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434Ab3GOJSP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 05:18:15 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:56163)
	by ppsw-32.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
	with esmtpa (EXTERNAL:fanf2) id 1Uyev8-0006CR-2J (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 15 Jul 2013 10:18:14 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1Uyev8-0003dE-LM (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 15 Jul 2013 10:18:14 +0100
In-Reply-To: <20130714234915.GB19057@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230443>

Signed-off-by: Tony Finch <dot@dotat.at>
---
 gitweb/static/gitweb.css | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index a869be1..3b4d833 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -68,12 +68,13 @@ div.page_path {
 }
 
 div.page_footer {
-	height: 17px;
+	height: 22px;
 	padding: 4px 8px;
 	background-color: #d9d8d1;
 }
 
 div.page_footer_text {
+	line-height: 22px;
 	float: left;
 	color: #555555;
 	font-style: italic;
-- 
1.8.3.1.605.g85318f5
