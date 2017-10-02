Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7063920281
	for <e@80x24.org>; Mon,  2 Oct 2017 17:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbdJBRTz (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 13:19:55 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34084 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdJBRTy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 13:19:54 -0400
Received: by mail-pf0-f193.google.com with SMTP id g65so6339447pfe.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 10:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=MYbu1PF8svfqHCntLxLNSxgm0NZK/mWhcuJJhb0FPWg=;
        b=k8QrcbVQVBn6PpYl3GU8dttr6/9plIK/2tv+4/yPuteRYu7YSbINCyAsR9Qry6qQMw
         mnPsfcXiiPce+oZ7vfJ3Zx3KHDBZxatFDqKLNQ8oEKVYC5OYI92D5qucmfW67szlrw78
         3wAUVBQO4JeTpajWIgwRL8xWJU0kgeNQaZI/OJeiLXVgghLZQrOeh0hKyHA/JXrJ7wOw
         aYfuwREvoH294FkQit2osYnGQMNlgHzEK+zN8zYwQXC+vP0aFWvjTpGXixbATCB6MleY
         Hyy/dkx7NlUlrfh9Ql5lb8rnucbdULePwxD4KqnLzqFThQD/Xn2FwqEUYBotPDSS0Wkt
         /N4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=MYbu1PF8svfqHCntLxLNSxgm0NZK/mWhcuJJhb0FPWg=;
        b=VmLmf4NbduI90FMbC96RNxu4WPYO96BVAXpmyWQNB4dTEnDKTDxvuOeKOkRyTrbCG2
         iaeJoi2LDfLF0AVzHrUyrEjVfmUJKNe9qH4690aqalaVHnd7mQUyKL4mx64bQrKrXZck
         A8IaSO1Or8ADl4zfVzPooLukOzVuUtlX2QriArD/bS/6tzZVk6b88muyowV1caixsymS
         KCCrJ61uoFjdQEmAK15GrqTLZVJik3XX+6Kj7dlHIkI8q8ALzwzGaPSCqrDy6u2fVGHq
         6a7ZWu1DU9+PKC/P0O7SjG9lTNhF3hnuvjnrx9ao4vJ2t24y8SDYk9QYFpkwzB9UTZfJ
         nZSw==
X-Gm-Message-State: AHPjjUiKpyDZuImlT4kUqBKhNF9pk9ipT4Lqy1kob7bp3MFGNox2aEpf
        PR/L/zXulsSL/Zn/kew9XG0=
X-Google-Smtp-Source: AOwi7QDG9vjSG4DzIwf2EBHBuFGxw6xesWJIhcEhbXkmx4ZQDYnFFergEYoy5qN3uf+yuZazaMP/ng==
X-Received: by 10.99.66.196 with SMTP id p187mr13291433pga.0.1506964794106;
        Mon, 02 Oct 2017 10:19:54 -0700 (PDT)
Received: from unique-pc ([2405:204:7287:7232:c31:a746:72c9:9586])
        by smtp.googlemail.com with ESMTPSA id e133sm18202713pfh.177.2017.10.02.10.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Oct 2017 10:19:53 -0700 (PDT)
Message-ID: <1506964786.3504.3.camel@gmail.com>
Subject: Re: [PATCH v2] branch: change the error messages to be more
 meaningful
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
In-Reply-To: <20170821133608.5652-1-kaarticsivaraam91196@gmail.com>
References: <20170730115908.13841-1-kaarticsivaraam91196@gmail.com>
         <20170821133608.5652-1-kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 02 Oct 2017 22:49:46 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-08-21 at 19:06 +0530, Kaartic Sivaraam wrote:
> The error messages shown when the branch command is misused
> by supplying it wrong number of parameters wasn't meaningful.
> That's because it used the the phrase "too many branches"
> assuming all parameters to be "valid" branch names. It's not
> always the case as exemplified below,
> 
>         $ git branch
>           foo
>         * master
> 
>         $ git branch -m foo foo old
>         fatal: too many branches for a rename operation
> 
> Change the messages to be more general thus making no assumptions
> about the "parameters".
> 
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  Changes in v2:
> 
>     - changed the wordings of the error message
> 
>  builtin/branch.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index a3bd2262b..62981d358 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -707,12 +707,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		else if (argc == 2)
>  			rename_branch(argv[0], argv[1], rename > 1);
>  		else
> -			die(_("too many branches for a rename operation"));
> +			die(_("too many arguments for a rename operation"));
>  	} else if (new_upstream) {
>  		struct branch *branch = branch_get(argv[0]);
>  
>  		if (argc > 1)
> -			die(_("too many branches to set new upstream"));
> +			die(_("too many arguments to set new upstream"));
>  
>  		if (!branch) {
>  			if (!argc || !strcmp(argv[0], "HEAD"))
> @@ -735,7 +735,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		struct strbuf buf = STRBUF_INIT;
>  
>  		if (argc > 1)
> -			die(_("too many branches to unset upstream"));
> +			die(_("too many arguments to unset upstream"));
>  
>  		if (!branch) {
>  			if (!argc || !strcmp(argv[0], "HEAD"))


I was recently searching to find the patches have gone missing in to
the void for no obvious reason and found this. Should I consider this
to be "Dropped" in terms of the "What's cooking" emails? or has this
just not received the required attention?

---
Kaartic
