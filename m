From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/6] Documentation/git: drop outdated Cogito reference
Date: Tue, 28 Jul 2015 16:06:11 -0400
Message-ID: <1438113975-4915-3-git-send-email-sunshine@sunshineco.com>
References: <1438113975-4915-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 22:06:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKB9H-0001VV-Ca
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbbG1UGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:06:47 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34685 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbbG1UGq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:06:46 -0400
Received: by igk11 with SMTP id 11so122594350igk.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kh2qpM7P4G4kkAAidk0JGlzPknl1sijHkeqCoc/qarU=;
        b=DzGw1WFx91o/4gs6WaDZm82gzBGo6A3Lb63Vn7WjR54iXNxedUTCke7E/OPjec73A5
         b5AnvgUc3Gw2x4S2VEF7rQPZ73CSQCDVxsmr9TwnaCgJhYMQA5bJhHMzMTJ0nRp7p2Bk
         lFuP/O9Qgw55eBBwzRiqneRrYp/f8kSpm6TzBhlw4ro+98K6BIsOqGQIEN5dDd8euIyL
         02PH/WLQaMrLxH8Il5nbYGsA8Cjhd46EKzxXcjN1gdktsCOLASKFspym2Z0BSdQF9VCy
         KNIOXuPlWgRPS6JL8z0kTdp3SfV915ZtymnZME6PvCM0cSA1t063acOBjPMqf1YYQ2E5
         4tnQ==
X-Received: by 10.50.98.3 with SMTP id ee3mr10230911igb.10.1438114006055;
        Tue, 28 Jul 2015 13:06:46 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id r16sm15195896ioe.19.2015.07.28.13.06.44
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 13:06:45 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3.490.g8c70279
In-Reply-To: <1438113975-4915-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274829>

Cogito hasn't been maintained since late 2006, so drop the reference
to it. The warning that SCMS front-ends might override listed
environment variables, however, may still be valuable, so keep it but
generalize the wording.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

No changes since v1.

 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index ef76f95..21bc0a5 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -744,7 +744,7 @@ The Git Repository
 ~~~~~~~~~~~~~~~~~~
 These environment variables apply to 'all' core Git commands. Nb: it
 is worth noting that they may be used/overridden by SCMS sitting above
-Git so take care if using Cogito etc.
+Git so take care if using a foreign front-end.
 
 'GIT_INDEX_FILE'::
 	This environment allows the specification of an alternate
-- 
2.5.0.rc3.490.g8c70279
