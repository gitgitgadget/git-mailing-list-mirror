Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48F0920A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeLJS5l (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:57:41 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:46777 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJS5l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:57:41 -0500
Received: by mail-oi1-f174.google.com with SMTP id x202so9843142oif.13
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PoIj5168vcSFcAWEjQfoahesPqBdNXKdVQN9Ba/OHKA=;
        b=fcVO+qDJ3MAR6BxtyxJkqzgQbu8OZ6GtBWuEWR0pQEVOWyg0sn8JZBZc+pZdQSfsjD
         xz0aFSX8DKmVwg3Ims6PRbYumEmmDaJow66luYPUvDyicNocfFGrc4Ujpe+FM6nhkDqa
         Jg1aCM5QnYIoZuJ411c2le6zipvoBB3dCOxvdjRWZR+bHBhi2JPqpxLey1noU52BsTFf
         a5Dlr28UlNithUWRcl6zmYDFh9jQPc9NUYe2AxLJRaj8tFNNYoAO5qTr4vSQOKpfdj0K
         qy9aqMmSzAAlMaQLd5Ja7W/AbLeN4wf5vhSuI/L0XZlGyRNxLJ6pcvdlHvnvAkbsPWGE
         fk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PoIj5168vcSFcAWEjQfoahesPqBdNXKdVQN9Ba/OHKA=;
        b=KQJPCenIzBl50coDSnLOLd5rvsw4XiSq4HiU4zMfWa4FDxFKVYwsUZ9+PHeHr3yMv/
         o/olxGvngHlOSRndNUDd85SXlRM9bq7tclXm0Q/RwR6RQaFu+faWIQkMucpUHty8of/8
         UN4S52DiceM68jPhh5ZcFpC2nfL/H1t6hHkM6XHWlmCqC7etIlwU/rA927mkpfxolmjt
         R3T5WzZW9c638sK5ajW9XH+1Ebr/Na0xD6OQDLWkBfx1MyPhXPATY7D6p6cEMQXNIvAz
         SvxF2KAMxTLmTLXsS2r54grVk+jPHOB3KW1MseVrbTvxNu/B5n0b+baw18e79qYFMsP0
         aoZA==
X-Gm-Message-State: AA+aEWa0QYNwssTpTrmw3s90t/eHWum5wMQ/W0htP5jtvT6QGxCN1KZj
        KYb5taKF/hTq6aLqD9zTwGOTuo8rQ+bYBUMS9S2f
X-Google-Smtp-Source: AFSGD/Xktnr6MPsQok3Sjx20f0jA+3MqLowa5VKdOCfGJXyQLHWnLFNrGsmaCkmGDhuChU8M/q0C1r/v9dfDwsNyE+U=
X-Received: by 2002:aca:cc0d:: with SMTP id c13mr7985830oig.150.1544468260149;
 Mon, 10 Dec 2018 10:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20181206213315.64423-1-matvore@google.com> <xmqqo99v5vnc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo99v5vnc.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Mon, 10 Dec 2018 10:57:28 -0800
Message-ID: <CAMfpvhKh3xewUY-g9oVJq1o=G3w9EspoQUHc1edHUx3AD4OWfg@mail.gmail.com>
Subject: Re: [PATCH] terminology tweak: prune -> path limiting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrn@google.com>,
        matvore@comcast.net, dstolee@microsoft.com, pclouds@gmail.com,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 8, 2018 at 5:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matthew DeVore <matvore@google.com> writes:
>
> > In the codebase, "prune" is a highly overloaded term, and it caused me a
> > lot of trouble to figure out what it meant when it was used in the
> > context of path limiting. Stop using the word "prune" when we really
> > mean "path limiting."
>
> path limiting is also used for two purposes.  "pruning", which is to
> cull the side branches that do not contribute the changes made to
> the paths we are interested in, and showing only the changes to the
> paths that match pathspec.
Thank you for the clarification re: side branches.

>
> AFAIK, "prune" is also used to describe unreachable loose objects,
> but that use is fairly isolated and have little risk of being
> confusing too much.  Are there other uses to make you consider it
> "highly overloaded"?

This is what I found:

git prune - cull unreachable loose objects
git fetch --prune - remove remote-tracking refs that no longer exist
at source. Also note "--prune-tags" option
git notes prune - remove notes for non-existing/unreachable objects
git worktree prune - prunes "administrative" files
git prune-packed - removes loose objects that are also in pack files
git filter-branch --prune-empty - removes commits that become empty as
a result of rewriting.

It seems there are three general categories of the use of the term -
 - to remove things from a view (e.g. in path limiting)
 - to remove loose objects for efficiency (git prune, git prune-packed)
 - to remove other things for either efficiency or to reduce cognitive
overhead (git worktree prune, git fetch --prune)

... and each of these categories has 2+ subcategories.

When I tried to figure out what "prune" and "prune_data" ("data" is
quite vague, so these two fields read like "prune_1" and "prune_2")
referred to in "revision.h", I basically did "grep -rn prune" and
looked through the results, but there were too many uses of the term
"prune" to pinpoint its meaning. If I used an IDE I might have been
able to "find usages" of struct revs's prune field, and I probably
*should have* done that, but I didn't have an IDE prepared and I
figured it wasn't important. Then an hour or so later I realized I was
still being confused by this term, and set out to figuring out what it
actually meant.


>
> My gut feeling is that the result is not reducing "overloading" in a
> meaningful way, and this change is not worth the churn, but it
> depends on the answer to the above question.
>
> Thanks.
