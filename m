From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/5] khash.h: Spell the null pointer as NULL
Date: Thu, 07 Nov 2013 22:09:43 +0000
Message-ID: <527C0FA7.3000306@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 07 23:15:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeXrP-0000TZ-W4
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 23:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826Ab3KGWP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 17:15:27 -0500
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:47406 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755626Ab3KGWPL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 17:15:11 -0500
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 8C486401465;
	Thu,  7 Nov 2013 22:15:09 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 88EED40148C;
	Thu,  7 Nov 2013 22:15:08 +0000 (GMT)
Received: from [192.168.254.4] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Thu,  7 Nov 2013 22:15:07 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237438>


Noticed by sparse. ("Using plain integer as NULL pointer")

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 khash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/khash.h b/khash.h
index 0fdf39d..c4c1613 100644
--- a/khash.h
+++ b/khash.h
@@ -114,7 +114,7 @@ static const double __ac_HASH_UPPER = 0.77;
 	}																	\
 	SCOPE int kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets) \
 	{ /* This function uses 0.25*n_buckets bytes of working space instead of [sizeof(key_t+val_t)+.25]*n_buckets. */ \
-		khint32_t *new_flags = 0;										\
+		khint32_t *new_flags = NULL;										\
 		khint_t j = 1;													\
 		{																\
 			kroundup32(new_n_buckets); 									\
-- 
1.8.4
