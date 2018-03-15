Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D97941F404
	for <e@80x24.org>; Thu, 15 Mar 2018 21:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeCOVwL (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 17:52:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51022 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeCOVwL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 17:52:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id w128so13217487wmw.0
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gxKsYeVEVK6pMR/hMEvCr3ITgB9iaoHEvupTlNqtkUg=;
        b=cz8kzGEA/SS+1qT+yOFrfXE0NPPBETtaJffmXgr9p1THI7EVzH87Q2NIJPNWsoXqh2
         E6OcwQQXssh6gozIOLBZwxFf9HPCyvxB1nsarD1vwUe19RjmpvoDsXjxbbAyKZIc3+5l
         ybI/HD4fEJmdgOlSmcnSV447Fe2z1Nxw1U4/yW0ZIVA5QCxAdxbZ14wOBFIvENpcFG9R
         8MNUQYerz2jWAulmjpZ2UWwgfX2W7dLRhoZVuGipvMks3oxb4FosSgkCgOi5cr9oP4Py
         zVl0eIBp/JojtZG9Hgpc3LHmlZU3FBmnny9B2i+p0rI0wIWML5rBMiPOiEHA3PaKwf0q
         j9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gxKsYeVEVK6pMR/hMEvCr3ITgB9iaoHEvupTlNqtkUg=;
        b=GSLYNhJJzHF8UX2Kpo/QsDyEtywzavELi6JLJLEvG2vlaPDOFZdBwowkvM+YYBrKHZ
         lrQqxRYIwqGLlRtIBZn6k5fuu0q/24AI69jVdSThR6udBQzaYqeRzfaVM8Zl/fJ2gKrs
         YWA05n9vMCfHLSN4U3HbyOeGuU2qwrLJcbRj6DqVcJCwzhA0uPHG79jpKbPZKqZLH9wD
         AD7o0oVoxvummgrd5j3Xi1Jqj4DlXGNFQSafU0+gT/RJ2MRHLbocB9Z5nvnFF/wNqUo+
         nzl9ZRpFbWqrgfgBe2GLwRttOIuUGYHGJXn/xCzHKKSqdksezg/5dWKy7s9nDFQap/Lz
         HZ0w==
X-Gm-Message-State: AElRT7HGPT+YSzfVZBLRfM8xIUMtigMy7R2yeGqog7GjJtI0pGEFrJ2D
        3GLbjPma3IeswBIT+azpYyk=
X-Google-Smtp-Source: AG47ELs7Xh8cUMCGRWFjjDDj0NG+o6ZQnpkWbk8yGyxTu8maUHaonlxpSi+5p7aIUODQaSJVrX4V+w==
X-Received: by 10.28.51.213 with SMTP id z204mr5527422wmz.74.1521150729721;
        Thu, 15 Mar 2018 14:52:09 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id i12sm5639252wrc.28.2018.03.15.14.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Mar 2018 14:52:09 -0700 (PDT)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
 <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
 <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
 <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <2749ce78-8917-c821-6116-0c8d67b5e16e@gmail.com> <87vadyd9az.fsf@javad.com>
 <d5e68db4-8006-2c0e-bc21-0b136503edd9@gmail.com> <87zi397uak.fsf@javad.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <a3d40dca-f508-5853-89bc-1f9ab393416b@gmail.com>
Date:   Thu, 15 Mar 2018 22:51:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87zi397uak.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On 15/03/2018 07:00, Sergey Organov wrote:
> 
> > > Thinking about it I've got an idea that what we actually need is
> > > --no-flatten flag that, when used alone, will just tell "git rebase" to
> > > stop flattening history, and which will be implicitly imposed by
> > > --recreate-merges (and --preserve-merges).
> > >
> > > Then the only thing the --recreate-merges will tune is to put 'merge'
> > > directives into the todo list for merge commits, exactly according to
> > > what its name suggests, while the default behavior will be to put 'pick'
> > > with suitable syntax into the todo. And arguments to the
> > > --recreate-merge will specify additional options for the 'merge'
> > > directive, obviously.
> >
> > This seem to basically boil down to what I mentioned previously[2] 
> > through use of new `--rebase-merges` alongside `--recreate-merges`, just 
> > that you named it `--no-flatten` here, but the point is the same - and 
> > not something Johannes liked, "polluting" rebase option space further.
> 
> Not quite so. The problem with --XXX-merges flags is that they do two
> things at once: they say _what_ to do and _how_ to do it. Clean UI
> designs usually have these things separate, and that's what I propose.
> 
> The --[no-]flatten says _what_ (not) to do, and --recreate-merges says
> _how_ exactly it will be performed. In this model --no-flatten could
> have been called, say --preserve-shape, but not --rebase-merges.
> 
> To minimize pollution, the _how_ part could rather be made option value:
> 
> --no-flatten[=<strategy>]
> 
> where <strategy> is 'rebase', 'remerge', etc.
> 
> In this case we will need separate option to specify strategy options,
> if required, that will lead us to something similar to the set of merge
> strategies options.
> 
> > I would agree with him, and settling onto `--rebase-merges` _instead_ of 
> > `--recreate-merges` seems as a more appropriate name, indeed, now that 
> > default behavior is actually merge commit rebasing and not recreating 
> > (recreating still being possible through user editing the todo list).
> 
> I hope he'd be pleased to be able to say --no-flatten=remerge and get
> back his current mode of operation, that he obviously has a good use
> for.

Makes sense, I like it, thanks for elaborating. [ Especially that you 
used "(no) flatten" phrasing, where original `--preserve-merges` 
documentation says it`s used "not to flatten the history", nice touch ;) ]

Not sure if I would prefer original `recreate` instead of `remerge` 
as that particular strategy name, though, but might be I`m just more 
used to the former one at the moment.

But if I think about it more, "recreate" seems straightforward enough - 
create something (again), kind of making it more obvious that it is a 
new thing (that we are now creating, again, based on some old thing).

On the other hand, "remerge" communicates "merge something again", 
which doesn`t necessarily mean creating a new thing (based on, but 
not attached to old thing), and could also be interpreted as "merge 
existing thing again" (and leaves me wondering if it would better 
suite some other strategy possible in the future).

Not sure if that explanation suffices, but it comes to "recreate a 
merge" having more clear meaning than "remerge a merge", being 
somewhat ambiguous, thus confusing (to me, at least).

I don`t know, thinking too much?

Regards, Buga
