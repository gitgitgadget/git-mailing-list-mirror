From: Mostyn Bramley-Moore <mostynb@opera.com>
Subject: [PATCH/RFC 1/2] describe: mention glob in the --matches help text
Date: Sun, 27 Dec 2015 23:59:51 +0100
Message-ID: <1451257192-5755-2-git-send-email-mostynb@opera.com>
References: <1451257192-5755-1-git-send-email-mostynb@opera.com>
Cc: Mostyn Bramley-Moore <mostynb@opera.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 00:00:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDKIe-00017m-3M
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 00:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675AbbL0XAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2015 18:00:23 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35693 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754648AbbL0XAS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2015 18:00:18 -0500
Received: by mail-wm0-f47.google.com with SMTP id l126so248771090wml.0
        for <git@vger.kernel.org>; Sun, 27 Dec 2015 15:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L1NQGj4P/rS6wq8+frlwfTyheGBQIeltZKceK+lNxQE=;
        b=IysG0loUHT/r2NRQYX9bV0x1g18WISvVcRwgXg1frmzuGohYb6qJA3Dk08TKyTrIu+
         CaFGvjjsIVwYvlLrj/oiv2OvSJo2C/e7gN+iWfOeWuhfGTaW3Khjn6FXHSQzH/iymTdA
         JBaBB7Y5ZgI8YLQubyprQ/bBwkpJebKKAmSX+piy8OOBntjvfeTD6SXLnI9ZYYnOHSDL
         Ld0/+kch536gV74cq02+xtUM7KHT6BeISGgTkdfe3oRFgJFLMHm0ulY7a5MQgQXon1zd
         PZt7C0WJ5uX7t/CV33zreauaANYBgIyiGbvzxJo2daCl/BVD7HHZ9Rp47pxAaYeuXvD7
         TZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L1NQGj4P/rS6wq8+frlwfTyheGBQIeltZKceK+lNxQE=;
        b=Bs0t9Rj0BfyLhhorSQ1K/JEEzTAPSbIO9zhIwXCSdQa+MHQgCwwqPHNHgYGHx2MJ4n
         44iaKCKarUvtK1TpenGTdu2xFhxsgPXgUAHC34/8eFglLkICZvOcBh9gCeYrgnlHsioy
         DN28qkT6ybSVKJ2wt9wzN47MTkQ6k5Dn5AS18iQuKG7jyFQeJWbFuMR6eskaUvyH8hP9
         Ipb4e5EODw2c1vlZXLZehuwi/RGxI/0Yy3NzsK4VE6JU1b5HYzLiqnknMx0Ew1+he53O
         s+/AV0VMJQxMmgpfv8mwbhbJPto92Kr99kIJMltWieZ8HgQZLMqxRRRqmI15qpNnNxpK
         g99g==
X-Gm-Message-State: ALoCoQkqNgkLpV7uVH+5PG/NLbFqph02PI5+4+BXjLXiN3pY4m0GyL1UwZjmzaG1njGJSh86dBnBSWY8NIcPgMc7XZ48MPsYnQ==
X-Received: by 10.194.173.102 with SMTP id bj6mr54169434wjc.180.1451257216846;
        Sun, 27 Dec 2015 15:00:16 -0800 (PST)
Received: from teardrop.skrumpis (h151n12-g-kt-d2.ias.bredband.telia.com. [213.64.207.151])
        by smtp.gmail.com with ESMTPSA id w17sm12929872wmw.15.2015.12.27.15.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 27 Dec 2015 15:00:15 -0800 (PST)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1451257192-5755-1-git-send-email-mostynb@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283020>

This saves the user from needing to consult to manpage to learn the
format of the --matches argument.

Signed-off-by: Mostyn Bramley-Moore <mostynb@opera.com>
---
 builtin/describe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 8a25abe..2386c64 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -404,8 +404,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			    N_("only output exact matches"), 0),
 		OPT_INTEGER(0, "candidates", &max_candidates,
 			    N_("consider <n> most recent tags (default: 10)")),
-		OPT_STRING(0, "match",       &pattern, N_("pattern"),
-			   N_("only consider tags matching <pattern>")),
+		OPT_STRING(0, "match",       &pattern, N_("glob"),
+			   N_("only consider tags matching <glob>")),
 		OPT_BOOL(0, "always",        &always,
 			N_("show abbreviated commit object as fallback")),
 		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
-- 
2.5.0
