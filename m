From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] Reword repack documentation to no longer state it's a script
Date: Sat, 19 Oct 2013 01:25:22 +0200
Message-ID: <1382138722-5278-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 19 01:25:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXJQC-0006CR-QE
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 01:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240Ab3JRXZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 19:25:27 -0400
Received: from mail-ea0-f171.google.com ([209.85.215.171]:38870 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab3JRXZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 19:25:26 -0400
Received: by mail-ea0-f171.google.com with SMTP id n15so2392663ead.30
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qa+WM4tu/ncPyQ3aN2hRy5tVvzYWS9xQLifByjV7T7I=;
        b=vwyrwUbl/6koaSgKuL1St6Mn65YcuCwKL8oetICQ7mmJuqzZlwo+PJqvNSILw0J295
         MZN3eE3jVjK9T5P62HrP6gzVZxRLIg5K+5iCL/dAIAxT7KK60fDWBNJzR5lrRvZdCGoI
         6MIF8sRonnuI1eAXU48GCm6uF1IMyhVoWNX8zucxDBmNnrQPYLrNDDlG+tLwcreMDMtZ
         aruN/drLpttXQ12Mf8ZVRx8zE6GtvbVlYIQOPemFmNwwf3ZsU7ZztHZ93dCyf/R+jilY
         5j4oWsaAyuFWcxlbFCzBpCGpbfwhSHncpFdXYyaYyG1cUzZFrnZ+Fg1qqOCeWidEzlQc
         yCGQ==
X-Received: by 10.14.218.5 with SMTP id j5mr5971eep.134.1382138725303;
        Fri, 18 Oct 2013 16:25:25 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id f49sm10411845eec.7.2013.10.18.16.25.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 18 Oct 2013 16:25:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.1.511.g52c26ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236378>

This updates the documentation regarding the changes introduced
by a1bbc6c01 (2013-09-15, repack: rewrite the shell script in C).

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 Documentation/git-repack.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 4c1aff6..509cf73 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-This script is used to combine all objects that do not currently
+This command is used to combine all objects that do not currently
 reside in a "pack", into a pack.  It can also be used to re-organize
 existing packs into a single, more efficient pack.
 
-- 
1.8.4.1.511.g52c26ce
