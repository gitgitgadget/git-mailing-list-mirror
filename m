Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428AC215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 14:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754018AbeD3OnC (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 10:43:02 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:46694 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbeD3OnC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 10:43:02 -0400
Received: by mail-oi0-f43.google.com with SMTP id y15-v6so7592560oia.13
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wl/Jnz++AB31XgZmXBrJAcnMHFZhpzuYQfBci0fEpwo=;
        b=AlkPNSN/vaVx4V7+6I/xrsqnWYpnrek2tWLfKoX/9WC7qeQj68SKaqcPXKl4j0rmQJ
         le1kwiRGOx9k2finUI+8UZRw6n1gJNgbqtNeoFuC3byrAoUPhimHHYam88ZIm65lqo1I
         9tQwPTOSgPXMzwbJYAb/dC5fzaUt9iFY7fdwKrDXW0fWvT+bDlcB/IxGMfZun4iHS3hm
         nYbHF9SX3cGV1529lM2Kf5Gv7xIExLqb0bWPvaycho5ZQ5qeICsuqTAwa75IZl5cCHoJ
         RDW+HuUL/gvjIcAkkC8zfE0f8Fzp4y9/2fLU+pQT6cCUi16v6KCWeqyYWvaOqnhKfc1u
         7B/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wl/Jnz++AB31XgZmXBrJAcnMHFZhpzuYQfBci0fEpwo=;
        b=fjFv9KlvgZ+YIAZUF+F9X0aS/nyLtw3i+t7gfjRl93N1bCTkWvC1UQpz8BRhapmG+p
         F+U4gyLmVOo658QvhIn0UJeUgU5JhT23tcjY91bbuvVlRGt34IC5PnA25NaHI2J7ztSW
         cIP7F3ePTAUKee+fhT2IZcsYBZzcOA29jNHwNSf/4aLkxBByYcGKVK+1YlqSsAQ+pYZK
         YflJYGOj01TrXDnFvS4VIoE9/Ey35/jkfSUj+sCq6SfsbxvnMLxCkr17kV73gzlMh3+0
         uYXW3sv4RXhEirN6VeAnlpHxPRkQ6KxuthrgnBtshrZgzqL+8dc0IfrvY8uovMNjuOXS
         Mh2Q==
X-Gm-Message-State: ALQs6tD1NJBMDmLES3rfhB9GAhGTtVchXpxoKMWYplTpkl+2By4XB7jS
        v3gLYaGxak556M9KJyRVcl4sB/s7wPX8txNE42XwGQ==
X-Google-Smtp-Source: AB8JxZoWMOP4Z18mGfqSrWfX6TOyz10PoTK1rxSC2pru1RzE3p+E0I2cEJjQXJ3ptE872aPwMnjFOiX+oaD9IY0FNDc=
X-Received: by 2002:aca:1904:: with SMTP id l4-v6mr7607908oii.216.1525099381670;
 Mon, 30 Apr 2018 07:43:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Mon, 30 Apr 2018 07:42:31 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804292251000.79@tvgsbejvaqbjf.bet>
References: <xmqq604h717y.fsf@gitster-ct.c.googlers.com> <20180424065045.13905-1-newren@gmail.com>
 <CACsJy8DyP_mXXJKn52Jzqe63N3GLpXePCr8ha97Lv9hr6u-M0w@mail.gmail.com> <nycvar.QRO.7.76.6.1804292251000.79@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 30 Apr 2018 16:42:31 +0200
Message-ID: <CACsJy8Cqq5c1QC=2EjfajS3=+ofAF8eoFG2V4QeY+LzSykJOFw@mail.gmail.com>
Subject: Re: [PATCH v3] unpack_trees: fix breakage when o->src_index != o->dst_index
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 29, 2018 at 10:53 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> > @@ -1412,12 +1422,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>> >                                                   WRITE_TREE_SILENT |
>> >                                                   WRITE_TREE_REPAIR);
>> >                 }
>> > -               move_index_extensions(&o->result, o->dst_index);
>> > +               move_index_extensions(&o->result, o->src_index);
>>
>> While this looks like the right thing to do on paper, I believe it's
>> actually broken for a specific case of untracked cache. In short,
>> please do not touch this line. I will send a patch to revert
>> edf3b90553 (unpack-trees: preserve index extensions - 2017-05-08),
>> which essentially deletes this line, with proper explanation and
>> perhaps a test if I could come up with one.
>>
>> When we update the index, we depend on the fact that all updates must
>> invalidate the right untracked cache correctly. In this unpack
>> operations, we start copying entries over from src to result. Since
>> 'result' (at least from the beginning) does not have an untracked
>> cache, it has nothing to invalidate when we copy entries over. By the
>> time we have done preparing 'result', what's recorded in src's (or
>> dst's for that matter) untracked cache may or may not apply to
>> 'result'  index anymore. This copying only leads to more problems when
>> untracked cache is used.
>
> Is there really no way to invalidate just individual entries?

Grr.... the short answer is the current code (i.e. without Elijah's
changes) works but in a twisted way. So you get to keep untracked
cache in the end.

I was right about the invalidation stuff. I knew about
invalidate_ce_path() in this file. What I didn't remember was this
function actually invalidates entries from the _source_ index, not the
result one. What kind of logic is that? You copy/move entries from
source to result than you go invalidate the source. Since the original
move_index_extensions() call moves extensions from the source, these
are already properly invalidated (both untracked cache and cache
tree), it it looks like it does the right thing. Two wrongs make a
right, I guess.

Sorry for venting. I was not happy with what I found. And sorry for
wasting your time making this move_index.. change then remove it.

> I have a couple of worktrees which are *huge*. And edf3b90553 really
> helped relieve the pain a bit when running `git status`. Now you say that
> even a `git checkout -b new-branch` would blow the untracked cache away
> again?
>
> It would be *really* nice if we could prevent that performance regression
> somehow.
>
> Ciao,
> Dscho



-- 
Duy
