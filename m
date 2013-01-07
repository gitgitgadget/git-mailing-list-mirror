From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] Documentation on depth option in git clone.
Date: Mon,  7 Jan 2013 19:10:55 +0100
Message-ID: <1357582255-17859-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: gitster@pobox.com, schlotter@users.sourceforge.net,
	Ralf.Wildenhues@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 19:11:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsHAU-00087i-2Q
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 19:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab3AGSLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 13:11:05 -0500
Received: from mail-ee0-f54.google.com ([74.125.83.54]:56889 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab3AGSLE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 13:11:04 -0500
Received: by mail-ee0-f54.google.com with SMTP id c13so9564042eek.13
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 10:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=8ARFPTFjC9YqLZ8B20a8pZ5/EEw0fzwRLg+n3nZfuc0=;
        b=DHcceJMLoqnf7Ah/PIuasgGCXhG2Vgz26TsehPfgTSNZJXqXKtTD/YQpEAoTmf2iP+
         jHE6P4IhpYIbJ9I06ZBo+SekRfQaWl0svV8Y2PPA0XE2FBObDmiz3DD8LEGTJ7Zf6CW9
         EtlPykIdLmAjMy0XHt0xO1qfVEYyuITRaixUVWCt5YW1cqyRxN3S+ReBCgZkDnGFRVa1
         fB6jvrCLoCB/Pq1H5hyuloaM7T+yAx1/pAZhAM0ZSReiksczEzgfbgr7H2Lhet+c7iuY
         1KIKO7CQKGKaEqetf+n23RrUZrfAyjNYj9ZAwW6xnvKyD+SjLd4LKj62bsRk9ICgs03u
         oJog==
X-Received: by 10.14.0.3 with SMTP id 3mr166210151eea.16.1357582262762;
        Mon, 07 Jan 2013 10:11:02 -0800 (PST)
Received: from localhost (ip-109-91-111-92.unitymediagroup.de. [109.91.111.92])
        by mx.google.com with ESMTPS id w44sm130480951eep.6.2013.01.07.10.11.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Jan 2013 10:11:02 -0800 (PST)
X-Mailer: git-send-email 1.8.1.80.g3e293fb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212910>

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 Documentation/git-clone.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 7fefdb0..e76aa50 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -186,7 +186,8 @@ objects from the source repository into a pack in the cloned repository.
 	it, nor push from nor into it), but is adequate if you
 	are only interested in the recent history of a large project
 	with a long history, and would want to send in fixes
-	as patches.
+	as patches. The depth should be at least 1. If it is 0 or
+	below, the cloned repository will not be shallow.
 
 --single-branch::
 	Clone only the history leading to the tip of a single branch,
-- 
1.8.1.80.g3e293fb.dirty
