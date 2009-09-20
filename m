From: Junio C Hamano <gitster@pobox.com>
Subject: [WIP PATCH 2/6] unpack-trees: typofix
Date: Sat, 19 Sep 2009 22:06:11 -0700
Message-ID: <1253423175-6339-3-git-send-email-gitster@pobox.com>
References: <1253423175-6339-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 07:06:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpEdG-00044A-O0
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 07:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbZITFGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 01:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbZITFGV
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 01:06:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbZITFGU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 01:06:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BB06157559
	for <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Ltsz
	GIM5YRXkh3vDwBHSFvGyeOQ=; b=d1DUn/KDM373q1nNmb0BcqS+aJCROMfztu11
	Djt7bcrC5+lqHCmG3FBOTPza1xmy1CVWEYO+ei21x6JAGc2DwmHoDf+WmPIvuS42
	6/6S86J0ytpyusETvCMqlA/OH8s14GFAHg1H4UUq8VEacKyaU6Q+RA8Oh+KKbplt
	pX58bZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=g7sASP
	fiFknPHlVqj3GEzSMSlicS4lA1qXoSO4TTosAwNk95xuku1qygf1PxHSYlJT3CuQ
	lxcGytJiB3CsZA4VdDPOhhISoxmxZPSUCa9p3xB8czxWj5yBErsgUnFfePFZzzuM
	P3tqcwK+62fCB19bGMdC65OX+HT82rv3Ejz4g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B84BD57556
	for <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 47A8457555 for
 <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:22 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc1.90.ga3b1b
In-Reply-To: <1253423175-6339-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 57AFB9B6-A5A3-11DE-82C1-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128838>

I am not good at subject-verb concordance.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 720f7a1..d174fe0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -617,7 +617,7 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 			 * found "foo/." in the working tree.
 			 * This is tricky -- if we have modified
 			 * files that are in "foo/" we would lose
-			 * it.
+			 * them.
 			 */
 			ret = verify_clean_subdirectory(ce, action, o);
 			if (ret < 0)
-- 
1.6.5.rc1.90.ga3b1b
