From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] Fix test for new log decorate
Date: Thu, 14 May 2009 00:22:06 +0300
Message-ID: <1242249726-8514-4-git-send-email-felipe.contreras@gmail.com>
References: <1242249726-8514-1-git-send-email-felipe.contreras@gmail.com>
 <1242249726-8514-2-git-send-email-felipe.contreras@gmail.com>
 <1242249726-8514-3-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 23:22:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4LuT-0006Qz-EC
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 23:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761349AbZEMVWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 17:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761209AbZEMVWS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 17:22:18 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:54588 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758205AbZEMVWP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 17:22:15 -0400
Received: by mail-fx0-f158.google.com with SMTP id 2so916293fxm.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 14:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0s1uL79hxQMGfyzYhDhCf+QSS5McNi5zF81c7satBCs=;
        b=VKNZJXD7qMDF3InPiWm7+cUoDqYg870lX7kQU9galPFqO2mkAYmxY5VNuNyVXZ3Efd
         TRlCGaS5geaiyje+vz7YyYbj3CsJ6935O12mZNlQRDL3XJO1RxV8K7idPoOpPjDfP2s/
         UJQFKnkDsAMMbUWvbR+2Y9BBBZzhYbp1MpxG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZVrFupLygjveLwk02Rcw6q7tvJutus2VppEgQI2yrnCLltkmKMU2DFAns8+crBHfjX
         4Q8NQlO0SSuYgw7XxmIKAfOQaO4OrQ5Rc5Jo4CG2NjorusCCYEp4F4wTPK1h/RUiEz7l
         RUX1OBmt7B8wZ32k3CP5x+M0UhUIPusGJHjiA=
Received: by 10.86.70.3 with SMTP id s3mr1756081fga.12.1242249735577;
        Wed, 13 May 2009 14:22:15 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id e11sm4000260fga.1.2009.05.13.14.22.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 14:22:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1242249726-8514-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119111>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t4013/diff.log_--decorate_--all |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
index 12da8ac..954210e 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -1,12 +1,12 @@
 $ git log --decorate --all
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (refs/heads/master)
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (master)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
 
     Merge branch 'side'
 
-commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (refs/heads/side)
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (side)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
 
@@ -26,7 +26,7 @@ Date:   Mon Jun 26 00:01:00 2006 +0000
     
     This is the second commit.
 
-commit 444ac553ac7612cc88969031b02b3767fb8a353a (refs/heads/initial)
+commit 444ac553ac7612cc88969031b02b3767fb8a353a (initial)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:00:00 2006 +0000
 
-- 
1.6.3.1
