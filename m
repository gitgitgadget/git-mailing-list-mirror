From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH] base85: encode_85() does not use the decode table
Date: Fri,  8 Jan 2010 17:22:18 +0100
Message-ID: <1262967738-31996-1-git-send-email-agruen@suse.de>
References: <7v3a2giobm.fsf@alter.siamese.dyndns.org>
Cc: Andreas Gruenbacher <agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 17:25:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTHeF-0004Kx-NP
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 17:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab0AHQZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 11:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753885Ab0AHQZE
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 11:25:04 -0500
Received: from mail09.linbit.com ([212.69.161.110]:42427 "EHLO
	mail09.linbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732Ab0AHQZB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 11:25:01 -0500
Received: from murkel-lan.suse.de (unknown [78.142.182.101])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id 7A240105DB6C;
	Fri,  8 Jan 2010 17:25:00 +0100 (CET)
Received: by murkel-lan.suse.de (Postfix, from userid 1000)
	id 928DE190F5; Fri,  8 Jan 2010 17:22:19 +0100 (CET)
X-Mailer: git-send-email 1.6.6.75.g37bae
In-Reply-To: <7v3a2giobm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136454>

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 base85.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/base85.c b/base85.c
index 1d165d9..7204ce2 100644
--- a/base85.c
+++ b/base85.c
@@ -84,8 +84,6 @@ int decode_85(char *dst, const char *buffer, int len)
 
 void encode_85(char *buf, const unsigned char *data, int bytes)
 {
-	prep_base85();
-
 	say("encode 85");
 	while (bytes) {
 		unsigned acc = 0;
-- 
1.6.6.75.g37bae
