From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 19/40] whitespace: remediate t6002-rev-list-bisect.sh
Date: Sat,  6 Aug 2011 18:44:33 +1000
Message-ID: <1312620294-18616-19-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcWR-0005FS-R8
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952Ab1HFIpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:53 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460Ab1HFIpt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:49 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=r6GVDUzudmlxvVBI8jSuECx9S67JYe03Y+rn+9tc48A=;
        b=pE+Vw8ezrP/yHCiwWSK3ZE+VpADrjuBeRFAD+g167qL0QQMQ8zxLjjF/XOFEhoYDz8
         MjJU/9BFH1OtzF8huu/vUd4GUYtFfO4XPI7CSWr0rf/hjjruOoRBTjpTc4IWaloE693J
         wfTNr3PsuTPXMbZa8zb1lhBRkMoV9I9+jm9C8=
Received: by 10.231.117.101 with SMTP id p37mr946668ibq.2.1312620349712;
        Sat, 06 Aug 2011 01:45:49 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178852>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t6002-rev-list-bisect.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index fb07536..c8fac7f 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -18,7 +18,7 @@ test_bisection_diff()
 	shift 2
 	_bisection=$(git rev-list $_bisect_option "$@")
 	_list_size=$(git rev-list "$@" | wc -l)
-        _head=$1
+	_head=$1
 	shift 1
 	_bisection_size=$(git rev-list $_bisection "$@" | wc -l)
 	[ -n "$_list_size" -a -n "$_bisection_size" ] ||
-- 
1.7.6.362.gf0e6
