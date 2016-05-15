From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] attr.c: mark where #if DEBUG ends more clearly
Date: Sun, 15 May 2016 15:57:48 -0700
Message-ID: <xmqqinyf3p5f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 00:58:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b24yz-0006MW-7P
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 00:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbcEOW5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 18:57:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751815AbcEOW5w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 18:57:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 424A819A3F;
	Sun, 15 May 2016 18:57:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=m
	PdzpfkMsqeWOeQPLE8m637qDx0=; b=bIxLYAGu033IoZPZGGG2FJItT+aaPh/Eq
	ds8meVZH/8njH8Gij/SdtZOEMfvtPn8IUFrBIc/9TL+t5SUR9Qbiljyi6AcICXn+
	eGBnKpoIXjMCV2AJDAgvGgX/N/3eVtV4Pwo0+N4lIjmlhm/nmdrxBZb+NLLOdrTR
	zSKVb0lYUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=BD7
	lQDUCvukmgxA4WYKYG6ahfg1tE1TbiIXfqsWonkRQECR9t3iVw2I9JMYzPT9HvZ9
	hzfosOuDUWwHMX65Ay6oNGqykkAo3KMuT+zoJwjRql2g7Wns8qgQfF1b5i8sI3Kn
	v6SXwtCMaSKJYHzMwoUZcF5M2iAxekZ7H/Bn0/Fk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AAD119A3E;
	Sun, 15 May 2016 18:57:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A489D19A3D;
	Sun, 15 May 2016 18:57:50 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7318CB88-1AF0-11E6-93DE-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294692>


Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index a7f2c3f..95416d3 100644
--- a/attr.c
+++ b/attr.c
@@ -469,7 +469,7 @@ static void debug_set(const char *what, const char *match, struct git_attr *attr
 #define debug_push(a) do { ; } while (0)
 #define debug_pop(a) do { ; } while (0)
 #define debug_set(a,b,c,d) do { ; } while (0)
-#endif
+#endif /* DEBUG_ATTR */
 
 static void drop_attr_stack(void)
 {
-- 
2.8.2-748-gfb85f76
