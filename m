From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH] base85: encode85() does not use the decode table
Date: Fri,  8 Jan 2010 17:17:50 +0100
Message-ID: <1262967470-31782-1-git-send-email-agruen@suse.de>
References: <7v3a2giobm.fsf@alter.siamese.dyndns.org>
Cc: Andreas Gruenbacher <agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 17:20:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTHZp-00025m-1b
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 17:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869Ab0AHQUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 11:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868Ab0AHQUh
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 11:20:37 -0500
Received: from mail09.linbit.com ([212.69.161.110]:41785 "EHLO
	mail09.linbit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750Ab0AHQUg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 11:20:36 -0500
Received: from murkel-lan.suse.de (unknown [78.142.182.101])
	by mail09.linbit.com (LINBIT Mail Daemon) with ESMTP id A7C57105DB6C;
	Fri,  8 Jan 2010 17:20:35 +0100 (CET)
Received: by murkel-lan.suse.de (Postfix, from userid 1000)
	id B245C190F5; Fri,  8 Jan 2010 17:17:54 +0100 (CET)
X-Mailer: git-send-email 1.6.6.75.g37bae
In-Reply-To: <7v3a2giobm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136452>

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
