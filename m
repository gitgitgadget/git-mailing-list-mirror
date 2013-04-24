From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/5] git-diff.txt: document the .. and ... forms in SYNOPSIS
Date: Wed, 24 Apr 2013 22:03:35 +0530
Message-ID: <1366821216-20868-5-git-send-email-artagnon@gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 24 18:34:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV2du-0007vs-GG
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 18:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888Ab3DXQdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 12:33:49 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:46929 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756234Ab3DXQdq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 12:33:46 -0400
Received: by mail-pd0-f180.google.com with SMTP id u10so1245872pdi.39
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=V3CFEfiy6KOG5XaWKP6gA/hUKH+MFLW80h3xSunpvzY=;
        b=yYIiuU2m0EDuSTNxEbnOHE3wq6efJxhinWOwopzayWhm//F8+QTMs5O/zQsdusi3BH
         yGFwTJRZ2RiyRWS4JqMhLuc/GR7nokcBEklOIjZeQEmo29cq2S4fM7erklQJS0paCuvE
         SK8WgEoH2z0Q6NxT8oXcTQhV9imGpTRmWor06sb4er/Ufm1WaHbNPyf9P8ojJnUk2TSW
         c0x4zDKdm4ClPxlj1eiKIMXtOo4snqAQ60P7+bvi+ipMA2Y2eYLfx5sutNtH6wPBRqJS
         USNAH7z0mvrnh9Wfg0b893MqTcqsiqjfl4y18wK0Y5759tR+TRyOR0cVYTwTu8sYF0aC
         FVsA==
X-Received: by 10.68.101.226 with SMTP id fj2mr48766280pbb.6.1366821225609;
        Wed, 24 Apr 2013 09:33:45 -0700 (PDT)
Received: from localhost.localdomain ([122.164.164.124])
        by mx.google.com with ESMTPSA id dr4sm3646798pbb.19.2013.04.24.09.33.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 09:33:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.502.g2d60b5c
In-Reply-To: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222265>

The DESCRIPTION refers to the '<commit>..<commit>' and
'<commit>...<commit>' forms, but the SYNOPSIS does not list them at
all.  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-diff.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index a0fdfc2..291e250 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -13,6 +13,8 @@ SYNOPSIS
 'git diff' [options] --cached [<commit>] [[--] [<path>...]]
 'git diff' [options] <blob> <blob>
 'git diff' [options] <commit> <commit> [[--] [<path>...]]
+'git diff' [options] <commit>..<commit> [[--] [<path>...]]
+'git diff' [options] <commit>\...<commit> [[--] [<path>...]]
 'git diff' [options] [--no-index] [[--] <path> <path>]
 
 DESCRIPTION
-- 
1.8.2.1.502.g2d60b5c
