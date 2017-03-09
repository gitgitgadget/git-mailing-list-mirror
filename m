Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0421FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 07:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbdCIHtp (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 02:49:45 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33417 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbdCIHto (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 02:49:44 -0500
Received: by mail-lf0-f42.google.com with SMTP id a6so24620513lfa.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 23:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qzMwCuYW5Po9SKK2JTD1/6IWix5U+dCIFPm5vdWepdI=;
        b=XMJf/NIgIhYd9FE6LCgAdtcIiC1zSM9aWFtzM7TGSB6kcDS3zGF9Mk2FfARgont0hi
         kilggVTbZXQOuS2CjYwpsy9xAH+82LISrqkld4Gw/Z/QqQxB+46j819R5JC8Us9sNT+P
         seejCdxEy01qznI55FoMpTMS5h2O/Q5igcjTJ3OWVwpQftQPi9mNJ+srY3PsiYxyMbqo
         hNLI+zmUCDOtjo38QC4HQto24uNodcIVxKRUzdjZv9hU6oihho3PViARbAaYwdTkbwHP
         1lPtFtUEFfhnj6wKkOWrmvBnXnFaTz9CYPTw94PcoelwblnaFWr6FjFkfNnf3QTKKCzq
         q98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qzMwCuYW5Po9SKK2JTD1/6IWix5U+dCIFPm5vdWepdI=;
        b=ZEoaYHaoAYqUpeS1+qKEilh2AnjR75b1dvWN+4mRl/yTPjcjNjorFmD7TgKXZWjWsc
         RoNVgnSxFBl7wQ7oSNNZacvsjcAwOZM6Zrw+ZVeLcN8bSV9bAG7Dp5feIyfWdvnMt/oR
         5O5sxiJWSqlA7EE4xsd0aJYrBIGK9jZk2dhvtGHLgncSVstcaqYi46nGRBLFhGw3SBbL
         seATVPFU7n4bHfJL384ooJxYefZxhrDsX6aphUQ7RIzFZ6W76wlt/wkJbOVjKPNUtn1d
         8nUtoGi0S0WG40/x4q9jK1eKL9zOa9J8ka0p9sQlKVFuqrXA6zCkVQMPkTdmIrHGMFjn
         kADA==
X-Gm-Message-State: AMke39loNR1m+C8D9TnVMoin/VIpkgh++bRnGWjwaeZZOkKEWg07QlDEfM8XHDqSwTzFvO3NHZByoyzTXWzGpw==
X-Received: by 10.46.71.81 with SMTP id u78mr3491546lja.16.1489045766477; Wed,
 08 Mar 2017 23:49:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Wed, 8 Mar 2017 23:49:25 -0800 (PST)
In-Reply-To: <CACczA6V6t4f6TTT=CJfqsuCtbYuM1QNh8AgtOwqRt7pz4VMeRA@mail.gmail.com>
References: <CACczA6V6t4f6TTT=CJfqsuCtbYuM1QNh8AgtOwqRt7pz4VMeRA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 9 Mar 2017 08:49:25 +0100
Message-ID: <CAP8UFD1k=uDRnrGJRw=NG9NmRVd8yMXcE_jyB=dpeKOf75HbCw@mail.gmail.com>
Subject: Re: [PATCH][GSoc] Changed signed flags to unsigned type
To:     Vedant Bassi <sharababy.dev@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2017 at 5:24 AM, Vedant Bassi <sharababy.dev@gmail.com> wrote:
> As part of my microproject :
>
> Use unsigned integral type for collection of bits:
> Pick one field of a structure that (1) is of signed integral type and
> (2) is used as a collection of multiple bits. Discuss if there is a
> good reason why it has to be a signed integral field and change it to
> an unsigned type otherwise.
>
> More ref: https://public-inbox.org/git/xmqqsiebrlez.fsf@gitster.dls.corp.google.com
> http://stackoverflow.com/questions/29795170/usage-of-signed-vs-unsigned-variables-for-flags-in-c
>
> I have found several structures where a signed int was used on flags
> for bitwise & to check various cases.

This email has a title that starts with "[PATCH]" but it doesn't
contain a real patch that can be applied using `git am` for example.
Please look at https://git.github.io/SoC-2017-Microprojects/ and at
Documentation/SubmittingPatches about how patches should be created.

> diff --git a/bisect.h b/bisect.h
>
> index a979a7f..4b562a8 100644
>
> --- a/bisect.h
>
> +++ b/bisect.h
>
> @@ -16,6 +16,8 @@ extern struct commit_list *filter_skipped(struct
> commit_list *list,
>
>
>
>  struct rev_list_info {
>
>         struct rev_info *revs;
>
> +
>
> + // int flags changed to unsigned int

You don't need to add such comments as "what has been done" will be
obvious when looking at the commit. It could be interesting to explain
"why the change is made" in the commit message though.

If there is something subtle in the code or something that could save
a reader some time if it was documented, then a comment might be
useful, but anyway comments should use "/* ... */" markers, not "//".

>         unsigned int flags;
>
>         int show_timestamp;
>
>         int hdr_termination;

[...]

> result : the changes were made in bisect.h , parse-options.h and  builtin/add.c
>
> I have not yet  tested these changes.

I think sending just one patch for bisect.h is ok. If you really want
you could send another patch for parse-options.h and yet another one
for builtin/add.c, all in the same patch series.

Anyway please test that the patches can be applied (using git am) and
that they look good (compared with other commits) when applied before
sending them to the list. And yeah it is also a good idea to also
check that the test suite still passes after each patch before sending
them.
