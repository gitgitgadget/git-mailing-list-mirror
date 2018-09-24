Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1D531F453
	for <e@80x24.org>; Mon, 24 Sep 2018 15:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbeIXViD (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 17:38:03 -0400
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21777 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbeIXViC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 17:38:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1537803316; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=oqAMW4NbIP9grGW/i5cYFZgv/moxBbY4Q6Nh0mxyu0YNPjZsL2+ipPc+bH4Cz6/hOA6VyMgPmGhdVq2hAAicqjAj6iEN0dICmHgC9rK7ab4JZyxmrDbliG8KQXU4rpWYCKkMQ+l5Q3OvVVPABreBA2r/+cYohapToUqAbC4SDE8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1537803316; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=62bmD3UQ0SosBvQ8UZdezT5kVx8feuqeDeoM2O1QSm4=; 
        b=PkO3v/ah5cnqIwV6NKQv9Eo0vYKUvPCmFgdsS6GaPbH5WCc6smHcwUxxzH3gZhLu4PoKVvnnh/XGT8PPW00qg87LoxjbmNuibwUhBlCZITSPxwZKvgV1Hto8w4QLzd9Lg0aIcOEQvVFz9pQlMssGVQScnwmpRcM/AaL3/0jtZQM=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=astrangergravity.com;
        spf=pass  smtp.mailfrom=john@astrangergravity.com;
        dmarc=pass header.from=<john@astrangergravity.com> header.from=<john@astrangergravity.com>
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49]) by mx.zohomail.com
        with SMTPS id 1537803314418616.2770394498325; Mon, 24 Sep 2018 08:35:14 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id r191-v6so4578546lff.2
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 08:35:13 -0700 (PDT)
X-Gm-Message-State: APzg51BMRH0m4YsLKQetZiQfhEYvpq1xv0M0vh4Ij91VMARbF2yBpfJj
        D2I7EYzb34GRdGjzjtkOpPBD8uINAYxaWZJp5pU=
X-Google-Smtp-Source: ANB0VdZmx5NfF6P/rqjGZQRYCuHgHqocFsRvrTa6AASkE9OesUFx2AztHJNR7wIyNRvb+V/AqcPn2amdKzVGHQRgISY=
X-Received: by 2002:a19:124b:: with SMTP id h72-v6mr6523922lfi.72.1537803312597;
 Mon, 24 Sep 2018 08:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
 <20180915164052.GA88932@syl> <878t41lcfi.fsf@evledraar.gmail.com>
 <20180917135525.GF71477@syl> <874leokw3p.fsf@evledraar.gmail.com>
 <20180917164705.GA28056@kitenet.net> <8736u8kpgu.fsf@evledraar.gmail.com>
 <CA+AhR6doYuwoucdcN9aKw7-HxgR-qa6OiN4Dnzcy5rifL8PYvg@mail.gmail.com>
 <000501d45366$cf437060$6dca5120$@nexbridge.com> <CA+AhR6c+D84sHhABRm4xf=5RWnpVEBXMXzdQxipYMS5bmkw9iQ@mail.gmail.com>
 <20180924140122.GC68796@syl>
In-Reply-To: <20180924140122.GC68796@syl>
From:   John Austin <john@astrangergravity.com>
Date:   Mon, 24 Sep 2018 08:34:44 -0700
X-Gmail-Original-Message-ID: <CA+AhR6cyNqPW7YvEdanv_vA=T2oLrUm2ZyMZjLLFtdx8B+dqYQ@mail.gmail.com>
Message-ID: <CA+AhR6cyNqPW7YvEdanv_vA=T2oLrUm2ZyMZjLLFtdx8B+dqYQ@mail.gmail.com>
Subject: Re: Git for games working group
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Randall Becker <rsbecker@nexbridge.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        id@joeyh.name, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        pastelmobilesuit@github.com
Content-Type: text/plain; charset="UTF-8"
X-ZohoMailClient: External
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perhaps git-global-graph is a decent name. GGG? G3? :). The structure
right now in my head looks a bit like:

Global Graph:
     client - post-commit git hooks to push changes up to the GG
     git server - just the standard git server configuration
     query server - replies with information about the current state of the GG

Locks Pre-Commit:
     client - pre-commit hook that makes requests to the GG query server

For cross-platform compatibility, the Global Graph client and the
Locks/Conflicts client are the pieces that need to be use-able on all
platforms. My goal is to keep these pieces as simple as possible. I'd
like to at least start prototyping these in Rust, hopefully in a way
that can either be easily ported or easily re-implemented in C later
on, once things are feature-frozen.

For LFS, The main points of integration with I see are:
    -- bundling of packages (optionally install this package with a
normal LFS installation)
    -- `git lfs locks` integration. ie. integration with the read-only
control of LFS

If we push more of the functionality into the gg query server, the
integration with `lfs locks` could be simple enough to be a couple of
web requests. That might help avoid integration issues.

> we strictly avoid using CGo
What's the main reason for this? Build system complexity?
On Mon, Sep 24, 2018 at 7:37 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Sun, Sep 23, 2018 at 12:53:58PM -0700, John Austin wrote:
> > On Sun, Sep 23, 2018 at 10:57 AM Randall S. Becker
> > <rsbecker@nexbridge.com> wrote:
> > >  I would even like to help with your effort and have non-unixy platforms I'd like to do this on.
> > > Having this separate from git LFS is an even better idea IMO, and I would suggest implementing this using the same set of build tools that git uses so that it is broadly portable, unlike git LFS. Glad to help there too.
> >
> > Great to hear -- once the code is in a bit better shape I can open it
> > up on github. Cross platform is definitely one of my focuses. I'm
> > currently implementing in Rust because it targets the same space as C
> > and has great, near trivial, cross-platform support. What sorts of
> > platforms are you interested in? Windows is my first target because
> > that's where many game developers live.
>
> This would likely mean that Git LFS will have to reimplement it, since
> we strictly avoid using CGo (Go's mechanism to issue function calls to
> other languages).
>
> The upshot is that it likely shouldn't be too much effort for anybody,
> and the open-source community would get a Go implementation of the API,
> too.
>
> Thanks,
> Taylor
>

