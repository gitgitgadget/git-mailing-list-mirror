From: Jim Hill <gjthill@gmail.com>
Subject: [PATCH w/signoff] pre-push.sample: Remove unwanted `IFS=' '`.
Date: Sun, 21 Dec 2014 10:25:37 -0800
Message-ID: <1419186337-20348-1-git-send-email-gjthill@gmail.com>
References: <1419185665-19988-1-git-send-email-gjthill@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 19:26:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2lD5-0006dX-Ej
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 19:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbaLUSZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 13:25:50 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:50983 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbaLUSZu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 13:25:50 -0500
Received: by mail-yk0-f171.google.com with SMTP id 142so1706807ykq.16
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 10:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8ooVLm7NXRFVGx/Hb65SALXghWqcshCGZnhJCfvexug=;
        b=efZHnc3/vn3cTRC3KdsJjxAvIP1Za48ZRieHN37bT/jLRFv2ynlIfENw2d5sKUwr+0
         3J8pe86o1xCYUx724KEHlWQwn1FGXvH/e8+Zm+oQ8XSo9UQGnqRZmAVNyL6wMRJ1iELg
         Si8z71m0MKSIMnKDUW082nDSw/mMV2kKCoHF87Ul5bDK5BEnQfK2e/9OqVL8VTAxmFJb
         z8tMXnL5skFvJNIY7QDoz9JmXiiuPHUer5rmk2lVCInSD6uTrTKf7BJ6v4yFjK6gOXhD
         vJsCLZT77aUJsvlD7gA+51yD8PyoX7qqqC0IsVDE+1LwMchi8btXrLR/4lVpENGTg2Yy
         hSXg==
X-Received: by 10.170.220.213 with SMTP id m204mr8573139ykf.75.1419186349340;
        Sun, 21 Dec 2014 10:25:49 -0800 (PST)
Received: from gadabout.domain.actdsltmp (pool-71-189-147-248.lsanca.fios.verizon.net. [71.189.147.248])
        by mx.google.com with ESMTPSA id f45sm10170408yhc.5.2014.12.21.10.25.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Dec 2014 10:25:49 -0800 (PST)
X-Mailer: git-send-email 2.2.1.212.g51be871
In-Reply-To: <1419185665-19988-1-git-send-email-gjthill@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261616>

Signed-off-by: Jim Hill <gjthill@gmail.com>
---
 templates/hooks--pre-push.sample | 1 -
 1 file changed, 1 deletion(-)

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
index 69e3c67..6187dbf 100755
--- a/templates/hooks--pre-push.sample
+++ b/templates/hooks--pre-push.sample
@@ -24,7 +24,6 @@ url="$2"
 
 z40=0000000000000000000000000000000000000000
 
-IFS=' '
 while read local_ref local_sha remote_ref remote_sha
 do
 	if [ "$local_sha" = $z40 ]
-- 
2.2.1.212.g51be871
