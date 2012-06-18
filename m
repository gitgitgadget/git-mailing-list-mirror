From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/9] sha1_name.c: indentation fix
Date: Mon, 18 Jun 2012 15:05:30 -0700
Message-ID: <1340057139-8311-2-git-send-email-gitster@pobox.com>
References: <1340057139-8311-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 00:05:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgk4y-00088o-WD
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 00:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251Ab2FRWFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 18:05:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57311 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533Ab2FRWFn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 18:05:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE5E397DB
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=IWeE
	6PuIfrVOShvQjHGi6xmcFJY=; b=iJoiTetfLRF3R/tVSiSbP3maSALCr0hvhHU1
	mV3nycbGAJhSr2MXQzmYqIY0Uk2Zqw+DgXNupoleUGGjxfBI1FpUSM6CB35QalMu
	DnILh3zWe5+Plw9i4TkSDt71dHKvXQBKOvoijbEaQZ4zh+r9mTR/SmMFsfPHBYjn
	NMs8wos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xQ2QOb
	QRGXVkh2drQK3EZTjNDUmJ9xX6qj+DOqJUgRV5tkPT5y2ZmHUfC9Ui5yjEhSGf8C
	xotwa5qNR9sknXcc+2Q4AVERKnHhnabBBE3VDOlM5LNfRM8W2+/O3Gjghoi5lBXw
	t//3aKzzi9vpw5JUrf8Qc9s3hDjvIWmaKX5lU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6DFF97DA
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6157597D9 for
 <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.11
In-Reply-To: <1340057139-8311-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BF0663A8-B991-11E1-9A45-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200166>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 03ffc2c..5b0c845 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -103,10 +103,10 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
 		}
 		if (first < num) {
 			const unsigned char *now, *next;
-		       now = nth_packed_object_sha1(p, first);
+			now = nth_packed_object_sha1(p, first);
 			if (match_sha(len, match, now)) {
 				next = nth_packed_object_sha1(p, first+1);
-			       if (!next|| !match_sha(len, match, next)) {
+				if (!next|| !match_sha(len, match, next)) {
 					/* unique within this pack */
 					if (!found) {
 						found_sha1 = now;
-- 
1.7.11
