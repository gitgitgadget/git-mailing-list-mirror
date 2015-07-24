From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/6] Documentation/git: drop outdated Cogito reference
Date: Fri, 24 Jul 2015 00:00:54 -0400
Message-ID: <1437710457-38592-4-git-send-email-sunshine@sunshineco.com>
References: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 06:01:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUB7-0004MA-Ed
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbbGXEBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:01:39 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35157 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbbGXEBg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:01:36 -0400
Received: by igr7 with SMTP id 7so7267846igr.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4WZQ0kcHZn7A5Y3vmupw6Kj/bwwItrzYwrymrRYTdi0=;
        b=P3ofG+nnxFP37hCL05NLhJaAhTyMfRHv770K84oyGW1SGTkjqJn3HyA/h69/cwXCR9
         Fexxjm5Zou6mnMjgaHoPEeLxHGTkE4qTO0VIi1QbeP7siWCZ3QifoaWe7vSRKAvDJnT1
         HAr8sd6YpVMO+SO2nQ+xtr8kg30z7ukiHomNqGlROm/bjEP2Ez5cP6WBWxQVcQjaNwBC
         v9Ilb0TspW040VeZIcrTQF619NIJbocg9eXW1l3SR3uAe0qCEBQ1ItTD9EPtjFjIG7EC
         KTxAjxOg4xrPJZJicX3xcBiEGCIdgsi8CMoc31xAoz25z+vH71pWnWbdo9vdsDrY7bJM
         QR1Q==
X-Received: by 10.50.36.101 with SMTP id p5mr3009179igj.58.1437710495300;
        Thu, 23 Jul 2015 21:01:35 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j2sm4370288ioo.43.2015.07.23.21.01.34
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:01:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3.407.g68aafd0
In-Reply-To: <1437710457-38592-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274538>

Cogito hasn't been maintained since late 2006, so drop the reference
to it. The warning that SCMS front-ends might override listed
environment variables, however, may still be valuable, so keep it but
generalize the wording.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Reference: http://article.gmane.org/gmane.comp.version-control.git/274084

 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 1e8a569..ef774be 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -774,7 +774,7 @@ The Git Repository
 ~~~~~~~~~~~~~~~~~~
 These environment variables apply to 'all' core Git commands. Nb: it
 is worth noting that they may be used/overridden by SCMS sitting above
-Git so take care if using Cogito etc.
+Git so take care if using a foreign front-end.
 
 'GIT_INDEX_FILE'::
 	This environment allows the specification of an alternate
-- 
2.5.0.rc3.407.g68aafd0
