From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/20] sha1-name: trivial style cleanup
Date: Sat, 12 Oct 2013 02:07:15 -0500
Message-ID: <1381561636-20717-20-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:14:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtP0-00066M-7I
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865Ab3JLHOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:14:14 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:36437 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852Ab3JLHOG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:14:06 -0400
Received: by mail-oa0-f48.google.com with SMTP id m6so3079948oag.7
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3s59LtiVwqaazSBYCK7HNU48eNkWgfzNsLw58s5c0uA=;
        b=f095j/2OVNTZGNQ4WMQfSn9c1O81vDXNyahnA+djmJ//AIQgIM30cqG8g8zxiLlgia
         7nLdZbPurctc8WwpB03wcFETzdiqD9NJUQwDJku/1cyH0iIjF20zYz0wosrto3PRCjYP
         eMhvJP6tmL+8ImPJN7WnBFTxa76O7lIi3TNcfwTM+3gZRugaWiZRjA0myzgVLF3qj2Ij
         cN/cEYeJJzt0LtTP/vvPjlCeXDwyRLbjlfTm7S57M063EiSaOrikw0f4uitlxtE11sI7
         S9qxEk9ppEag4uh76RcmGk8yQj86dD/G3K+pJeMChTwaNL3PHBf4KV8eIu99kJUjg7iI
         x+/w==
X-Received: by 10.60.118.41 with SMTP id kj9mr17720905oeb.31.1381562045963;
        Sat, 12 Oct 2013 00:14:05 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm101391791oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:14:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236028>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 0e5fe7f..e9c2999 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -343,7 +343,6 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	return status;
 }
 
-
 int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 {
 	char hex_pfx[40];
-- 
1.8.4-fc
