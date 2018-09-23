Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 926161F453
	for <e@80x24.org>; Sun, 23 Sep 2018 17:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeIWX1V convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 23 Sep 2018 19:27:21 -0400
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21830 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeIWX1V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 19:27:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1537723746; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=RLwWbbfY0B0/1e8vM7qDlLKdsW4aKXz8gAalby4cE6ttqwAW22fniUjTuriy6q7Wpf60wJznq4URX5yQmuvjf1sL9jvGSOND/ixVpJx3n5OpyrL3RxUHDC08pFN5tf4ImH2Q/6N3qnpUxlCOPoGWSeXiB3J4BXUOhxuefpIq414=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1537723746; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=mZF+HhpUP1a9BYZSVS0o7Lx+CtuXCPbP89RJ7wXZlKQ=; 
        b=X9MK7PnXfyGmM+MJvPRUU1CbMbAoL4cbK90ZArbaFIRxYNFbTmtbClew3Fv8yyPlCULDbX6OOsWbz4y1bAmjwRY1OmWBpOP4Oqwa+mBwmrZlpnne+3eYI4Z9v/Ar6vPgLJor7au6Q8fxQrieicGg9JFnvA8sCLujLyBmAtVYupg=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=astrangergravity.com;
        spf=pass  smtp.mailfrom=john@astrangergravity.com;
        dmarc=pass header.from=<john@astrangergravity.com> header.from=<john@astrangergravity.com>
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172]) by mx.zohomail.com
        with SMTPS id 1537723746111460.7994759857213; Sun, 23 Sep 2018 10:29:06 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id y17-v6so16190295ljy.8
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 10:29:05 -0700 (PDT)
X-Gm-Message-State: APzg51DzhdB8XkIADrK0CL0jJiauYLHoUDxykDrKf3joAntaYZ9IV6cD
        GlIqOxine7YIizHKVfHcfpwTmUMn34Pmi+Yzlrg=
X-Google-Smtp-Source: ACcGV61gYKuIBjKTMQgsJcIrVayT3+K2YFHu4VN+Mtd05+OdQ10omXTqUZEXFomZBFXl2yeJqSP0W0f8zNW1+oT5pzE=
X-Received: by 2002:a2e:54b:: with SMTP id 72-v6mr8798142ljf.152.1537723744314;
 Sun, 23 Sep 2018 10:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
 <20180914190025.GJ55140@syl> <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
 <20180915164052.GA88932@syl> <878t41lcfi.fsf@evledraar.gmail.com>
 <20180917135525.GF71477@syl> <874leokw3p.fsf@evledraar.gmail.com>
 <20180917164705.GA28056@kitenet.net> <8736u8kpgu.fsf@evledraar.gmail.com>
In-Reply-To: <8736u8kpgu.fsf@evledraar.gmail.com>
From:   John Austin <john@astrangergravity.com>
Date:   Sun, 23 Sep 2018 10:28:36 -0700
X-Gmail-Original-Message-ID: <CA+AhR6doYuwoucdcN9aKw7-HxgR-qa6OiN4Dnzcy5rifL8PYvg@mail.gmail.com>
Message-ID: <CA+AhR6doYuwoucdcN9aKw7-HxgR-qa6OiN4Dnzcy5rifL8PYvg@mail.gmail.com>
Subject: Re: Git for games working group
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     id@joeyh.name, Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        pastelmobilesuit@github.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been putting together a prototype file-locking implementation for
a system that plays better with git. What are everyone's thoughts on
something like the following? I'm tentatively labeling this system
git-sync or sync-server. There are two pieces:

1. A centralized repository called the Global Graph that contains the
union git commit graph for local developer repos. When Developer A
makes a local commit on branch 'feature', git-sync will automatically
push that new commit up to the global server, under a name-spaced
branch: 'developera_repoabcdef/feature'. This can be done silently as
a force push, and shouldn't ever interrupt the developer's workflow.
Simple http queries can be made to the Global Graph, such as "Which
commits descend from commit abcdefgh?"

2. A client-side tool that queries the Global Graph to determine when
your current changes are in conflict with another developer. It might
ask "Are there any commits I don't have locally that modify
lockable_file.bin?". This could either be on pre-commit, or for more
security, be part of a read-only marking system ala Git LFS. There
wouldn't be any "lock" per say, rather, the client could refuse to
modify a file if it found other commits for that file in the global
graph.

The key here is the separation of concerns. The Global Graph is fairly
dimwitted -- it doesn't know anything about file locking. But it
provides a layer of information from which we can implement file
locking on the client side (or perhaps other interesting systems).

Thoughts?
On Mon, Sep 17, 2018 at 10:23 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Sep 17 2018, Joey Hess wrote:
>
> > Ævar Arnfjörð Bjarmason wrote:
> >> There's surely other aspects of that square peg of large file tracking
> >> not fitting the round hole of file locking, the point of my write-up was
> >> not that *that* solution is perfect, but there's prior art here that's
> >> very easily adopted to distributed locking if someone wanted to scratch
> >> that itch, since the notion of keeping a log of who has/hasn't gotten a
> >> file is very similar to a log of who has/hasn't locked some file(s) in
> >> the tree.
> >
> > Actually they are fundamentally very different. git-annex's tracking of
> > locations of files is eventually consistent, which of course means that
> > at any given point in time it may be currently inconsistent. That is
> > fine for tracking locations of files, but not for locking.
> >
> > When git-annex needs to do an operation that relies on someone else's
> > copy of a file actually being present, it uses real locking. That
> > locking is not centralized, instead it relies on the connections between
> > git repositories. That turns out to be sufficient for git-annex's own
> > locking needs, but it would not be sufficient to avoid file edit
> > conflict problems in eg a split brain situation.
>
> Right, all of that's true. I forgot to explicitly say what I meant by
> "locking" in this context. Clearly it's not suitable for something like
> actual file locking (in the sense of flock() et al), but rather just
> advisory locking in the loosest sense of the word, i.e. some git-ish way
> of someone writing on the office whiteboard "unless you're Bob, don't
> touch main.c today Tuesday Sep 17th, he's hacking on it".
>
> So just a way to have some eventually consistent side channel to pass
> such a message through git. Something similar to what git-annex does
> with its "git-annex" branch would work for that, as long as everyone who
> wanted get such messages ran some equivalent of "git annex sync" in a
> timely manner (or checked the office whiteboard every day...).
>
> Such a schema is never going to be 100% reliable even in centralized
> source control systems, e.g. even with cvs/perforce you might pull the
> latest changes, then go on a plane and edit the locked main.c. Then the
> lock has "failed" in the sense of "the message didn't get there in time,
> and two people who could have just picked different areas to work on
> made conflicting edits".
>
> As noted upthread this isn't my use-case, I just wanted to point the
> git-annex method of distributing metadata as a bolt-on to git as
> interesting prior art. If someone wants "truly distributed, but with
> file locking like cvs/perforce" something like what git-annex is doing
> would probably work for them.
>

