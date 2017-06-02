Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887C120D15
	for <e@80x24.org>; Fri,  2 Jun 2017 07:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbdFBHHa (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 03:07:30 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34750 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbdFBHH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 03:07:28 -0400
Received: by mail-oi0-f49.google.com with SMTP id o65so56580991oif.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 00:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=olBtQJPz1ZU7RqYeQTY9fblZHYDyWI21ZD+7TE6lqRQ=;
        b=kc1dHJHMJ0Wv811iYRJTwAZrmt/phwsN7FzqUJtlHJLSykawqentNGN8rKbROoqwxh
         0u1Nfvl06XFWmosodTwJew+qInTZVfC4jvaz16F+qBhbukogPzXKOY/6K0WaBX9BWDRc
         k4cVXgNZlGw5Fgs81YYclqoPcQ2y3XnpxIo/86vIsFzKBuMYFyiXzXzmiN8AFjtLyccP
         zJOcRxCDOczv6WE4neu14KeDy2LYr9bkdtfoiA7ftPlc9O7NpYlKXdZ504JkQi5h5cvz
         SFbI9VUA4oNZZjLp0okVhUv5vIJci5Q1y+nLpfgDf9HFekeAU0ERntrNjzJbk1/bm9R2
         rUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=olBtQJPz1ZU7RqYeQTY9fblZHYDyWI21ZD+7TE6lqRQ=;
        b=QPBwtKToisXP2bauRFvAF16nZH0DdhjAkoibyRe+ApfFhEb8n7f/iy1bKxmbcK69BF
         D6am0HAITtQW0XMEGruW3Y9Ca67+fkx9ohscVGDwtW3lDSWOdwutjK7Iysgnx3e1tcsZ
         pMgkJ6wOEUJav4OE/F7Rq6OSw17Dyz1hT3/bJRPdLoOUuZ5qiykjxIJiro4l/fo5PVpo
         IcrUU/X0o4JslcwfxEkn/mloDB498uSnvnnaG2uXc/rStrIVSaeX4fjFxuHWrVRhWLDp
         nWc3v1VMfz8klzPQQWMSriZ2QWvAM6TYW4z6XdN6HYjpeqU5uNOdthft0phesfa9GfQL
         tcdw==
X-Gm-Message-State: AODbwcAEN2DIJJoESOZWp7E/NW7vD55AXrtdBdrjqI3OCrxOK3Xs5vQg
        wGeohFmVL1dRUgxjb3u3gyZZERMbs0oN
X-Received: by 10.157.53.55 with SMTP id o52mr4165105otc.41.1496387232104;
 Fri, 02 Jun 2017 00:07:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.22.199 with HTTP; Fri, 2 Jun 2017 00:07:11 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <20170602070052.3lq22arcncuh6rrl@tigra>
References: <CAH8yC8k9pJHLuzWneb4aRAEF2zOTCVO_5YJxrCpw28x8bDox0A@mail.gmail.com>
 <CAH8yC8mjTXQ_5uRedHi=fytKtQttyq_WemGFNQTP9C3PK4x5cQ@mail.gmail.com> <20170602070052.3lq22arcncuh6rrl@tigra>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Fri, 2 Jun 2017 03:07:11 -0400
Message-ID: <CAH8yC8nGR1heD9_xRuHRG-oerdoQr6Pi8mT=ZpFhoeH6LaFK2w@mail.gmail.com>
Subject: Re: How to avoid "Please tell me who you are..."?
To:     Konstantin Khomoutov <kostix+git@007spb.ru>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2017 at 3:00 AM, Konstantin Khomoutov
<kostix+git@007spb.ru> wrote:
> On Fri, Jun 02, 2017 at 02:02:22AM -0400, Jeffrey Walton wrote:
>
>> I'm working on a test machine. It mostly needs to be a clone of
>> upstream. On occasion it needs to test a particular commit.
>>
>> When I attempt to test a commit it produces:
>>
>>     $ git cherry-pick eb3b27a6a543
>>
>>     *** Please tell me who you are.
> [...]
>> This is a nameless test account, so there is no information to provide.
>>
>> How do I tell Git to ignore these checks?
> [...]
>> Well, they don't exist so there's nothing to set.
>>
>> The machine below its a CubieBoard used for testing. I remote into it
>> with test@. As a matter of policy, no check-ins occur on it. Other
>> than the password database and authroized_keys file, there is no
>> information on it to be lost or stolen.
>
> `git cherry-pick` wants to record a commit.  A commit in Git always
> possess the information on "the committer" -- whoever recorded the
> commit (it might be distinct from the commit author, as is the case with
> cherry-picking).  There's no way to not set the committer.
>
> I envision two ways to get around this situation:
>
> 1) Patch the ~/.whatevershellrc of your test account to set this
>    information by setting and exporting the GIT_AUTHOR_NAME and
>    GIT_AUTHOR_EMAIL env. variables (and may be others -- see the
>    "git" manual page; run `git help git`).
>
>    May be even add it in /etc/skel to make all accounts create inherit
>    it.
>
> 2) Set these parameters in the repository you're working with.
>
>    While Git suggests you to pass "--global" to the `git config`
>    invocations, it's perfectly OK to use "--local" with them (which is
>    IIRC the default, if not supplied) to make these settings be recorded
>    in the repository's configuration rather than in ~/.gitconfig.
>
> 3) Pass these options explicitly to Git invocations or make a shell
>    alias which would do so, like with
>
>    function git() {
>      command git \
>                 -c user.name='Joe Tester' \
>                 -c user.email=tester@acme.corp \
>                 "$@"
>    }
>
> I'd personally go with (2).

Thanks.

Is there no switch? Its the most efficient way to accomplish the task.

Jeff
