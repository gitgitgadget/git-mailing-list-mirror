From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH 1/3] base85 debug code: Fix length byte calculation
Date: Fri,  8 Jan 2010 14:39:58 +0100
Message-ID: <1262958000-27181-1-git-send-email-agruen@suse.de>
References: <alpine.LFD.2.00.1001071253400.21025@xanadu.home>
Cc: Andreas Gruenbacher <agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 14:50:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTFEa-0006rC-1Y
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 14:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377Ab0AHNuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 08:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753147Ab0AHNub
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 08:50:31 -0500
Received: from mail09.linbit.com ([212.69.161.110]:43940 "EHLO
	mail09.linbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab0AHNua (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 08:50:30 -0500
Received: from murkel-lan.suse.de (unknown [78.142.182.101])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id AC2941072EB4;
	Fri,  8 Jan 2010 14:42:46 +0100 (CET)
Received: by murkel-lan.suse.de (Postfix, from userid 1000)
	id DC75328038; Fri,  8 Jan 2010 14:40:05 +0100 (CET)
X-Mailer: git-send-email 1.6.6.75.g37bae
In-Reply-To: <alpine.LFD.2.00.1001071253400.21025@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136435>

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 base85.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/base85.c b/base85.c
index b417a15..1d165d9 100644
--- a/base85.c
+++ b/base85.c
@@ -118,7 +118,7 @@ int main(int ac, char **av)
 		int len = strlen(av[2]);
 		encode_85(buf, av[2], len);
 		if (len <= 26) len = len + 'A' - 1;
-		else len = len + 'a' - 26 + 1;
+		else len = len + 'a' - 26 - 1;
 		printf("encoded: %c%s\n", len, buf);
 		return 0;
 	}
-- 
1.6.6.75.g37bae
