Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D005E1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 22:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeI2EbJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 00:31:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35727 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeI2EbI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 00:31:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id o16so7851495wrx.2
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 15:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=082+8VUm3MlP1X6PWUGI211PwC6JLPbIL65qw7xjQaQ=;
        b=YTOxWW+KNpD/JTMCJ9hEuNpRlavmGMbmJi/CHBXrRINLfBouKi60MJxtFae1vWPtBO
         R5pniIf7DppdQM1OxVjygKYJguoDogooCvIgWWOmia1ey7XdSz7InDNvOAupfGXZyFg+
         1uC+rXSuIKn4KAErJkpIvyay/1O3Z3ylRl+GEmf+7j9bAL1Ixn9K6Be+pERtjGu+88zw
         em8L90AOPWKJxA2ggWVsW3KODgW6LvXisLBuqYdOzXo87xC9TEwz5EJm0uRTfuQCV2R3
         OAgtf6qWx4bfaIcRhk5SrCjJLXO/NiVYbbsyTh1Yq+RvgHyPCDQWbveJ0gPi5I5KB7XP
         wimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=082+8VUm3MlP1X6PWUGI211PwC6JLPbIL65qw7xjQaQ=;
        b=prftRkcIOCT8nvZEnnLMtJTZd0r/SEYTR0MCX96m435O7Gk1rYUJfMLJF3m59rT2iI
         xOdxc4ZlsE5zEvgCzkm3g7OB+jhlUmdnNqtN+fL79DbwlMq7wgOM5qwjdDPxiXzOaWQG
         cRSeGZNcZStmTY29c55wq5v3eOuBHAKEmXbiWen6uy/MhWZFwTQuJa8LopjAGUEWNfaj
         4uWjEo0P6TMULDK0sethSGMpynn1gcuPvvZF3zzBjn5dQJLNN8aT7oT71AEIQL28PbkK
         lxBblGazqwHMsOVciiYDaZ8F1JdfB85p4JGvPx5Rngym3MIgxmhlwz9Zp+Y5yT5KiIVh
         qi5A==
X-Gm-Message-State: ABuFfojhu3xlZRKA8XTx8O4aPf9+SCt8CARwqfteKbegOSFh9xL4Mh5b
        ZumteDo5wTvaOBXpLlDT1xI=
X-Google-Smtp-Source: ACcGV63MMpQjYeo2ASQq+wCXZs3ttHT/RYR4GJVnXtVgH19tB3vaGTGhshYIyGffpZjtO+Ka0Lh9Qg==
X-Received: by 2002:adf:a352:: with SMTP id d18-v6mr327133wrb.31.1538172321350;
        Fri, 28 Sep 2018 15:05:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k13-v6sm5483023wrq.7.2018.09.28.15.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 15:05:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-rebase.sh: fix typos in error messages
References: <20180928192849.30792-1-ralf.thielow@gmail.com>
        <xmqqzhw19t9a.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 28 Sep 2018 15:05:20 -0700
In-Reply-To: <xmqqzhw19t9a.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 28 Sep 2018 15:01:05 -0700")
Message-ID: <xmqqsh1t9t27.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  However, because the same mistakes are inherited to
> builtin/rebase.c by these topics, we'd need a matching fix to
> correct 07664161 ("builtin rebase: error out on incompatible
> option/mode combinations", 2018-08-08) and either squash the fix
> into that commit, or queue it on top of pk/rebase-in-c-5-test topic.
>
> Will queue; thanks.

Here is what I'd queue, too.

-- >8 --
Subject: [PATCH] rebase: fix typos in error messages

The separator between words in a multi-word option name is a dash,
not an underscore.

Inspired by a matching change by Ralf Thielow for the scripted
version of "git rebase".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rebase.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1a697d70c9..0f9a40aae5 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1135,15 +1135,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		 *       git-rebase.txt caveats with "unless you know what you are doing"
 		 */
 		if (options.rebase_merges)
-			die(_("error: cannot combine '--preserve_merges' with "
+			die(_("error: cannot combine '--preserve-merges' with "
 			      "'--rebase-merges'"));
 
 	if (options.rebase_merges) {
 		if (strategy_options.nr)
-			die(_("error: cannot combine '--rebase_merges' with "
+			die(_("error: cannot combine '--rebase-merges' with "
 			      "'--strategy-option'"));
 		if (options.strategy)
-			die(_("error: cannot combine '--rebase_merges' with "
+			die(_("error: cannot combine '--rebase-merges' with "
 			      "'--strategy'"));
 	}
 
-- 
2.19.0-271-gfe8321ec05

