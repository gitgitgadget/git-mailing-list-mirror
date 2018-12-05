Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3447A211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 15:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeLEPb6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 10:31:58 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:44846 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeLEPb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 10:31:57 -0500
Received: by mail-ua1-f46.google.com with SMTP id d19so7227570uaq.11
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 07:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zX2omBNb+MQf9OuErmDM7qQvA1PRUexI5Bmmquo14As=;
        b=cS7XxLFYHEYBCJ/Yst5P4vnPLBVywZvXsEkAS/n/iEd9yCqvA00c2I/AFz3Bj7XM2h
         0nAFV9U4kLkp5Xr0YwV7ejcaecNtaCXQQty7yXzSpYNVpqPnuGxLlrJDfIvIQgHKpIdE
         lHvOD8Xx54mXrXgl8C0DnN3r+ooyJSLJGYXi3CUNwljIv8oY0lRvsc80GkubJgPgf8lf
         zKirXT9bDKRTYV34LT5hyfKRDF8TfPUlfXdZNAkEY9qTeNcpaT58W5ZXI7lXK/6zxuNt
         gTiX0XCfH9kh5jh+VNQ6Ltki/CNcVjOLhGS+VzkQZWWH1ELJXHdXHp4aLwI4SzqSHRzN
         EjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zX2omBNb+MQf9OuErmDM7qQvA1PRUexI5Bmmquo14As=;
        b=s75JpJixXKrAvzsE85esNc7OLozQ5iNsHfifqj0xMVbwCC4wolGqitr8oYOJIK8VXp
         DqQ+0a7vRu8fK+ikZSMiiO4wSnlluolfxAEbw6QppvMmEd5/v4jYQM8iNaJbrm22UKCG
         gKW7rI8TEH5X9TI7EXfD8dXk1n2rFijEi52mPQBdNGKjoaLuteZFKOx8A6qBB4v5dZCh
         FKKE0HAX5euCLsug7ZhqCliZmbL+IIUjw/Qbyw8TTX7ZUaml//D/eq084vGlM8YmWqbf
         pAQyBCDBEFrphQ+BGbf1gFZCZqt52jzYl7U0Kv8G2tihb0en+M7LWcIeWc7/TsoQcO55
         31gw==
X-Gm-Message-State: AA+aEWZKSw2JDGTtt2nHecds5Yr6Z06N6PaSRApMYhz7M/Klpuam7PE6
        pB3Oh+Itp56or2zrhz4LqYdw+72gpO2lXSgwqLA=
X-Google-Smtp-Source: AFSGD/U6KuJcKs/Hug3kd7rWTY1PqrdupCYdeF4Rla05XSK5FPTCXkMkiA5gCC0AEdajyFn29ouwwQxA5W+dCQMP44E=
X-Received: by 2002:ab0:60da:: with SMTP id g26mr10793676uam.104.1544023916431;
 Wed, 05 Dec 2018 07:31:56 -0800 (PST)
MIME-Version: 1.0
References: <5e5c6d1c-6b3e-c94a-17be-a2af518c1607@yandex.ru> <20181205145419.vbbaghzzrnceez45@tigra>
In-Reply-To: <20181205145419.vbbaghzzrnceez45@tigra>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Dec 2018 07:31:45 -0800
Message-ID: <CABPp-BHhYgBndaOjTC9-YQ5gNJXqaw21Hf=FZzyA7AKDQvN+0A@mail.gmail.com>
Subject: Re: Any way to make git-log to enumerate commits?
To:     kostix@bswap.ru
Cc:     hi-angel@yandex.ru, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 5, 2018 at 6:56 AM Konstantin Khomoutov <kostix@bswap.ru> wrote:
>
> On Wed, Dec 05, 2018 at 05:22:14PM +0300, Konstantin Kharlamov wrote:
>
> > It would be great if git-log has a formatting option to insert an
> > index of the current commit since HEAD.
> >
> > It would allow after quitting the git-log to immediately fire up "git
> > rebase -i HEAD~index" instead of "git rebase -i
> > go-copy-paste-this-long-number-id".
>
> This may have little sense in a general case as the history maintained
> by Git is a graph, not a single line. Hence your prospective approach
> would only work for cases like `git log` called with the
> "--first-parent" command-line option.
>
> Still, for a simple approach you may code it right away yourself.
> Say, let's create an alias:
>
>   $ git config alias.foo '!git log "$@" --pretty=oneline --source | {
>       n=0;
>       while read sha ref rest; do
>         printf "%s\t%s~%s\t%s\n" "$sha" "$ref" $n "$rest"
>                 n=$((n+1))
>           done
>     }'
>
> Now calling `git foo --abbrev=commit` would output something like
>
> 9be8e297d        HEAD~7       Frobincated fizzle
>
> where "7" is what you're looking for.
>
> A more roubst solution may need to use the `git rev-list` command.

Or, just use name-rev so it works with non-linear histories too:

git log | git name-rev --refs=$(git symbolic-ref HEAD) --stdin | less

That'll add things like "master~7" for stuff in the first parent
history and output like "master~7^2~3" for commits on side-branches,
either of which can be fed to other git commands.
