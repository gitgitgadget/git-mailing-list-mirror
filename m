Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08611F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 22:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754238AbdBAWal (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 17:30:41 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35447 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753031AbdBAWal (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 17:30:41 -0500
Received: by mail-pf0-f194.google.com with SMTP id f144so32775658pfa.2
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 14:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fkHTrAh082gMKs1hF42rgrsx/MuNaW2k5nXm7MWzO4Y=;
        b=tmlRbjGlhet9C7gxV/55OAazZQd9mlJikmD6R5toK/H7XoQ+0EcPFQoHNnWkuuZn9w
         CLFjY73pQs2V59xpt4p703+lCFq9aHZenHq/TOKEkPW07ZU1phxzg9Oh5unkckjUeN5o
         LwDxIxRIlUKI1J16i2dWtPSlxtDkNxesuIA5wmxqlrkkFVAkm16iPSZebvyj+M6doDlS
         09bblEDJd6aMx+CIZi7SbuWSV5mX9ANF394B7pPKxaa0fuMkl5JWJHZHjopsTfuMc2eT
         NdnvtzlzlsvX6TG6+Fdh7HYiHTyLylODHHOigKlU7qz6L+AbNyA1yTtO0l4jwKEjddOO
         CeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fkHTrAh082gMKs1hF42rgrsx/MuNaW2k5nXm7MWzO4Y=;
        b=aYcmiSpjXTyYngFlMn8prn95+/UZ8XOsbtC+FtPL7m3k0Y8NldNpd+D7kxL1nQBKZp
         qBIHmORGm3ygjDxdMDVjfUz3En1OcKFpqOQDj9abkcQaHNH9CkZ60IXVyBljsd3vtoLU
         8wQoXx4O0ghyhaqlD1R1ZpOUI7qVoBKfIiNx8Tq1ZOEgNwYysEa4fycfSKvd7PAyg+7R
         ubZJpm0eaDezq6LXmuWR9YNqg/0cDGPFVcqrpS6V9givAFhj42iY06c6izdsQoXF28Gd
         STlheCl1lWNqeoVcmeFeTwrTY1U3KbqZH0Pm7mbKwsh5LgjzQg7lQMiWHuUJcg33MuYJ
         qd4g==
X-Gm-Message-State: AIkVDXJAGlMy46Ns6Wnj5G5d3ytKAW4Kh5ruLfouMmoe8NfuaJHebhGzHyCq833ThHj89g==
X-Received: by 10.98.204.216 with SMTP id j85mr6506428pfk.130.1485988240360;
        Wed, 01 Feb 2017 14:30:40 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id f3sm52281356pfd.10.2017.02.01.14.30.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 14:30:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     cornelius.weig@tngtech.com
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] doc: add note about ignoring --no-create-reflog
References: <20170201220727.18070-1-cornelius.weig@tngtech.com>
Date:   Wed, 01 Feb 2017 14:30:38 -0800
In-Reply-To: <20170201220727.18070-1-cornelius.weig@tngtech.com> (cornelius
        weig's message of "Wed, 1 Feb 2017 23:07:27 +0100")
Message-ID: <xmqq4m0do86p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cornelius.weig@tngtech.com writes:

> From: Cornelius Weig <cornelius.weig@tngtech.com>
>
> The commands git-branch and git-tag accept a `--create-reflog` argument.

For the purpose of contrasting the above with "--no-create-reflog",
I find it a bit too weak to just say "accept".  How about

    The commands git-branch and git-tag accept a `--create-reflog`
    option, and creates reflog even in a repository where
    core.logallrefupdates configuration is set not to.

or something?  After all "--no-create-reflog" is accepted.  It just
does not override the configured (or unconfigured) default.

> On the other hand, the negated form `--no-create-reflog` is accepted as
> a valid option but has no effect. This silent noop may puzzle users.

True, very true.

> To communicate that this behavior is intentional, add a short note in
> the manuals for git-branch and git-tag.

Hmph.  The added "short note" merely states the fact; it does not
hint that it is intentional or it explains what reasoning is behind
that intention.

> Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
> ---
>
> Notes:
>     In a previous discussion (<xmqqbmunrwbf.fsf@gitster.mtv.corp.google.com>) it
>     was found that git-branch and git-tag accept a "--no-create-reflog" argument,
>     but it has no effect, does not produce a warning, and is undocumented.

Reading what Peff said in the thread, I do not think we actively
wanted this behaviour; we agreed that it is merely acceptable.  

So perhaps s/this behaviour is intentional/this is known/ to weaken
the log message?  That way, when somebody else who really cares
comes later and finds this commit that adds explicit notes to these
manual pages via "git blame", s/he would not be dissuaded from
making things better.  Such an update may make it warn when
core.logallrefupdates is not set to false (and continue to ignore
the command line option), or it may make the command line option
actually override the configured default.

With such an update to the log message, I think the patch looks
good.

Thanks.

>  Documentation/git-branch.txt | 1 +
>  Documentation/git-tag.txt    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 1fae4ee..fca3754 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -91,6 +91,7 @@ OPTIONS
>  	based sha1 expressions such as "<branchname>@\{yesterday}".
>  	Note that in non-bare repositories, reflogs are usually
>  	enabled by default by the `core.logallrefupdates` config option.
> +	The negated form `--no-create-reflog` is silently ignored.
>  
>  -f::
>  --force::
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 5b2288c..b0b933e 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -152,6 +152,7 @@ This option is only applicable when listing tags without annotation lines.
>  --create-reflog::
>  	Create a reflog for the tag. To globally enable reflogs for tags, see
>  	`core.logAllRefUpdates` in linkgit:git-config[1].
> +	The negated form `--no-create-reflog` is silently ignored.
>  
>  <tagname>::
>  	The name of the tag to create, delete, or describe.
