Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F1AF1FC00
	for <e@80x24.org>; Wed, 18 Oct 2017 20:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbdJRU1Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 16:27:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:49962 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdJRU1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 16:27:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id b189so12011136wmd.4
        for <git@vger.kernel.org>; Wed, 18 Oct 2017 13:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qiuNo2e3M3fWqMGGrVcU8BylJt3b+PUb0PI9b2kYvVM=;
        b=vPaBaw5lH1TeHVJA2FSnUhTCWq0WPGeJdYRgJDHwT2G12pikGftynHoSGiavhxlYyM
         fnwkPTvtlNXX+xFuSSF26qkiB0Vw2lWd/Oj3JSLDnzmAHUBBDKhEKiAFUzvaXPyx3Ylh
         NEC6HfVQ9d43JUkVkiymGFkl2RELPCrMx8DzcIed5h8F1z9PKnqwBNCPySzT5SgCFmbV
         l+BTICC5HNacFDKFTVXeStvV7EHsS1HQtR5sCbl3n1D8LGOhSgJhsop8QvyL6ABtvg3v
         AJwrjQFwrnG7F+1nYxUgOjtaWO8VlgJZC1AGOP+Tw1MNgbWpP4iMdztqX17+14S0/UW2
         jf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qiuNo2e3M3fWqMGGrVcU8BylJt3b+PUb0PI9b2kYvVM=;
        b=lo6W8CWpdUPWBLaA05uEXlIaVallAtIUfz0yHQdKBDmDHdRaZDc1a6px6WFvGvmMNP
         zDVvJYKgVl5YYNKhrN7KXNsVv/n/RCItpmgrG+psfdDU6rjbChaIQ4f6L4tXoK9Ny3Py
         3axrfEClRn5lEk1LRcRx0l+R5N7G2ZvAfCm4k7qg+IVunldRnz//cortENoA/FqqtSob
         A/0SzUwoQ8udqoSBAGWtWkA034EJhAdbN2+77VxxczuAoLTDWHmuFWTCL+iZBtXuG3Bn
         J29C6y5URJTfYuIxeQFIDFY+kRTAg5slpaD69urIP2pyVbCQ4uNANTY/wVAF4776Xr4o
         mq4g==
X-Gm-Message-State: AMCzsaX+yTfxpmmLRgl/z/nyqsTtxzzuqWge52sL9lgbvhgLcd1oGl+/
        sFgLaJfiScbf4fsXAYhcGLSRq9N0
X-Google-Smtp-Source: ABhQp+T3hBiIv7fms9oCOOSZ3wAR3/+jMit2RzYnkVg9Lh0v33T5bVM8ZKFcMt2CKVTU5FENMv3gkQ==
X-Received: by 10.28.51.19 with SMTP id z19mr6818103wmz.18.1508358443541;
        Wed, 18 Oct 2017 13:27:23 -0700 (PDT)
Received: from localhost.localdomain (158.82.136.77.rev.sfr.net. [77.136.82.158])
        by smtp.gmail.com with ESMTPSA id 63sm282381wrb.9.2017.10.18.13.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Oct 2017 13:27:22 -0700 (PDT)
From:   PAYRE NATHAN p1508475 <second.payre@gmail.com>
X-Google-Original-From: PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
To:     git@vger.kernel.org
Cc:     PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>,
        MOY Matthieu <matthieu.moy@univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
Subject: [PATCH v3] Documentation/git-config.txt: reword missleading sentence
Date:   Wed, 18 Oct 2017 22:27:16 +0200
Message-Id: <20171018202716.13313-1-nathan.payre@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.14.GIT
In-Reply-To: <xmqqvajjuudo.fsf@gitster.mtv.corp.google.com>
References: <xmqqvajjuudo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the word "bla" to "section.variable", "bla" is a placeholder
for a variable name and it wasn't clear for everyone.  This change
clarify it.

Change the appearance of 'git config section.variable {tilde}/' to
`git config section.variable ~/` to harmonize it with the rest of the
file, this is a command line then the "`" are necessary.

Replace "git-config" by "git config" because the command is not
"git-config".

See discussion at:
https://public-inbox.org/git/20171002061303.Horde.SL92grZCqTRV9oQkBFPELQ7@crashcourse.ca/

Signed-off-by: MOY Matthieu <matthieu.moy@univ-lyon1.fr>
Signed-off-by: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Signed-off-by: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
Signed-off-by: Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Noticed-by: rpjday@crashcourse.ca
---

Change since v2: use ~ within backquote instead of {tilde}.
Backquoting of 'git config', '~', '$HOME' and '~user' for more
coherence.

Documentation/git-config.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 83f86b923..9b5c3a436 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -174,11 +174,11 @@ See also <<FILES>>.
 	either --bool or --int, as described above.
 
 --path::
-	'git-config' will expand leading '{tilde}' to the value of
-	'$HOME', and '{tilde}user' to the home directory for the
+	`git config` will expand leading `~` to the value of
+	`$HOME`, and `~user` to the home directory for the
 	specified user.  This option has no effect when setting the
-	value (but you can use 'git config bla {tilde}/' from the
-	command line to let your shell do the expansion).
+	value (but you can use `git config section.variable ~/`
+	from the command line to let your shell do the expansion).
 
 -z::
 --null::
-- 
2.14.2

