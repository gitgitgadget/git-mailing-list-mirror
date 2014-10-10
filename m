From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v4 2/3] doc: Makefile regularise OBSOLETE_HTML list building
Date: Fri, 10 Oct 2014 22:25:36 +0100
Message-ID: <1412976337-2476-3-git-send-email-philipoakley@iee.org>
References: <1412976337-2476-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 23:25:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XchhG-00007J-5U
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 23:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbaJJVZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 17:25:44 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:56140 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755260AbaJJVZn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Oct 2014 17:25:43 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: An4KAHBOOFRZ8YyOPGdsb2JhbABggw6BK4I2hQeBd8k6BAICgQQXAQEFAQEBATg5hAQBBVYjEAhJOQoUBhOIQr9uAQEBByKPYGQHhEsFqieNLTwvgQaBRAEBAQ
X-IPAS-Result: An4KAHBOOFRZ8YyOPGdsb2JhbABggw6BK4I2hQeBd8k6BAICgQQXAQEFAQEBATg5hAQBBVYjEAhJOQoUBhOIQr9uAQEBByKPYGQHhEsFqieNLTwvgQaBRAEBAQ
X-IronPort-AV: E=Sophos;i="5.04,694,1406588400"; 
   d="scan'208";a="648230644"
Received: from host-89-241-140-142.as13285.net (HELO localhost) ([89.241.140.142])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 10 Oct 2014 22:25:41 +0100
X-Mailer: git-send-email 1.9.4.msysgit.0
In-Reply-To: <1412976337-2476-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index cea0e7a..3b56714 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -5,6 +5,7 @@ MAN7_TXT =
 TECH_DOCS =
 ARTICLES =
 SP_ARTICLES =
+OBSOLETE_HTML =
 
 MAN1_TXT += $(filter-out \
 		$(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
@@ -37,7 +38,7 @@ MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML = $(patsubst %.txt,%.xml,$(MAN_TXT))
 MAN_HTML = $(patsubst %.txt,%.html,$(MAN_TXT))
 
-OBSOLETE_HTML = git-remote-helpers.html
+OBSOLETE_HTML += git-remote-helpers.html
 DOC_HTML = $(MAN_HTML) $(OBSOLETE_HTML)
 
 ARTICLES += howto-index
-- 
1.9.4.msysgit.0
