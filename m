From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/4] ll-merge: initialize default_opts const
Date: Tue, 15 Nov 2011 22:29:38 +0530
Message-ID: <1321376379-31750-4-git-send-email-artagnon@gmail.com>
References: <1321376379-31750-1-git-send-email-artagnon@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 18:01:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQMO7-0002AI-B3
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 18:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862Ab1KORB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 12:01:26 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42567 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643Ab1KORBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 12:01:25 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so5918756eye.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 09:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=h3tpX1UbsWzj/Wye8f5cRHYh7fVxkEruq3yPaAArRbo=;
        b=YmgLRcka2RUyEaCtCC3Ug+NxcWFNuQRZHRJc7Nhdwsw6EIneoNsthma2lsyAcQHvDN
         JI0pKrwDcvVNIWIYe5nAj8y21wYaTly89BDeSI0kkMPmZYYes99ABH+ML/lBbh6276D7
         UxOOX2Y8TB0VbTfbmoEqoKGjVf3i5Ykw1NFAg=
Received: by 10.68.38.71 with SMTP id e7mr60109024pbk.88.1321376483940;
        Tue, 15 Nov 2011 09:01:23 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id f2sm37889376pbg.14.2011.11.15.09.01.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 09:01:22 -0800 (PST)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1321376379-31750-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185470>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 ll-merge.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index da59738..205aed3 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -351,7 +351,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	     const struct ll_merge_options *opts)
 {
 	static struct git_attr_check check[2];
-	static const struct ll_merge_options default_opts;
+	static const struct ll_merge_options default_opts = {0, 0, 0, 0};
 	const char *ll_driver_name = NULL;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	const struct ll_merge_driver *driver;
-- 
1.7.6.351.gb35ac.dirty
