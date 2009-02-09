From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] builtin-receive-pack.c: do not initialize statics to 0
Date: Mon,  9 Feb 2009 01:09:20 -0800
Message-ID: <1234170565-6740-2-git-send-email-gitster@pobox.com>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 10:10:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWSAM-0004Ri-7l
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 10:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbZBIJJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 04:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbZBIJJc
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 04:09:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60471 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbZBIJJa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 04:09:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C95D2ABFD
	for <git@vger.kernel.org>; Mon,  9 Feb 2009 04:09:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A71FA2ABE6 for
 <git@vger.kernel.org>; Mon,  9 Feb 2009 04:09:29 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc0.28.g2593d
In-Reply-To: <1234170565-6740-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5BBC88AA-F689-11DD-8AD9-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109052>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-receive-pack.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 6de186c..b2cb4ba 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -18,8 +18,8 @@ enum deny_action {
 	DENY_REFUSE,
 };
 
-static int deny_deletes = 0;
-static int deny_non_fast_forwards = 0;
+static int deny_deletes;
+static int deny_non_fast_forwards;
 static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
 static int receive_fsck_objects;
 static int receive_unpack_limit = -1;
-- 
1.6.2.rc0.28.g2593d
