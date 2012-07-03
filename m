From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 01/25] sha1_name.c: indentation fix
Date: Tue,  3 Jul 2012 14:36:51 -0700
Message-ID: <1341351435-31011-2-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:38:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAnP-0004qt-Hv
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512Ab2GCVhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:37:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726Ab2GCVhT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00C66861C
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=KIA8
	f5J0qJGnHZ5gwLJSX6oyIzA=; b=SzKahD+hZ9kdjCxbeRmtbAnl8X+8GWbylHip
	XnP8Y8bSVoF5cupv2GP9ytRjPiFgb3RxBkx4FYiX7EknfSfYx7HCAZYdcqRf7r40
	LlXBvErRTBFy13cwoNHH+hyiAZEA14VDTbLT/BwKuN/RPphlTaiZolhJiGYWcvfz
	CakE/cI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=YvXzmm
	j7hV5GOxU6dvWTVTayk+Pjvj3BPC8+r4g56+gKKjFNV2uK48V/rxnNNHHjxKpxZd
	CrFvR4TjbSDqd6jU0i4BknmvR7ef3zARan5EAiAO3sxoE7scHHwfcoDit0oRerTO
	9QD/OnrWiMfIr9C1W07r3AeMjXzr4Dc73n66E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC45D861B
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F0C98619 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:18 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 43A170D2-C557-11E1-8589-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200948>

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
1.7.11.1.229.g706c98f
