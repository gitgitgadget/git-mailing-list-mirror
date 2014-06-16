From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] doc: State coding guideline for error message punctuation
Date: Mon, 16 Jun 2014 13:55:57 +0100
Message-ID: <1402923357-3788-2-git-send-email-philipoakley@iee.org>
References: <1402923357-3788-1-git-send-email-philipoakley@iee.org>
Cc: Jeff King <peff@peff.net>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 14:56:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwWS6-0000Cf-8F
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 14:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbaFPMzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 08:55:51 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:58461 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751188AbaFPMzt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2014 08:55:49 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AksLAHjonlMCYJ7h/2dsb2JhbABagw1SEQPDXwELgQUXdYQEAQVWIxAISTkeBhOIRgnPJheOdgcuhBUEnAaSFYNBPC8BAQ
X-IPAS-Result: AksLAHjonlMCYJ7h/2dsb2JhbABagw1SEQPDXwELgQUXdYQEAQVWIxAISTkeBhOIRgnPJheOdgcuhBUEnAaSFYNBPC8BAQ
X-IronPort-AV: E=Sophos;i="5.01,486,1400022000"; 
   d="scan'208";a="462724098"
Received: from host-2-96-158-225.as13285.net (HELO localhost) ([2.96.158.225])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 16 Jun 2014 13:55:48 +0100
X-Mailer: git-send-email 1.9.4.msysgit.0
In-Reply-To: <1402923357-3788-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251716>

Clarify error message puntuation to reduce review workload [1].

[1] http://article.gmane.org/gmane.comp.version-control.git/251547
(see trailing 'nit' item).

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/CodingGuidelines | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 4d90c77..b2f3442 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -404,6 +404,13 @@ For Python scripts:
    documentation for version 2.6 does not mention this prefix, it has
    been supported since version 2.6.0.
 
+Error Messages
+
+ - We typically do not end error messages with a full stop. While
+   we've been rather inconsistent in the past, these days we mostly
+   settle on no punctuation.
+
+
 Writing Documentation:
 
  Most (if not all) of the documentation pages are written in the
-- 
1.9.4.msysgit.0
