From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 01/18] sha1_name.c: indentation fix
Date: Mon,  2 Jul 2012 15:33:52 -0700
Message-ID: <1341268449-27801-2-git-send-email-gitster@pobox.com>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 00:34:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlpCm-000320-CP
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 00:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215Ab2GBWeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 18:34:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756046Ab2GBWeN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 18:34:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D0769064
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=j3jh
	XPCLXdBoHR7on35shSgLx3c=; b=tXneCTdc8R1VaKfy2eTb0r35jvhQO6qu+s6e
	suk65MfEhDnnyMte1v8kaX5X54rKRJUYkm6ArwXEp9ouM/CVETvyNyKowFZR7lL4
	bLeylSDeImhJd1oBlufbSmSM4qzoFNGeWGoPBt6OwSLSEpkDfsUJUwh9QNhbpLN8
	mmekqr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=exBeKA
	zEo3yJf/ClHYBJDkU8Kt7aH8J/YZ0z6aZ38R7+5YzD6dL0w1TCrD+J+O5387rsNE
	yAfBrwRN45uhu1tk+t/pFLOQ25PkFcwJMVNNAQbZSjzpqga9rpS87pnP4CUvL38a
	VjtyXxiVaZWJ0BUpHyT68bfwgOJBTRS4a8FvI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 332069063
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B31999061 for
 <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:12 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.212.g52fe12e
In-Reply-To: <1341268449-27801-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0C3F35D2-C496-11E1-9EDD-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200868>

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
1.7.11.1.212.g52fe12e
