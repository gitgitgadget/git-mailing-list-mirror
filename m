From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 2/8] docbook: improve css style
Date: Sun, 22 Mar 2009 20:05:15 +0200
Message-ID: <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 19:08:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlS5d-0000xY-Ux
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 19:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398AbZCVSFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 14:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755292AbZCVSFp
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 14:05:45 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:33397 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320AbZCVSFn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 14:05:43 -0400
Received: by bwz17 with SMTP id 17so1470095bwz.37
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 11:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MAiGS2H6sdtyyj5TwI6YXOQQpt/uIF7d9Rm5oUWIA/M=;
        b=P1uCI8N7GNAcef+Zels656VyIZouLaxDIo96vNl5gaEs43C6HvRNcFTWdpuvKFtg/z
         qpIR94Sjoqfupg55u8dufGLCEyz4R15rMZOk3bp/O+Bx8aAPgsq4rSDvPeng0zTIVMFE
         PSyHzFmNQeh5GOnQ46/BHBHAMRVoj/DXPk/0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AfjaOS/MtKFrI3H5DAMjjokMMFFp8Gjk7kWNW6QtlL/MNX/rX+lzhNE8zbnmQKL346
         nVzWPzkz+AF//UeULiUZfCgUdEN23JtiDo1dGlsHB2G9Zn97jUMFhIAs9wpjdIankdri
         SbOyszPgatO/OemdI4kPndpl8URAwmxrLk1Ps=
Received: by 10.223.104.140 with SMTP id p12mr5276268fao.7.1237745139790;
        Sun, 22 Mar 2009 11:05:39 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id h2sm7378510fkh.29.2009.03.22.11.05.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Mar 2009 11:05:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.352.gae594
In-Reply-To: <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114157>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/docbook-xsl.css |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/docbook-xsl.css b/Documentation/docbook-xsl.css
index b878b38..ce61402 100644
--- a/Documentation/docbook-xsl.css
+++ b/Documentation/docbook-xsl.css
@@ -128,6 +128,15 @@ body pre {
 
 tt.literal, code.literal {
   color: navy;
+  font-size: 1em;
+}
+
+code.literal:before { content: "'"; }
+code.literal:after { content: "'"; }
+
+em {
+  font-style: italic;
+  color: green;
 }
 
 div.literallayout p {
@@ -137,7 +146,6 @@ div.literallayout p {
 
 div.literallayout {
   font-family: monospace;
-#  margin: 0.5em 10% 0.5em 1em;
   margin: 0em;
   color: navy;
   border: 1px solid silver;
@@ -187,7 +195,8 @@ dt {
 }
 
 dt span.term {
-  font-style: italic;
+  font-style: normal;
+  color: navy;
 }
 
 div.variablelist dd p {
-- 
1.6.2.1.352.gae594
