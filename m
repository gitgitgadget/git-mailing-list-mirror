From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/6] transport-helper: update refspec documentation
Date: Wed, 17 Apr 2013 23:14:29 -0500
Message-ID: <1366258473-12841-3-git-send-email-felipe.contreras@gmail.com>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 06:15:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USgGM-00024p-Gx
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 06:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab3DREPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 00:15:52 -0400
Received: from mail-gg0-f169.google.com ([209.85.161.169]:49696 "EHLO
	mail-gg0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab3DREPv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 00:15:51 -0400
Received: by mail-gg0-f169.google.com with SMTP id h3so149891gge.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 21:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fwd/qEtmFzDVUNd6wkaYZWi5nQkgQfZojSuz6rrJR5Q=;
        b=BwIRrkOe7NlfPKMdcgheivHytEehj0yWHvmidnQfcRkP6dXphlRVLZ23ZqMZmg680u
         X8c/kgzVsIQRBJDrH3r3qJLcTm+RFGsR+Si7dnkYAbHhzZt+jHrh3jeMhN/wB0Olzsjs
         ca3nfc502dlKqyrrzKNCph6QZbcmQpcpNKmqMMl1L5ztefKXBWcBPWPMkpgCpVII7bdf
         oMFj279hKkNvqJEspufaIbWanO4QsEb3wjKkdWD2bwrdbDrcekSW+uJNWpO+eE1wGB06
         MuxgDJywqNp0LSmI7YLBz19SMF3b66OrPMilPytYz0YTevqzyzzBt0zmjr3DAobNaL2l
         78Gw==
X-Received: by 10.236.160.97 with SMTP id t61mr6334386yhk.150.1366258550452;
        Wed, 17 Apr 2013 21:15:50 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id l70sm14600073yha.1.2013.04.17.21.15.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 21:15:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.679.g509521a
In-Reply-To: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221605>

The refspec capability is not only used by 'import', also by 'export',
and it's recommend in both.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/gitremote-helpers.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 0c91aba..ba7240c 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -159,11 +159,11 @@ Miscellaneous capabilities
 	carried out.
 
 'refspec' <refspec>::
-	This modifies the 'import' capability, allowing the produced
-	fast-import stream to modify refs in a private namespace
-	instead of writing to refs/heads or refs/remotes directly.
-	It is recommended that all importers providing the 'import'
-	capability use this.
+	For remote helpers that implement 'import' or 'export', this capability
+	allows the refs to be constrained to a private namespace, instead of
+	writing to refs/heads or refs/remotes directly.
+	It is recommended that all importers providing the 'import' or 'export'
+	capabilities use this.
 +
 A helper advertising the capability
 `refspec refs/heads/*:refs/svn/origin/branches/*`
-- 
1.8.2.1.679.g509521a
