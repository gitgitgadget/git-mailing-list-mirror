From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/9] sparse: Fix an "symbol 'cmd_index_pack' not declared"
 warning
Date: Thu, 07 Apr 2011 19:23:40 +0100
Message-ID: <4D9E012C.4080903@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 21:13:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7ue0-0001hN-A6
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 21:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714Ab1DGTNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 15:13:23 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:59667 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756708Ab1DGTNW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 15:13:22 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1Q7uKF-0002Tw-iO; Thu, 07 Apr 2011 18:53:04 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171081>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin/index-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 31f001f..e40451f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "delta.h"
 #include "pack.h"
 #include "csum-file.h"
-- 
1.7.4
