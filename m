From: Tony Finch <dot@dotat.at>
Subject: [PATCH v4 2/4] gitweb: vertically centre contents of page footer
Date: Tue, 20 Aug 2013 17:59:03 +0100
Message-ID: <5c4afd189553d0f1e83b0c2b9758643deba5a671.1377019362.git.dot@dotat.at>
References: <cover.1377019362.git.dot@dotat.at>
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 20 19:29:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBpjn-00050N-7E
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 19:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690Ab3HTR2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 13:28:43 -0400
Received: from ppsw-mx-f.csi.cam.ac.uk ([131.111.8.149]:44047 "EHLO
	ppsw-42.csi.cam.ac.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751501Ab3HTR2k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 13:28:40 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:53544)
	by ppsw-42.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1VBpjQ-0000lX-7l (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 20 Aug 2013 18:28:36 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1VBpjQ-0002me-As (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 20 Aug 2013 18:28:36 +0100
In-Reply-To: <cover.1377019362.git.dot@dotat.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232618>

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
