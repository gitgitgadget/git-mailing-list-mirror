From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] INSTALL: minor typo fix
Date: Tue, 27 Jan 2015 22:15:12 +0600
Message-ID: <1422375312-3798-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 17:15:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG8na-0002Pg-OD
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 17:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbbA0QP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 11:15:27 -0500
Received: from mail-la0-f53.google.com ([209.85.215.53]:46355 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbbA0QP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 11:15:26 -0500
Received: by mail-la0-f53.google.com with SMTP id gq15so14151599lab.12
        for <git@vger.kernel.org>; Tue, 27 Jan 2015 08:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rkrCyH361jPApEAYQEF0LxFgvVmIUQNX+0T/znc1Vmg=;
        b=xL2ARs7sCYJrn5YuB0RJHPwbZ+ycksv8O9W5pMo6bPwhbtIMRUjhHI+mBl3ZMX5DTk
         3nI04HtUVkmAGrjpbzQCygVzFbFc0LGGXa0Vp0frueoYebfkk2FwVzne9yjrEEYLSvS0
         6sTPlZFxssl41HhjIgg9mji3za54KhCow7k7L2WxtRLUcOAFi5COPzbT6uGfSXWB/Xu0
         dGySDMzbRW6epkdml+U2MO4aKyNu4x9BV/ZTo5ST+PeotpQlv8IC/x1Nwf6hFwOQFTTQ
         jHzyuJasuOmVb6kzt+etlPY4m7hNYNwtFJDHQd8OjijLze0KVbm6BnUwA9Tk4AMF7tN0
         d1jQ==
X-Received: by 10.112.12.65 with SMTP id w1mr2722725lbb.68.1422375324642;
        Tue, 27 Jan 2015 08:15:24 -0800 (PST)
Received: from localhost.localdomain ([178.89.28.114])
        by mx.google.com with ESMTPSA id q9sm573456lbo.29.2015.01.27.08.15.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Jan 2015 08:15:23 -0800 (PST)
X-Mailer: git-send-email 2.3.0-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263075>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 INSTALL | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/INSTALL b/INSTALL
index ffb071e..6f1c3d5 100644
--- a/INSTALL
+++ b/INSTALL
@@ -53,7 +53,7 @@ or
 
 As a caveat: a profile-optimized build takes a *lot* longer since the
 git tree must be built twice, and in order for the profiling
-measurements to work properly, ccache must be disabled and the test
+measurements to work properly, cache must be disabled and the test
 suite has to be run using only a single CPU.  In addition, the profile
 feedback build stage currently generates a lot of additional compiler
 warnings.
-- 
2.3.0-rc1
