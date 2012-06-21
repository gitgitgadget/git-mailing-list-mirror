From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/9] sha1_name.c: indentation fix
Date: Wed, 20 Jun 2012 23:35:24 -0700
Message-ID: <1340260532-11378-2-git-send-email-gitster@pobox.com>
References: <1340260532-11378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 08:35:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShazV-0006FX-F9
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 08:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab2FUGfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 02:35:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43836 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753225Ab2FUGfg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 02:35:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E23E28B12
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=jJOY
	bSY3IuaU0pWn7je4mE+w8So=; b=PwzdZapvga8Ix2qDg6Hf2uY+9xBp4HJdAyRQ
	Rmy8ljE8XuGslnTBSPmfLWdk1dRu3yZW2u7GD+rOND+NTkLBC+rjqiQuIKGOjz5o
	J1fMO+/sCcAF54+9aumTX6EtccxaGqmqVJLZR2Tr3bNssUq298rFFVoFiMmb+frm
	AFNxNuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=YfYidb
	NdDItNw8LA2D/PY4U5d6lnSP6x2cOQy09wizdeoyNHvseYwn52v5+S0AYRhV6ZB6
	6WJO6Nuw/uCw6wJHY1EWGi4XzVTPEi9LI6y6+e1gZjey5f2FtT5+AhgsXRq9XBWZ
	EkzHS5mbo3NT/4tYpGstrdIByPnpiZnanrTfc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD1478B11
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 600FE8B0F for
 <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.2.gd284367
In-Reply-To: <1340260532-11378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4EB24AFA-BB6B-11E1-ADFE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200386>

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
1.7.11.2.gd284367
