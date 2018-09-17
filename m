Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DE131F404
	for <e@80x24.org>; Mon, 17 Sep 2018 17:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeIQWvw (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 18:51:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43020 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIQWvv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 18:51:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id z27-v6so13568516edb.10
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 10:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GZfzJSEFvvqKApJ2x1adAl7NX2/eIw3VUR+eWVzimXs=;
        b=KXlPYXuKwgK+pYN6vMpd0ZWS7cgE2r0/BrNbVBeysau+okH/gQIaFrWTHWLsEJHdmp
         DTJ91iziQwo7KeRGYexgXVQuwg9tCsG+tS0j8dmN4Kvz3Ey1msjASkj79nHRq6ziCn+j
         +En2aKzFnFycFq395gy+x5VGabYzBPp6h2pbgLLxfX6pZoULGj0GeNwBfwaCPvo525So
         Xz0DCoJUPbqi4m6W9bBCVccIpvlzgR9392yUDn36l0YmsIlgZvYF8O4CP6mK4ViroaaP
         Rjh6ka+VbqSOVF/KFUe1WbmI4jQ8mblMobDcpXsy0NP6SLdpqPZDnf5XjjXyGL5CcD4E
         tg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=GZfzJSEFvvqKApJ2x1adAl7NX2/eIw3VUR+eWVzimXs=;
        b=gXIYY83rTucIEgdPkuaUMlooMzjtJ2XZYPU5DSV6L67HElOcaj2ejdJ4WHOy14P8sJ
         Wx/HlisBLNb1IQSM3aLmBHfb0WLtcfpteLrKWAmPsjLOwAjqEjNbyWtPvqZGTKhLNdHy
         YNJai7ZvUfyMDrQFNvgi1a2cYS5qcDd+b/rc1XYHJrisuOh+gqsqXMPudlQyqxQ221b7
         QZ89CFjo9C0Y+VDNg2Jhzjk0pxWofYSIWBHR+xQ/TcCXp0wRFhpRYJ8qURKItvpNIoUJ
         bUuLCb44+6QWaNsyol4usWarlnlEZJblykl1NzteIGHBG+HPTn+HEEbXrJeUY8RxKYDO
         M2Ew==
X-Gm-Message-State: APzg51BubGNq1i2GGE9Xr+k2LfNFWxskVAhQ1nDC0c5jIQUqS7r1INTO
        VMQO4zl12Wxg9BZ6T/PgqzRj7zlt55E=
X-Google-Smtp-Source: ANB0VdYcMczrj5CzGd7ZRFgy9rRrFbtvRGhawRnJLGolREHOqCPcq7tuwKSsiR9BpChjgNCQuG+4wg==
X-Received: by 2002:a50:a305:: with SMTP id 5-v6mr43827673edn.57.1537205011862;
        Mon, 17 Sep 2018 10:23:31 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id x44-v6sm6553785edd.1.2018.09.17.10.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 10:23:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Joey Hess <id@joeyh.name>
Cc:     Taylor Blau <me@ttaylorr.com>,
        John Austin <john@astrangergravity.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net, larsxschneider@gmail.com,
        pastelmobilesuit@github.com
Subject: Re: Git for games working group
References: <CA+AhR6fWpzL1ozt2H=y8TaQrgT-6dvkkK_K_P-pXniXT+xcMuQ@mail.gmail.com>
        <20180914190025.GJ55140@syl>
        <CA+AhR6fH4=VbuMPasbaH9u52Y=tgJJzhgxosPOb3819ivCVJOg@mail.gmail.com>
        <20180915164052.GA88932@syl> <878t41lcfi.fsf@evledraar.gmail.com>
        <20180917135525.GF71477@syl> <874leokw3p.fsf@evledraar.gmail.com>
        <20180917164705.GA28056@kitenet.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180917164705.GA28056@kitenet.net>
Date:   Mon, 17 Sep 2018 19:23:29 +0200
Message-ID: <8736u8kpgu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 17 2018, Joey Hess wrote:

> Ævar Arnfjörð Bjarmason wrote:
>> There's surely other aspects of that square peg of large file tracking
>> not fitting the round hole of file locking, the point of my write-up was
>> not that *that* solution is perfect, but there's prior art here that's
>> very easily adopted to distributed locking if someone wanted to scratch
>> that itch, since the notion of keeping a log of who has/hasn't gotten a
>> file is very similar to a log of who has/hasn't locked some file(s) in
>> the tree.
>
> Actually they are fundamentally very different. git-annex's tracking of
> locations of files is eventually consistent, which of course means that
> at any given point in time it may be currently inconsistent. That is
> fine for tracking locations of files, but not for locking.
>
> When git-annex needs to do an operation that relies on someone else's
> copy of a file actually being present, it uses real locking. That
> locking is not centralized, instead it relies on the connections between
> git repositories. That turns out to be sufficient for git-annex's own
> locking needs, but it would not be sufficient to avoid file edit
> conflict problems in eg a split brain situation.

Right, all of that's true. I forgot to explicitly say what I meant by
"locking" in this context. Clearly it's not suitable for something like
actual file locking (in the sense of flock() et al), but rather just
advisory locking in the loosest sense of the word, i.e. some git-ish way
of someone writing on the office whiteboard "unless you're Bob, don't
touch main.c today Tuesday Sep 17th, he's hacking on it".

So just a way to have some eventually consistent side channel to pass
such a message through git. Something similar to what git-annex does
with its "git-annex" branch would work for that, as long as everyone who
wanted get such messages ran some equivalent of "git annex sync" in a
timely manner (or checked the office whiteboard every day...).

Such a schema is never going to be 100% reliable even in centralized
source control systems, e.g. even with cvs/perforce you might pull the
latest changes, then go on a plane and edit the locked main.c. Then the
lock has "failed" in the sense of "the message didn't get there in time,
and two people who could have just picked different areas to work on
made conflicting edits".

As noted upthread this isn't my use-case, I just wanted to point the
git-annex method of distributing metadata as a bolt-on to git as
interesting prior art. If someone wants "truly distributed, but with
file locking like cvs/perforce" something like what git-annex is doing
would probably work for them.
