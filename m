Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF83E1F406
	for <e@80x24.org>; Tue, 26 Dec 2017 00:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbdLZAQ0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 19:16:26 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:36496 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdLZAQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 19:16:25 -0500
Received: by mail-io0-f180.google.com with SMTP id i143so11169595ioa.3
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 16:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/jONEfFmq9T3j9vTrxSQk6LsU6tenKgbm0SKAk9qjsA=;
        b=QBu/JaK5Ex5VIsSbScy/0M5kIY0OQJ+a0PW+8122x4dzaDtL79TBDx7Mbo178hH7bL
         zob8Bo8muoLZJBxrwuwoA+NuWwQ2nqROMYlP60JOC2qHU9vF9QC7Zd2arBIgVzatUGnh
         8RSo6pLV88nvf/FdXUJh017dAT8cxj9+WINQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/jONEfFmq9T3j9vTrxSQk6LsU6tenKgbm0SKAk9qjsA=;
        b=oSsCIwb5XovukJDK7duKArvc1uwl6KWa2UOUFlcaX0E+A4k4drdKQtU38Iv2qzOniK
         7jotI8Wkt62aJOOBeI9haRx34Z+QyObWwRBvIbadVw4O8xFX0xQ6m75MC+qU8M1JskrB
         TR5mLY653oieZcDyMvRBOBsL9FlrYOSwazj+4U7A5pt70Sqp1b3QcA7XljWn+fNUkEF3
         owh3zgILf6WaIbmkZhIIwPhxZcM6HZzHkz3bj6CqexJBQQdEr7Uir9TS2ZoEdH/gN9pq
         vrg4qfmdCSLUuXz+Ahzxm3oPopP3Ac6OEHYytX676BzgbD2WQsrMsbY8Hi5YWuPgbiyW
         DhUQ==
X-Gm-Message-State: AKGB3mL9mMQt8+2chFROquP1fM6GwLM80c1ZN/V6FmD9v841hW1Fdtq3
        StUAkmh/jcsr22EYvoGtdwICnQ==
X-Google-Smtp-Source: ACJfBovUEPzl79hhEQpez9nqkimosoMSwcUiIJmFEVfRuD4hAqirBRLZS7v8PC/DOUR8U/qLGajT4g==
X-Received: by 10.107.131.203 with SMTP id n72mr30969838ioi.91.1514247384662;
        Mon, 25 Dec 2017 16:16:24 -0800 (PST)
Received: from Carl-MBP.ecbaldwin.net ([2601:282:8001:ffba:86f:967d:39c5:9c84])
        by smtp.gmail.com with ESMTPSA id 140sm8826033itx.0.2017.12.25.16.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2017 16:16:24 -0800 (PST)
Date:   Mon, 25 Dec 2017 17:16:22 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20171226001622.GA16219@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <877etds220.fsf@evledraar.gmail.com>
 <20171223210141.GA24715@hpz.ecbaldwin.net>
 <87608xrt8o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87608xrt8o.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 23, 2017 at 11:09:59PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> But I don't see why you think this needs a new "replaces" parent
> >> pointer orthagonal to parent pointers, i.e. something that would
> >> need to be a new field in the commit object (I may have misread the
> >> proposal, it's not heavy on technical details).
> >
> > Just to clarify, I am proposing a new "replaces" pointer in the commit
> > object. Imagine starting with rebase exactly as it works today. This new
> > field would be inserted into any new commit created by a rebase command
> > to reference the original commit on which it was based. Though, I'm not
> > sure if it would be better to change the behavior of the existing rebase
> > command, provide a switch or config option to turn it on, or provide a
> > new command entirely (e.g. git replay or git replace) to avoid
> > compatibility issues with the existing rebase.
> 
> Yeah that sounds fine, I thought you meant that this "replaces" field
> would replace the "parent" field, which would require some rather deep
> incompatible changes to all git clients.
> 
> But then I don't get why you think fetch/pull/gc would need to be
> altered, if it's because you thought that adding arbitrary *new* fields
> to the commit object would require changes to those that's not the case.

Thank you again for your reply. Following is the kind of commit that I
would like to create.

    tree fcce2f309177c7da9c795448a3e392a137434cf1
    parent b3758d9223b63ebbfbc16c9b23205e42272cd4b9
    replaces e8aa79baf6aef573da930a385e4db915187d5187
    author Carl Baldwin <carl@ecbaldwin.net> 1514057225 -0700
    committer Carl Baldwin <carl@ecbaldwin.net> 1514058444 -0700

What will happen if I create this today? I assumed git would just choke
on it but I'm not certain. It has been a long time since I attempted to
get into the internals of git.

Even if core git code does not simply choke on it, I would like push and
pull to follow these pointers and transfer the history behind them. I
assumed that git would not do this today. I would also like gc to
preserve e8aa79baf6 as if it were referenced by a parent pointer so that
it doesn't purge it from the history.

I'm currently thinking of an example of the workflow that I'm after in
response to Theodore Ts'o's message from yesterday. Stay tuned, I hope
it makes it clearer why I want it this way.

[snip]

> Instead, if I understand what you're actually trying to do, it could
> also be done as:
> 
>  1) Just add a new replaces <sha1> field to new commit objects
> 
>  2) Make git-rebase know how to write those, e.g. add two of those
>     pointing to A & B when it squashes them into AB.
> 
>  3) Write a history traversal mechanism similar to --full-history
>     that'll ignore any commits on branches that yield no changes, or
>     only those whose commits are referenced by this "replaces" field.
> 
> You'd then end up with:
> 
>  A) A way to "stash" these commits in the permanent history
> 
>  B) ... that wouldn't be visble in "git log" by default
> 
>  C) Would require no underlying changes to the commit model, i.e. it
>     would work with all past & future git clients, if they didn't know
>     about the "replaces" field they'd just show more verbose history.

I get this point. I don't underestimate how difficult making such a
change to the core model is. I know there are older clients which cannot
simply be updated. There are also alternate implementations (e.g. jgit)
that also need to be considered. This is the thing I worry about the
most. I think at the very least, this new feature will have to be an
opt-in feature for teams who can easily ensure a minimum version of git
will be used. Maybe the core.repositoryformatversion config or something
like that would have to play into it. There may also be some minimal
amount that could be backported to older clients to at least avoid
choking on new repos (I know this doesn't guarantee older clients will
be updated). Just throwing a few ideas out.

I want to be sure that the implications have been explored before giving
up and doing something external to git.

Carl
