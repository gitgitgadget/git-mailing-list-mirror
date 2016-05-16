From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/12] attr.c: mark where #if DEBUG ends more clearly
Date: Mon, 16 May 2016 14:05:39 -0700
Message-ID: <20160516210545.6591-7-gitster@pobox.com>
References: <20160516210545.6591-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 23:06:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2PiM-0001Fc-4j
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbcEPVGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:06:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751184AbcEPVGD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:06:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A00091C745;
	Mon, 16 May 2016 17:06:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RCCo
	+05WIDr5VY1YZ0UHx+u5Zyo=; b=L11NBsuyKKFKo7UGz2EQ5QOUzih9AcTtoCat
	/+qtLixTg8i8hWJF0Y3sXnjAyYjk/beBONTMtPjLz43M/d7o7jjx2KsndN6lqLpM
	atqbUhXcsqEzTVMoE1/t4OsFHg5JuxhdD93PctmlGZeEB5XbBYnkIMztiuNPf+Vp
	U6Nd6NY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=r+TOS8
	19Hr2Jn5wJBCR9Fq5s9iouHvfNEbj/WrJYUWnktVeZMe5nLzESVW4Gz0vSlkntx7
	7JD6kVR1l07eTwT+RK8Ni1wCR/Mx7ynRLK7NSxhHdk3bF4x0x1Hb4/GIO0aCD0Li
	qWNrjcz0VbakHAWY7pBcZvtivSieI3sq6QDqw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 873EA1C744;
	Mon, 16 May 2016 17:06:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D2C31C742;
	Mon, 16 May 2016 17:06:01 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-755-g8847aff
In-Reply-To: <20160516210545.6591-1-gitster@pobox.com>
X-Pobox-Relay-ID: FE941B72-1BA9-11E6-98A0-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294789>

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
