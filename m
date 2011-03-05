From: Adam Monsen <haircut@gmail.com>
Subject: [PATCH 2/2] English grammar fixes for combined diff doc.
Date: Sat,  5 Mar 2011 11:56:44 -0800
Message-ID: <1299355004-3532-3-git-send-email-haircut@gmail.com>
References: <4D724A0F.7050904@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio Hamano <gitster@pobox.com>,
	Adam Monsen <haircut@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 20:57:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvxbr-0007ar-FF
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 20:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026Ab1CET5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 14:57:50 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:65324 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab1CET5p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 14:57:45 -0500
Received: by pvg12 with SMTP id 12so508122pvg.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 11:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=iJhzbpug4zqB7XSC51AtOQuCVmr7XR0UzPNqN4eplwQ=;
        b=ojVJGlMJIGcamHxWMd2LWIVj3SSYBOira3NvgGxLTXGMciIU/keHs2GVqAt+CylB7a
         7LAsRjI8TqrVqZpPnznnLnJbwLCpzb8MOjGh7CocBwM31B+tYCm32+dPlrjcKhlDxlih
         Ev0hM6kJYuJ4JrP/sBMAPCAIjHnUC0H9nmsXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aVVWFJ/qAyjVg2hjk1eOgBWWKs5ja+dVsKrudg6n81f+LIl0MMyjzYtS98uxbVSmwD
         7ydoGi7ot/Y3ujuwQafFkNSV5TwlnJPA7ojRPJTRXbbPL2UvCZo9gA5A6WDoqFW8bgYi
         sjkqFgFR/fKPMmAjrpk1c9+d4g5hTFeUoDfrs=
Received: by 10.143.26.16 with SMTP id d16mr1555809wfj.309.1299355064573;
        Sat, 05 Mar 2011 11:57:44 -0800 (PST)
Received: from localhost.localdomain (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id w19sm1339031wfd.8.2011.03.05.11.57.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Mar 2011 11:57:43 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <4D724A0F.7050904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168510>

This is incredibly minor, I only separated it from the first patch so it
was easier to see how this is separate from the other change.

Signed-off-by: Adam Monsen <haircut@gmail.com>
---
 Documentation/diff-generate-patch.txt |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 6cd5270..607fa54 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -74,10 +74,9 @@ separate lines indicate the old and the new mode.
 combined diff format
 --------------------
 
-"git-diff-tree", "git-diff-files" and "git-diff" can take '-c' or
-'--cc' option to produce 'combined diff'.  You can force showing
-full diff with the '-m' option.  A 'combined diff' format looks like
-this:
+"git-diff-tree", "git-diff-files" and "git-diff" can take a '-c' or
+'--cc' option to produce 'combined diff' output.  You can force showing
+full diffs with the '-m' option.  A 'combined diff' looks like this:
 
 ------------
 diff --combined describe.c
-- 
1.7.2.3
