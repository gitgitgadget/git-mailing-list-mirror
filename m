From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] format-patch: remove a leftover debugging message
Date: Wed, 27 Feb 2008 22:18:47 -0800
Message-ID: <7v8x15li2g.fsf_-_@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802251822240.19024@iabervon.org>
 <7v1w70h96u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 07:19:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUc7C-0006zG-8M
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 07:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbYB1GS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 01:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbYB1GS5
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 01:18:57 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbYB1GS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 01:18:56 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 80DC117A0;
	Thu, 28 Feb 2008 01:18:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B5753173E; Thu, 28 Feb 2008 01:18:49 -0500 (EST)
In-Reply-To: <7v1w70h96u.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 25 Feb 2008 16:07:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75358>

Sorry, Daniel ;-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-log.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 3209ea5..836b61e 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -960,7 +960,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.boundary = 1;
 	while ((commit = get_revision(&rev)) != NULL) {
 		if (commit->object.flags & BOUNDARY) {
-			fprintf(stderr, "Boundary %s\n", sha1_to_hex(commit->object.sha1));
 			boundary_count++;
 			origin = (boundary_count == 1) ? commit : NULL;
 			continue;
-- 
1.5.4.3.393.g55409
