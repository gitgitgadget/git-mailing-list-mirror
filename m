From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [RFC 1/3] wt-status: Make conflict hint message more consistent with other hints
Date: Wed, 26 Feb 2014 13:06:23 -0500
Message-ID: <1393437985-31401-2-git-send-email-andrew.kw.w@gmail.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 26 19:06:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIisW-0004U4-3o
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 19:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbaBZSGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 13:06:38 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:55800 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbaBZSGh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 13:06:37 -0500
Received: by mail-ie0-f173.google.com with SMTP id lx4so999201iec.32
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 10:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HEioRiEM51BKLAB08AcWRZxmzehiXfwzPKqUd379cPA=;
        b=z9wFJiDM2rql3rPeWhFeB2/NHzFFae9QQeOfwVJjJ/TNfsmopyAeQ/bnxQSOaeGOG8
         x4mvzFuLiOM75aA900FQrTC5LbMXWsC6tm1XsaGrrzi0k729R1YFjrP+e02mJedO0g2T
         8KZnJ94Rzo7BPdBVqzXsA3ytg1Jq+i+8aem8zHTD3KXrTjocXExSjbXnpVrKriRoBPAd
         DHMvz1aQrw6ICkapMfdw02yISvUTrRK65tfkiQXxmNrq95z6B6r1M2Xpe62V2G2oiLmV
         FcThIGbisFGsAIgIkTc9GkkagEQDnqBxhvKfZc8SMudBjbgOI5p+pKdFYxaGITAatRg4
         GweQ==
X-Received: by 10.43.79.66 with SMTP id zp2mr753811icb.76.1393437996953;
        Wed, 26 Feb 2014 10:06:36 -0800 (PST)
Received: from dresden.sidefx.com (nat.sidefx.com. [38.104.156.10])
        by mx.google.com with ESMTPSA id kb5sm1968331igb.1.2014.02.26.10.06.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Feb 2014 10:06:36 -0800 (PST)
X-Mailer: git-send-email 1.9.0.7.g53f6706
In-Reply-To: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242741>

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 wt-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 4e55810..6e1ad7d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -899,7 +899,7 @@ static void show_merge_in_progress(struct wt_status *s,
 		status_printf_ln(s, color, _("You have unmerged paths."));
 		if (s->hints)
 			status_printf_ln(s, color,
-				_("  (fix conflicts and run \"git commit\")"));
+				_("  (fix conflicts, and use \"git commit\" to conclude the merge)"));
 	} else {
 		status_printf_ln(s, color,
 			_("All conflicts fixed but you are still merging."));
-- 
1.9.0.6.g16e5f9a
