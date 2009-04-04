From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/7] docbook: improve css style
Date: Sat,  4 Apr 2009 12:38:24 +0300
Message-ID: <1238837909-3060-3-git-send-email-felipe.contreras@gmail.com>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 11:40:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq2MJ-0001om-Pd
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 11:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059AbZDDJiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 05:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755138AbZDDJiq
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 05:38:46 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:63046 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755710AbZDDJio (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 05:38:44 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so1248807bwz.37
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 02:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dh1dIh7FJmgATNQ7dEbnc8OtNqD4WD4iPfYGmuBZrTg=;
        b=mrZouZRXWVnYlYnSQ3uINm7SrCAihBpscchZ/XSC0xFJGdsiRIhnh7gsiaG0njL9HU
         hylcMqjlaDD/weFNCVUATKIKfzQTePiGq5GDwC44y6XCBhz9UJM8id63R/dWkscvXtSB
         O9Pdp2BAweyCBr4bw1UYr37Vc3EphNcfUwPec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=H7JA3ZlP02jwpRtdZr77lN/y0VxFnHbLOw6lMErTnR5h3UMELSPi5D6HapPfEDm7vV
         L/QS2RJpHdpfn9eMrLw5FrqghHjprE9C4xu8aVCtc996sJotOxq0TIESYIvdGpyvTUnw
         hCPntf77LkggsP5KjSmKI1LXYgK+ltZ3/4PGY=
Received: by 10.204.61.130 with SMTP id t2mr766053bkh.19.1238837922342;
        Sat, 04 Apr 2009 02:38:42 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id y15sm656434fkd.12.2009.04.04.02.38.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 02:38:41 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.404.ge96f3
In-Reply-To: <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115574>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/docbook-xsl.css |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/docbook-xsl.css b/Documentation/docbook-xsl.css
index b878b38..e11c8f0 100644
--- a/Documentation/docbook-xsl.css
+++ b/Documentation/docbook-xsl.css
@@ -16,6 +16,7 @@ body blockquote {
 html body {
   margin: 1em 5% 1em 5%;
   line-height: 1.2;
+  font-family: sans-serif;
 }
 
 body div {
@@ -128,6 +129,15 @@ body pre {
 
 tt.literal, code.literal {
   color: navy;
+  font-family: sans-serif;
+}
+
+code.literal:before { content: "'"; }
+code.literal:after { content: "'"; }
+
+em {
+  font-style: italic;
+  color: #064;
 }
 
 div.literallayout p {
@@ -137,7 +147,6 @@ div.literallayout p {
 
 div.literallayout {
   font-family: monospace;
-#  margin: 0.5em 10% 0.5em 1em;
   margin: 0em;
   color: navy;
   border: 1px solid silver;
@@ -187,7 +196,8 @@ dt {
 }
 
 dt span.term {
-  font-style: italic;
+  font-style: normal;
+  color: navy;
 }
 
 div.variablelist dd p {
-- 
1.6.2.2.404.ge96f3
