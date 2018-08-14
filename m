Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52ACE1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 20:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbeHNXsI (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:48:08 -0400
Received: from mail-yw1-f44.google.com ([209.85.161.44]:44842 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbeHNXsI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:48:08 -0400
Received: by mail-yw1-f44.google.com with SMTP id l9-v6so17284785ywc.11
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJuf0ZjH8L21mwCLVzprzcjfSnMpQSe5b2trjPWMaLQ=;
        b=YqbNhl3RBtQxaaGUnbEVPEqxvJb1F7MzkJE9nRonCEeHv/IAC3XjcSB29eO+wF3XvM
         K0DTmoNdE0YQ1abtq5OlzBl2YfKSJ0Md9wxo4ES6voL95LmswyJrZczK3teQLhCHjEuG
         OVJ3rrWoAcHw8aLpz4f4xJwkrHuz7P4jDidjcCvTYVs2kygT5SwDlyyJkOtIRb38JRLM
         LNbimlfKMdBZAoOvxYL1xXUSBanxeBvfl5tanU8Pz98EN0gQiX7wfGkiUxIU/gz7Ygwe
         LYaRS/sL01oaG3WbdoK6/MKa2B6iZvbQjk148qkPkAsijB3CZK7NS7LCs0c5YQgsR70r
         gGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJuf0ZjH8L21mwCLVzprzcjfSnMpQSe5b2trjPWMaLQ=;
        b=pYoGRkMjO4t39rq4nPo9r5MZaJA2GvX4wfl+zoY7yiFFdj9x75AawFs9IBS3xbCtNH
         mOunsm4j1JrvYLyZozwr3c/6bfXJI8sN9Qf8MXfQFqpkd7WlnMkHPToiLfBi+q2KhwlJ
         g3w/t9vwY5bO08ZEK6kirTITwAMw+uwZGEzxoFnwlnPIwAYzZHYsIegq5iDu6PvK408Y
         zOazKwDcUvtlGN6EQmVO5jf2/Rs2UH/jnAm9b+pGNsoZGocW78ejy5/QL3Oi/E4JpNTN
         ZZqGHeA3EusZVfvMUHVQVeeb2mnxa1LF7S8Ti93+6Hr5Kq7y46QcsqD7hjBNlk/h8fZ7
         YRbA==
X-Gm-Message-State: AOUpUlH3hoSfpYDJQogoGeSIjBgONk35kO3gmMS80At35KfEH854mjYR
        n5TmR/N3xRfZYov6FnmdnC6bd3KGVyvvOphdj4lpThec
X-Google-Smtp-Source: AA+uWPyQ+Vm/8bJmZ/B2m/kVavRpG1VvZKRcUyUoof23mR74QzYl+UDP2roDQlTFbElbsW7d9zJbbI7cUxD2bcKj5Wo=
X-Received: by 2002:a81:ae41:: with SMTP id g1-v6mr12204204ywk.345.1534280348638;
 Tue, 14 Aug 2018 13:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD0_jpKdcDvNx5CYnmyDMagE_O-E7cef5VthaT_w-=4xsA@mail.gmail.com>
In-Reply-To: <CAP8UFD0_jpKdcDvNx5CYnmyDMagE_O-E7cef5VthaT_w-=4xsA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 13:58:57 -0700
Message-ID: <CAGZ79kZo3TK7O0bb+mKOkeLkp=rFHfFwGS6oispcvHwCEEh=LA@mail.gmail.com>
Subject: Re: Syncing HEAD
To:     Christian Couder <christian.couder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 1:09 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> When cloning with --mirror, the clone gets its HEAD initialized with
> the value HEAD has in its origin remote. After that if HEAD changes in
> origin there is no simple way to sync HEAD at the same time as the
> refs are synced.
>
> It looks like the simplest way to sync HEAD is:
>
> 1) git remote show origin
> 2) parse "HEAD branch: XXX" from the output of the above command
> 3) git symbolic-ref HEAD refs/heads/XXX
>
> It looks like it would be quite easy to add an option to `fetch` to
> sync HEAD at the same time as regular refs are synced because every
> fetch from an origin that uses a recent Git contains something like:
>
> 19:55:39.304976 pkt-line.c:80           packet:          git< YYYYYYYY
> HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow
> deepen-since deepen-not deepen-relative no-progress include-tag
> multi_ack_detailed no-done symref=HEAD:refs/heads/test-1
> agent=git/2.18.0
>
> which in this example shows that HEAD is a symref to refs/heads/test-1
> in origin.
>
> Is there a reason why no such option already exists? Would it makes
> sense to add one? Is there any reason why it's not a good idea? Or am
> I missing something?

I think it is a great idea to add that. IIRC there was some talk when
designing protocol v2 on how fetching of symrefs could be added later
on in the protocol, which is why I cc'd Brandon who did the work there.

> I am asking because GitLab uses HEAD in the bare repos it manages to
> store the default branch against which the Merge Requests (same thing
> as Pull Requests on GitHub) are created.
>
> So when people want to keep 2 GitLab hosted repos in sync, GitLab
> needs to sync HEADs too, not just the refs.
>
> I think this could be useful to other setups than GitLab though.

As said, I can see how that is useful; I recently came across some
HEAD bug related to submodules, and there we'd also have the application.

    git clone --recurse-submodules file://...

might clone the submodules that are in detached HEAD, which is totally
not a long term viable good HEAD, so a subsequent fetch might want
to change the detached HEAD in submodules or re-affix it to branches.

Unrelated/extended: I think it would be cool to mirror a repository even
more, e.g. it would be cool to be able to fetch (if configured as allowed)
the remote reflog, (not to be confused with you local reflog of the remote).
I think that work would be enabled once reftables are available, which you
have an eye on?
