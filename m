From: Slavomir Vlcek <svlc@inventati.org>
Subject: [PATCH] apply: fix typo in an error message
Date: Mon, 17 Nov 2014 01:38:26 +0100
Message-ID: <54694382.7020203@inventati.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 01:35:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqAI2-0006F2-6k
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 01:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbaKQAfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 19:35:22 -0500
Received: from latitanza.investici.org ([82.94.249.234]:27828 "EHLO
	latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbaKQAfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2014 19:35:21 -0500
Received: from [82.94.249.234] (latitanza [82.94.249.234]) (Authenticated sender: svlc@inventati.org) by localhost (Postfix) with ESMTPSA id 32BD4121F20;
	Mon, 17 Nov 2014 00:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inventati.org;
	s=stigmate; t=1416184519;
	bh=PH91hmYt5wO+gQ8tXc9hb74M6m/GkaQ460U/g+C6/7s=;
	h=Date:From:To:CC:Subject;
	b=NvGsGpvqBrPysELyjtcazX/GrqIy8Amld+ZyrhhVpqSgjacVaJEu2cQ5SDyiNq2hu
	 65Y8ZHxUR9UcFlabzKSNuCbxNsLJev6ej9PvFw1qF0UWW9HQsedDZxxoDzOgdG7PiT
	 DWZXHPMMXmQiBtvfEcsH3TvlH4PFm92q0WFp5Ba0=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

s/submoule/submodule

Signed-off-by: Slavomir Vlcek <svlc@inventati.org>
---

For the 'master'. Thank you.

 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6696ea4..28d24f8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3728,7 +3728,7 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 			if (!preimage_sha1_in_gitlink_patch(patch, sha1))
 				; /* ok, the textual part looks sane */
 			else
-				die("sha1 information is lacking or useless for submoule %s",
+				die("sha1 information is lacking or useless for submodule %s",
 				    name);
 		} else if (!get_sha1_blob(patch->old_sha1_prefix, sha1)) {
 			; /* ok */
-- 
2.2.0.rc1.dirty
