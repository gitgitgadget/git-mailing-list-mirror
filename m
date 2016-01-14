From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 01/21] strbuf: miniscule style fix
Date: Thu, 14 Jan 2016 15:58:16 -0800
Message-ID: <1452815916-6447-2-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:58:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrmw-00037H-8M
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570AbcANX6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:58:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755475AbcANX6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:58:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AEC153CD59;
	Thu, 14 Jan 2016 18:58:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+gUa
	EbPuYCE8JI7XupLPpIASwgE=; b=WqNxuy6bKxfmRSctXPyhIKUHjGY+PeSXmEEX
	A2hoR0MYx+Wq+IU7zLC+WQFNypBP4qS9LISOCGrmg2zRuurcSqGQG27orf2NxaXC
	c8gTupJFTYVjrrC3zJ5+IkvnAfcIjGTdMAnkqZxbtWKvgQs8JAAc5zl40MPtdEwh
	BDJZp5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	bvWfGuI411Taw5KXv2fS6zZIvXgwvsg741tAJ6PBCP2gVIdktRO0WLldWrzarA08
	/g7RTFKymv8niLY5zWlZXlblCdC4AnaAOjT9rGmKc5b8+vlYxuiDpgmQ8OnpU1SN
	x7Hb3Wy13u3nqbEGtkKcwAQNloL0vMf8f2T2qTC21jk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A6F683CD58;
	Thu, 14 Jan 2016 18:58:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 27A4C3CD57;
	Thu, 14 Jan 2016 18:58:39 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BB5EB4B0-BB1A-11E5-BF72-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284103>

We write one SP on each side of an operator, even inside an [] pair
that computes the array index.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 strbuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index d76f0ae..b165d04 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -505,8 +505,8 @@ int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
 {
 	if (strbuf_getwholeline(sb, fp, term))
 		return EOF;
-	if (sb->buf[sb->len-1] == term)
-		strbuf_setlen(sb, sb->len-1);
+	if (sb->buf[sb->len - 1] == term)
+		strbuf_setlen(sb, sb->len - 1);
 	return 0;
 }
 
-- 
2.7.0-250-ge1b5ba3
