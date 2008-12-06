From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] read-cache.c: typofix in comment
Date: Fri,  5 Dec 2008 17:54:11 -0800
Message-ID: <1228528455-3089-3-git-send-email-gitster@pobox.com>
References: <1228528455-3089-1-git-send-email-gitster@pobox.com>
 <1228528455-3089-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 02:55:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8mOc-0005h5-58
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 02:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216AbYLFByf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 20:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755872AbYLFByb
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 20:54:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755083AbYLFBy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 20:54:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 88EFF84EEE
	for <git@vger.kernel.org>; Fri,  5 Dec 2008 20:54:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1136784EED for
 <git@vger.kernel.org>; Fri,  5 Dec 2008 20:54:23 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.72.ga5ce6
In-Reply-To: <1228528455-3089-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CEC37252-C338-11DD-8E0C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102435>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 22a8143..58d3f88 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1486,7 +1486,7 @@ int write_index(const struct index_state *istate, int newfd)
 
 /*
  * Read the index file that is potentially unmerged into given
- * index_state, dropping any unmerged entries.  Returns true is
+ * index_state, dropping any unmerged entries.  Returns true if
  * the index is unmerged.  Callers who want to refuse to work
  * from an unmerged state can call this and check its return value,
  * instead of calling read_cache().
-- 
1.6.1.rc1.72.ga5ce6
