Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED7D51F403
	for <e@80x24.org>; Tue, 19 Jun 2018 16:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966803AbeFSQC7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 12:02:59 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34508 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966267AbeFSQC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 12:02:57 -0400
Received: by mail-wr0-f173.google.com with SMTP id a12-v6so231245wro.1
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 09:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nPvoArsVOsJhqi7MrzBvW7bgCch6bBVI7XWJASipJUs=;
        b=hMkK49YrxD+oAjbic7LXRvb6h1nsGzyUmtHZ0Tj42ogd/uRYSTTYZvMie0g/S0W71W
         OyZtYblRO12Cp5TZlp/Gd0j+eW765NRqLxzX8OiMHjPr+DObYcoSHBcQMMa2NDkz9/4S
         0lAlJsChejQbnN+nXKCgzTUyVYBXHJ7A7185Q3palJSfIKsRwBiwnTFoXQwt86z4UzhJ
         Id9Fo4W/cHFRjfrOzo5ctA8c84jpqg8xBEFPpZQIdWFFkMLJhjD/2OCZQB5SUPuN6BNE
         CuCV78TLwoyhKXeQvqZilpImHODp5DpK2YYGNGHYM9iCsyGOzbjIGRnGQ/9dOKShRM6t
         7Fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nPvoArsVOsJhqi7MrzBvW7bgCch6bBVI7XWJASipJUs=;
        b=Yn1cBslmK1abeTwGxQJ+wkkg4OIq9s+RuqPwitLgZIoAev1BOsbWtH1ipKVOCfPg1D
         hTxdAsWpYV3mvE3XafHcNFvtEJXCVLlRc2q+KJruaMwYL+hPHaORJbjmmwr58anpR209
         A36bU4xtdNUYNrA7JI5cm+9wpXPzKm0TZwHzRTkwa0ymTj/XLlRths1zGQcFXjJKTm1g
         Zd9CPlnXDXvnY/VQ/5TJrR2YxzfriO2k85ikaTWhqSX7/u9PPBumuPZG9b9KSbZLa2Ev
         ICWVHFRnfc4SWNotOsXnzutcMuliA/BSjhcZfa/qtW1xGYb0SJy8xn+NqHEhZvqGe+3E
         vwXw==
X-Gm-Message-State: APt69E342ocJCwDSrhB4c/fVQJjBREfvELfElPl21hlu/wceVJksHr52
        4+jj67p5k2kk2lmXhtrmAC4=
X-Google-Smtp-Source: ADUXVKIcZ4ShR3a+OwOUWy5o7jv4aQ+tne/2Qa21oOqQEZ4bm14rhcb4lCb60b7yoRd+zD67EGxOrQ==
X-Received: by 2002:adf:b89b:: with SMTP id i27-v6mr13747526wrf.163.1529424176163;
        Tue, 19 Jun 2018 09:02:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 72-v6sm61962wrb.22.2018.06.19.09.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 09:02:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Xtreak <tir.karthi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 signed off] doc: fix typos in documentation and release notes
References: <0102016409c877f9-58c13d7c-4d25-43e2-8d64-c13d98b88ee7-000000@eu-west-1.amazonses.com>
        <010201640c072de4-d408b8ac-3a10-4c2f-9b65-34a9582c1839-000000@eu-west-1.amazonses.com>
Date:   Tue, 19 Jun 2018 09:02:54 -0700
In-Reply-To: <010201640c072de4-d408b8ac-3a10-4c2f-9b65-34a9582c1839-000000@eu-west-1.amazonses.com>
        (Xtreak's message of "Sun, 17 Jun 2018 04:35:54 +0000")
Message-ID: <xmqqefh2wyq9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xtreak <tir.karthi@gmail.com> writes:

> Signed-off-by: Karthikeyan Singaravelan <tir.karthi@gmail.com>
> ---
>  Documentation/RelNotes/1.7.11.7.txt | 2 +-
>  Documentation/RelNotes/2.17.0.txt   | 2 +-
>  Documentation/RelNotes/2.18.0.txt   | 2 +-
>  Documentation/diff-options.txt      | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Thanks, will apply.

>
> diff --git a/Documentation/RelNotes/1.7.11.7.txt b/Documentation/RelNotes/1.7.11.7.txt
> index e7e79d999bd38..e743a2a8e46eb 100644
> --- a/Documentation/RelNotes/1.7.11.7.txt
> +++ b/Documentation/RelNotes/1.7.11.7.txt
> @@ -25,7 +25,7 @@ Fixes since v1.7.11.6
>     references" nor "Reload" did not update what is shown as the
>     contents of it, when the user overwrote the tag with "git tag -f".
>  
> - * "git for-each-ref" did not currectly support more than one --sort
> + * "git for-each-ref" did not correctly support more than one --sort
>     option.
>  
>   * "git log .." errored out saying it is both rev range and a path
> diff --git a/Documentation/RelNotes/2.17.0.txt b/Documentation/RelNotes/2.17.0.txt
> index d6db0e19cf17b..c2cf891f71adf 100644
> --- a/Documentation/RelNotes/2.17.0.txt
> +++ b/Documentation/RelNotes/2.17.0.txt
> @@ -342,7 +342,7 @@ Fixes since v2.16
>     validate the data and connected-ness of objects in the received
>     pack; the code to perform this check has been taught about the
>     narrow clone's convention that missing objects that are reachable
> -   from objects in a pack that came from a promissor remote is OK.
> +   from objects in a pack that came from a promisor remote is OK.
>  
>   * There was an unused file-scope static variable left in http.c when
>     building for versions of libCURL that is older than 7.19.4, which
> diff --git a/Documentation/RelNotes/2.18.0.txt b/Documentation/RelNotes/2.18.0.txt
> index 7c59bd92fbd99..1eb13ece53600 100644
> --- a/Documentation/RelNotes/2.18.0.txt
> +++ b/Documentation/RelNotes/2.18.0.txt
> @@ -324,7 +324,7 @@ Fixes since v2.17
>     after giving an error message.
>     (merge 3bb0923f06 ps/contains-id-error-message later to maint).
>  
> - * "diff-highlight" filter (in contrib/) learned to undertand "git log
> + * "diff-highlight" filter (in contrib/) learned to understand "git log
>     --graph" output better.
>     (merge 4551fbba14 jk/diff-highlight-graph-fix later to maint).
>  
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index f466600972f86..bfa3808e49cc0 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -133,7 +133,7 @@ These parameters can also be set individually with `--stat-width=<width>`,
>  	as file creations or deletions ("new" or "gone", optionally "+l"
>  	if it's a symlink) and mode changes ("+x" or "-x" for adding
>  	or removing executable bit respectively) in diffstat. The
> -	information is put betwen the filename part and the graph
> +	information is put between the filename part and the graph
>  	part. Implies `--stat`.
>  
>  --numstat::
>
> --
> https://github.com/git/git/pull/510
