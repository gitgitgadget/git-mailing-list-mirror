From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 1/2] git-repack: use non-dashed update-server-info
Date: Sat,  4 Apr 2009 11:59:55 -0500
Message-ID: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 19:02:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq9Fj-0006uk-WA
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 19:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbZDDRAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 13:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbZDDRAH
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 13:00:07 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:12735 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbZDDRAG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 13:00:06 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1467811ywb.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=1O/qAmd+QgfWsHO16dDs4NxuZqlX33W+5LGrDVHGga8=;
        b=N4HZpUS5BHLLKiKcNedCLNDfKDVTmAIe938AZN2I9wkjN7eIlXVAN329iDKeR9LoNX
         Ds3TMDnc/ar6a312jG5DkxYzo8yDU3nynLmZ0jze9n2rrRJ8CdI9sVpCEojevdmQwDuP
         F8pn5N5f6BU+bEHhvIIcvY2H1D+7zyEUwpN4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=huwav8iAYQsA2pFauzi5rBLJNnhugk82y/ZVv3aFokXBT+d19McUUXs6AoVoAjkCaW
         9cEAutwPEYQAFBzehkeH/+JVVhYXj7KX7wRLLmRb6eHLfWByLclKvjH7hlE3M0ulfD6h
         VXwVCPNhIgB83AqY7uXxfD8Q57BKQOOM+0Abs=
Received: by 10.100.121.12 with SMTP id t12mr647357anc.113.1238864403847;
        Sat, 04 Apr 2009 10:00:03 -0700 (PDT)
Received: from localhost (adsl-76-193-181-72.dsl.chcgil.sbcglobal.net [76.193.181.72])
        by mx.google.com with ESMTPS id d38sm9949720and.49.2009.04.04.10.00.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 10:00:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.404.ge96f3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115586>

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 git-repack.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 1782a23..0868734 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -181,5 +181,5 @@ fi
 
 case "$no_update_info" in
 t) : ;;
-*) git-update-server-info ;;
+*) git update-server-info ;;
 esac
-- 
1.6.2.2.404.ge96f3.dirty
