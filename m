From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] shortlog: remove --help option parsing
Date: Mon, 1 Oct 2007 12:20:21 +0200
Message-ID: <20071001102020.GA8315@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 12:22:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcIQH-0002ZP-QC
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 12:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbXJAKWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 06:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbXJAKWf
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 06:22:35 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:44148 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbXJAKWf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 06:22:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 1596E60006B
	for <git@vger.kernel.org>; Mon,  1 Oct 2007 12:22:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6+hG2m-lxa-8 for <git@vger.kernel.org>;
	Mon,  1 Oct 2007 12:22:32 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 5BFC660014D
	for <git@vger.kernel.org>; Mon,  1 Oct 2007 12:20:21 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 243F16DF8B3
	for <git@vger.kernel.org>; Mon,  1 Oct 2007 12:15:10 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 39436632B6; Mon,  1 Oct 2007 12:20:21 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59594>

This option is handled globally.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 builtin-shortlog.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 3fe7546..518f27f 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -264,7 +264,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 			wrap_lines = 1;
 			parse_wrap_args(argv[1], &in1, &in2, &wrap);
 		}
-		else if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
+		else if (!strcmp(argv[1], "-h"))
 			usage(shortlog_usage);
 		else
 			break;
-- 
1.5.3.2.1029.gc1d178


-- 
Jonas Fonseca
