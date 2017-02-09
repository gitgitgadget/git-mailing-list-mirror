Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52FA71FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 17:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754297AbdBIR2a (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 12:28:30 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36825 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753573AbdBIR23 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 12:28:29 -0500
Received: by mail-pg0-f67.google.com with SMTP id 75so803508pgf.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 09:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HPcitl8h24rAd3NPj0bwPdo7zxZCK11ubMpxIjYayEM=;
        b=MfC8A0kHSu6gg3h22rYx7jI+7CIq5o7+/oFe+WLdBy+kQWPC8fZ/7sH5rZEFHu3WF2
         FEfoT2HqDHjLkV7Sdq715XRRyNN/uX2Q2u3E7cisntCij+K9FrUIsCd/oqcwLeoGpUq2
         qUHTNqboh5MUb1t1ufvLwp1CUY89BMYBRwL8ZrO6kmGarI5KzjMcVAl5LBDl+8xdpLty
         +pO1gorLFRSIfhxNQPOOu8NKMm/lDjqsn+yGoGVvWT+UdIt+LrRNSnXJNTfoZfUhVMXX
         D8r4ZvnLaoDBeYUh4ihBnUXmq3RyYqGwZgm/N6o8uYY/5PM/j8gou3sgngh6RA9zOiGN
         D8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HPcitl8h24rAd3NPj0bwPdo7zxZCK11ubMpxIjYayEM=;
        b=IcF7tJlodwJqIwpdJOxhJAiv2/N8zP2vBke5rA1IfVL0F7vOw+qpEWrmPB4UlWjijj
         rRyRJFWmD1qeP6EModVruJ+uwdBzotlJWlLdevnrHl3V6XZAbCAR8+KZ0GeF4EzUx646
         +7aZuowXoqSqMRoyceIsBecmpvs+2sGn2O9PXMO1RkScY0BKspjbxwBuUFbBmd8fl171
         mfs776sjELamMB95iebOZ1rYmql4bPQMjpQtVpbeRzTii+BRFipxgWdLVjWR+KH2ReBT
         o/y7Yll0V0MD9oLVxtZkGTcVmIaTTDId4zpljxjTAkZmEFCuelODE6FRuh8iYtqDyPwe
         hSvg==
X-Gm-Message-State: AMke39klRjYrwcJOIgI040U1C2gZ5rKAHcfl5aDAr9woB1a6piTSuVClMpNV6IWqUhXIMQ==
X-Received: by 10.84.217.65 with SMTP id e1mr3470371plj.40.1486660827237;
        Thu, 09 Feb 2017 09:20:27 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id l22sm30490634pgc.43.2017.02.09.09.20.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 09:20:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702091319350.3496@virtualbox>
Date:   Thu, 09 Feb 2017 09:20:25 -0800
In-Reply-To: <alpine.DEB.2.20.1702091319350.3496@virtualbox> (Johannes
        Schindelin's message of "Thu, 9 Feb 2017 13:29:33 +0100 (CET)")
Message-ID: <xmqqfujns2li.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> (And that would have to be handled at a different point, as I
> had pointed out, so that suggested preparation would most likely not help
> at all.)

I did not think "that would have to be handled at a different point"
is correct at all, if by "a point" you meant "a location in the
code" [*1*].  If we want to make it configurable in a more detailed
way by directly allowing to override port_option and needs_batch
separately, you would do that in override_ssh_variant(), without
touching handle_ssh_variant() in the refactored code.  That way, you
do not have to worry about breaking the auto detection based on the
command name.


[Footnote]

*1* Or did you mean "point in time", aka "let's do it outside the
    scope of this patch series"?

Let's not keep it as a SQUASH??? proposal, but as a separate hot-fix
follow-up patch.

-- >8 --
Subject: connect.c: stop conflating ssh command names and overrides

dd33e07766 ("connect: Add the envvar GIT_SSH_VARIANT and ssh.variant
config", 2017-02-01) attempted to add support for configuration and
environment variable to override the different handling of
port_option and needs_batch settings suitable for variants of the
ssh implementation that was autodetected by looking at the ssh
command name.  Because it piggybacked on the code that turns command
name to specific override (e.g. "plink.exe" and "plink" means
port_option needs to be set to 'P' instead of the default 'p'), yet
it defined a separate namespace for these overrides (e.g. "putty"
can be usable to signal that port_option needs to be 'P'), however,
it made the auto-detection based on the command name less robust
(e.g. the code now accepts "putty" as a SSH command name and applies
the same override).

Separate the code that interprets the override that was read from
the configuration & environment from the original code that handles
the command names, as they are in separate namespaces, to fix this
confusion.

This incidentally also makes it easier for future enhancement of the
override syntax (e.g. "port_option=p,needs_batch=1" may want to be
accepted as a more explicit syntax) without affecting the code for
auto-detection based on the command name.

While at it, update the return type of the handle_ssh_variant()
helper function to void; the caller does not use it, and the
function does not return any meaningful value.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 connect.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/connect.c b/connect.c
index 7f1f802396..7d65c1c736 100644
--- a/connect.c
+++ b/connect.c
@@ -691,17 +691,39 @@ static const char *get_ssh_command(void)
 	return NULL;
 }
 
-static int handle_ssh_variant(const char *ssh_command, int is_cmdline,
-			      int *port_option, int *needs_batch)
+static int override_ssh_variant(int *port_option, int *needs_batch)
 {
-	const char *variant = getenv("GIT_SSH_VARIANT");
+	char *variant;
+
+	variant = xstrdup_or_null(getenv("GIT_SSH_VARIANT"));
+	if (!variant &&
+	    git_config_get_string("ssh.variant", &variant))
+		return 0;
+
+	if (!strcmp(variant, "plink") || !strcmp(variant, "putty")) {
+		*port_option = 'P';
+		*needs_batch = 0;
+	} else if (!strcmp(variant, "tortoiseplink")) {
+		*port_option = 'P';
+		*needs_batch = 1;
+	} else {
+		*port_option = 'p';
+		*needs_batch = 0;
+	}
+	free(variant);
+	return 1;
+}
+
+static void handle_ssh_variant(const char *ssh_command, int is_cmdline,
+			       int *port_option, int *needs_batch)
+{
+	const char *variant;
 	char *p = NULL;
 
-	if (variant)
-		; /* okay, fall through */
-	else if (!git_config_get_string("ssh.variant", &p))
-		variant = p;
-	else if (!is_cmdline) {
+	if (override_ssh_variant(port_option, needs_batch))
+		return;
+
+	if (!is_cmdline) {
 		p = xstrdup(ssh_command);
 		variant = basename(p);
 	} else {
@@ -717,12 +739,11 @@ static int handle_ssh_variant(const char *ssh_command, int is_cmdline,
 			 */
 			free(ssh_argv);
 		} else
-			return 0;
+			return;
 	}
 
 	if (!strcasecmp(variant, "plink") ||
-	    !strcasecmp(variant, "plink.exe") ||
-	    !strcasecmp(variant, "putty"))
+	    !strcasecmp(variant, "plink.exe"))
 		*port_option = 'P';
 	else if (!strcasecmp(variant, "tortoiseplink") ||
 		 !strcasecmp(variant, "tortoiseplink.exe")) {
@@ -730,8 +751,6 @@ static int handle_ssh_variant(const char *ssh_command, int is_cmdline,
 		*needs_batch = 1;
 	}
 	free(p);
-
-	return 1;
 }
 
 /*
-- 
2.12.0-rc0-221-g3e954cf1aa

