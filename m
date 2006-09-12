From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Fix space in string " false" problem in "trace.c".
Date: Tue, 12 Sep 2006 06:43:08 +0200
Message-ID: <20060912064308.586acdbd.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 12 06:37:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GN01S-0006gK-81
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 06:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWILEhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 00:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWILEhN
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 00:37:13 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:29896 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S965163AbWILEhM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Sep 2006 00:37:12 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g19.free.fr (Postfix) with SMTP id B555D19242;
	Tue, 12 Sep 2006 06:37:10 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26880>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trace.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/trace.c b/trace.c
index ce01c34..f9efc91 100644
--- a/trace.c
+++ b/trace.c
@@ -55,7 +55,7 @@ static int get_trace_fd(int *need_close)
 {
 	char *trace = getenv("GIT_TRACE");
 
-	if (!trace || !strcmp(trace, "0") || !strcasecmp(trace," false"))
+	if (!trace || !strcmp(trace, "0") || !strcasecmp(trace, "false"))
 		return 0;
 	if (!strcmp(trace, "1") || !strcasecmp(trace, "true"))
 		return STDERR_FILENO;
-- 
1.4.2.g886e
