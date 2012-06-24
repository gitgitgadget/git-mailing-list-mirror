From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/9] sha1_name.c: indentation fix
Date: Sat, 23 Jun 2012 17:11:23 -0700
Message-ID: <1340496691-12258-2-git-send-email-gitster@pobox.com>
References: <1340496691-12258-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 02:12:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiaRC-0001US-OF
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 02:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630Ab2FXALs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 20:11:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432Ab2FXALg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 20:11:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E41F08F1A
	for <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Yr97
	/UC3Gj4hc1ru+kpPHmaXrL8=; b=GZaahe3q3BfVVKaR0/QHogox4A+P8muYqncl
	x1g8cE5oUX+Ne0I909nxWw3vS4H+N5yBJFHXfLPe5wCNEk57oDxPK1r8izj+ANgg
	7veXavmJccb5MsgOfVe+Fdx+uI1cBmJweTMkfFEJNsPrS8a6ljMSvA9hNPfpK0Bd
	Y28x0ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=d2JgFy
	iPLS379zXtNHMhkfQHti3LZluMCcM2c4NCLhayvEZKbHDn/lJ+Qkjnrj96T2O6I0
	RGh6Beo9FgG6f+eLv13PrgTsb0An6jlMECivtsuQqdTWTmTXA+L2zNUVxtyOcOuK
	HQCAhbPeyqPeWffCMG/WcAwFDETa178PBCNJU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC1D38F19
	for <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 751968F18 for
 <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.29.gf71be5c
In-Reply-To: <1340496691-12258-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2913F21C-BD91-11E1-BEC2-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200507>

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
1.7.11.1.29.gf71be5c
