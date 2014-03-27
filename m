From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH] MSVC: added missing include so `make INLINE=__inline` is no longer required
Date: Thu, 27 Mar 2014 11:34:28 +0400
Message-ID: <1395905668-32005-2-git-send-email-marat@slonopotamus.org>
References: <1395905668-32005-1-git-send-email-marat@slonopotamus.org>
Cc: Marat Radchenko <marat@slonopotamus.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 08:58:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WT5Ck-0007LM-3o
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 08:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbaC0H6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 03:58:18 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:51954 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbaC0H6S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 03:58:18 -0400
X-Greylist: delayed 1411 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Mar 2014 03:58:18 EDT
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WT4qA-0000m9-CX; Thu, 27 Mar 2014 11:35:06 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395905668-32005-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245264>

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 xdiff/xutils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 62cb23d..a21a835 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -23,6 +23,7 @@
 #include <limits.h>
 #include <assert.h>
 #include "xinclude.h"
+#include "git-compat-util.h"
 
 
 
-- 
1.9.1
