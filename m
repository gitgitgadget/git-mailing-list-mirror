From: Junio C Hamano <gitster@pobox.com>
Subject: [PREVIEW v3 1/9] strbuf: miniscule style fix
Date: Wed, 13 Jan 2016 19:03:01 -0800
Message-ID: <1452740590-16827-2-git-send-email-gitster@pobox.com>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 04:03:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJYC4-0007Uv-86
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 04:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbcANDDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 22:03:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752248AbcANDDO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 22:03:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ECAB83C422;
	Wed, 13 Jan 2016 22:03:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=GQ2z
	GMA5dc3UdiWytKMdYO6Dmmk=; b=WjFGVZJvf3kehqxCrM8S9y6ZxZQ8MWGfDAKf
	HwYsHfFRHdBWMXp50p9Dku0wbGl9YPdpMU/PZ8mvyH3p+RfD0GAipjwBFLFgWsoB
	r3z/1sw37NU2K1JZj88xaRMbA5YM5VsJoNUcHtoISw5p505HeSgTxZZATSqBuQdq
	/wSr3SU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	owU1LxuVcPiPoKCwOFj3Dpjs0SLtRZ1XMoujHhHM0ZMKg/y0koTja1IhMte3FM0+
	GcljAPBk6WeSXCJMOPdDXBXkUJxFwlorpyFJIw9DurL+bfBwcfjAgideB+Xl6air
	Gn++1oDzCQLCDGqXZknnILmV6qY7EdjiHUz/k8KeXDY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E57333C421;
	Wed, 13 Jan 2016 22:03:13 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6C4B83C420;
	Wed, 13 Jan 2016 22:03:13 -0500 (EST)
X-Mailer: git-send-email 2.7.0-242-gdd583c7
In-Reply-To: <1452740590-16827-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 59BE6B06-BA6B-11E5-9CDE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284003>

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
2.7.0-242-gdd583c7
