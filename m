Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07AEC1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 16:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeJEXrC (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 19:47:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39752 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbeJEXrC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 19:47:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id q8-v6so2528113wmq.4
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=WoBiZFlxCjCQA6nyhcyc11DKWzRzDQcIm/LywdTuk1g=;
        b=aQBzRxWuvq3jf64iZL+ByzG0KFBnYyqDeXQ8eNYsbJV8O65x+dA/psy9WijnfHPHCR
         P95P4WPioWH7mxuONOs9X9A+QTD19tSUM+njABi6SIbXLRbiIrxssVf0Hccj1n3pMNRC
         bECJqV0u0JOhkSPICH2tgJyXDPcoSFapqHiTJMhp5uKcusbymiiLqfZz1fjzOoskWjuG
         MKYrx9TNXzndsA6DNMa6KAOQCtrBdxKYAw3RD39xWpMPaxV/jfJFL74ote6bQUe7pBXo
         VWBznUC+LUuGpqWGR8h5L+KS6tiaXIJ5PqxENhsZkMjzVocA7UrIilXPJi7DY2t7yFJW
         79KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=WoBiZFlxCjCQA6nyhcyc11DKWzRzDQcIm/LywdTuk1g=;
        b=cHlyauyrgraDmpDN/ERfgAFol7ERFPVeEMokobwiQjJHkbge0K0wnifPVl6r8KOuyT
         rcJ9u3xipco3U7dLOSj2uzSSJw6d1aRCKks4uudOx1Z5y5/uNQXTYA9qWtyEIMnwv2FC
         CIXZsNnnkkxI8hZh/SwK0f8c/pnlz2USgLmuMZlyNiK5FFtF4cwLifpFIwLSnOYEeXvv
         NBlYddmJi0DJ0CSdjqTH5snc5GRbhq6t9X5XnF6uvUjJ21efkJJjWO4FPT2dNkwf+DTa
         /UfO1t3BNB0IoF+OgUZI41D/nrKN0YN7BxJbI6J5DMfzzekWU+bJryA60cGDOU8iLOAo
         qLZg==
X-Gm-Message-State: ABuFfogyQSRW3OKeOHA3tavqPIex78KaA1NldTi+it8+s9pTunqKurRZ
        cvxhYVGpQItPRvoO8btqb1/Y15ZPiPc=
X-Google-Smtp-Source: ACcGV62ZR71KrI19RCYn0jcCKgL1G0PRC3MOsrr9MnhSwXPPPvMSDX5yO+cwbsPwEK+8teST0/MV0w==
X-Received: by 2002:a1c:cbc1:: with SMTP id b184-v6mr8268267wmg.149.1538758049254;
        Fri, 05 Oct 2018 09:47:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i7-v6sm8313356wrb.30.2018.10.05.09.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 09:47:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Qingyun <taoqy@ls-a.me>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] branch: trivial style fix
References: <20181005095213.12509-1-taoqy@ls-a.me>
Date:   Fri, 05 Oct 2018 09:47:27 -0700
Message-ID: <xmqqy3bcwdb4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Qingyun <taoqy@ls-a.me> writes:

> ---
>  builtin/branch.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index c396c41533..52aad0f602 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -222,10 +222,11 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  		if (!head_rev)
>  			die(_("Couldn't look up commit object for HEAD"));
>  	}
> -	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
> +	for (i = 0; i < argc; i++) {
>  		char *target = NULL;
>  		int flags = 0;
>  
> +		strbuf_reset(&bname);

This is not "trivial" nor "style fix", though.

It is not "trivial" because it also changes the behaviour.  Instead
of resetting the strbuf each time after the loop body runs, the new
code resets it before the loop body, even for the 0-th iteration
where the strbuf hasn't even been used at all.  It is not a "style
fix" because we do not have a particular reason to avoid using the
comma operator to perform two simple expressions with side effects
inside a single expression.

>  		strbuf_branchname(&bname, argv[i], allowed_interpret);
>  		free(name);
>  		name = mkpathdup(fmt, bname.buf);
> @@ -716,8 +717,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		print_columns(&output, colopts, NULL);
>  		string_list_clear(&output, 0);
>  		return 0;
> -	}
> -	else if (edit_description) {
> +	} else if (edit_description) {

This one is a style fix that is trivial.  It does not change the
semantics a bit, and we do prefer "else if" to be on the same line
as the closing "}" of the earlier "if" that opened the matching "{".

>  		const char *branch_name;
>  		struct strbuf branch_ref = STRBUF_INIT;
