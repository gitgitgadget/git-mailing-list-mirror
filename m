From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] Create HTML for technical/http-protocol.txt
Date: Sat, 11 Jan 2014 12:19:29 +0100 (CET)
Message-ID: <196469122.1795615.1389439169514.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 11 12:19:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1wbc-00079H-7N
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jan 2014 12:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbaAKLTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jan 2014 06:19:32 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:54605 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751254AbaAKLTb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jan 2014 06:19:31 -0500
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mx.arcor.de (Postfix) with ESMTP id 8F57219846E;
	Sat, 11 Jan 2014 12:19:29 +0100 (CET)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 86C1F33AD59;
	Sat, 11 Jan 2014 12:19:29 +0100 (CET)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 83EBBAA7FB;
	Sat, 11 Jan 2014 12:19:29 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-04.arcor-online.net 83EBBAA7FB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1389439169; bh=9TAcIbM8sCyXn7OayMcwcq3YtHEazccDl/Oo6R3g/e8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=SaByoIEbIieXGi/tZ/v5cxbT3fZf1du0LKaP0aR2LSThOLK4rjljUL9q2q6n5tWWe
	 Yz+dpN5x6T0zoiQVZPaq7pmw2qxhi3bAVXctT4Hze8y0MEMpKPkY2ZcCfNY1RwMwkP
	 suZxAscxuMLZo7M01TkwgKYvH+7kDM3DmqxyDJyI=
Received: from [178.7.25.41] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 11 Jan 2014 12:19:29 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.25.41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240328>


- Add to Documentation/Makefile
- Start every TODO with a new line
- Fix indentation error

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/Makefile                    | 1 +
 Documentation/technical/http-protocol.txt | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 36c58fc..b4a4c82 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -70,6 +70,7 @@ TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
 TECH_DOCS += technical/trivial-merge
+TECH_DOCS += technical/http-protocol
 SP_ARTICLES += $(TECH_DOCS)
 SP_ARTICLES += technical/api-index
 
diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index d21d77d..c64a5e9 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -332,6 +332,7 @@ server advertises capability "allow-tip-sha1-in-want".
   have_list         =  *PKT-LINE("have" SP id LF)
 
 TODO: Document this further.
+
 TODO: Don't use uppercase for variable names below.
 
 The Negotiation Algorithm
@@ -376,10 +377,8 @@ The computation to select the minimal pack proceeds as follows
 
      Commands MUST appear in the following order, if they appear
      at all in the request stream:
-
        * want
        * have
-
      The stream is terminated by a pkt-line flush ("0000").
 
      A single "want" or "have" command MUST have one hex formatted
-- 
1.8.5.2.msysgit.0


---
Thomas
