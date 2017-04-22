Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56FB41FE90
	for <e@80x24.org>; Sat, 22 Apr 2017 17:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1043990AbdDVRcE (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 13:32:04 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35858 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1043986AbdDVRcC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2017 13:32:02 -0400
Received: by mail-qk0-f182.google.com with SMTP id d80so27685700qke.3
        for <git@vger.kernel.org>; Sat, 22 Apr 2017 10:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XYb98HU52RYO415/xHHOi2RBmNL7YnMieBil2PXdxSQ=;
        b=nKASyVMm3j8lWK4vhVdPCgcctMKp+zLkazVGw/6QljkfOFeBdJ9yDT0PcU6DvcXP7Z
         ueYuzuXUNQXm2phekHk7GPY9t7gZwfWf8CuUQ3G7Z9ZA/yKSl5Ye8meWZ91M2vrXpV4n
         TllWn2d2Wzp8suXO8ugMdIlTLtX8C8/ImwfOF/+YlGLjr0oTPUF1i+icMHG9LrO+Ghmv
         kdj7HtAzUwCiGR2PG/hDQL1JkJKbsHvvN09Yw/4bAtULGJcnfszfmVxqnI6pC+Gu7vz3
         bXbwoH8xnNqJCjFPKPvGb1hc+2yX04Isjg5yDEO8peOTnQImfwIaA4tf9By+164d6fSB
         CI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XYb98HU52RYO415/xHHOi2RBmNL7YnMieBil2PXdxSQ=;
        b=kigb7DzFJjBP1zJnxHjKfU+rpAbFnnnzN2PFmYmUQ8amalZKW42AbcvKjWZZ8v416M
         vxu0KLoS1v5agnDRQ4f7qbMUVHy4CAc3uVt0cDJYaLr0NJ4JxWQR0PMcDrZTbWM6UcmU
         0se/6L1h0/beaFvJd4fWO8hywUVQKbOV1S44sED3xlUXvJPybsE3xcDNA++8N8iAN7On
         7mpi/W2Ql/SjgS1rgcw4Qxyu/feBD5UTXzBKRRLO8E2kR0quqZuz3izjNcVnBEmlFLg1
         79XT7KBm8eRPU0qDqH++Av5dfqP++kwaLrBhzT/TUFpiQ4fzu/RaJ9M53vuQz5QKTJk4
         chQQ==
X-Gm-Message-State: AN3rC/5tWMLvgv9wcgWkSI7Q7urdBEynNPJhuGjqv7JJiz7oHnwRH0bb
        X4xU0I0bTLvjLhAM2LHlEBpvgNdsng==
X-Received: by 10.55.110.70 with SMTP id j67mr17387560qkc.145.1492882321408;
 Sat, 22 Apr 2017 10:32:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.96.65 with HTTP; Sat, 22 Apr 2017 10:32:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1704221319580.3480@virtualbox>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com> <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
 <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704211135430.3480@virtualbox>
 <CAP8UFD19DVqQLHBta74uLcFPwJaRUKF8Ppmnhct5ub=OkKSqCQ@mail.gmail.com> <alpine.DEB.2.20.1704221319580.3480@virtualbox>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 22 Apr 2017 19:32:00 +0200
Message-ID: <CAP8UFD3QJ5irxNZqn__CqXPgi+uY4vhZ2HyrNu9RhScbRU0LOA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Sat, Apr 22, 2017 at 1:48 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>>
>> First bisect should ask you to test merge bases only if there are
>> "good" commits that are not ancestors of the "bad" commit.
>
> Please note that this is a stateless job. The only "state" I have is the
> branch name.
>
> So when something goes wrong, I have *no* indicator what is a known good
> state.

Maybe we could consider the last release a known good state?

> The strategy I implemented was to use knowledge about the branches and
> their relations. So when there is a bug in `pu`, the script first tests
> whether the same test passes in `next`. And if it does, that is my
> known-good state.
>
> In the meantime, I cheat and mark all merge-bases as known-good, too. But
> that is by no means a correct assumption: sometimes Junio decides to base
> a patch on top of a really ancient commit, one that may be broken on
> Windows. So there you are, I cannot win, I just tried to implement
> something that works reasonably well, most of the time. It still takes way
> too long.
>
>> Second yeah there is probably an old bug in bisect there. In theory in
>> most cases bisect should ask you to test only one merge base, as:
>>
>> - if the merge base is "bad", it means that the bug has been fixed
>> between the merge base and your "good" commit, and bisecting will
>> stop,
>> - if the merge base is "good", it means that all the merge bases that
>> are ancestor of this merge base are also good, so there is no need to
>> test them
>
> That is not necessarily correct. If there are two merge bases, one may be
> broken, and then that one is the first bad commit.

I wrote "in most cases" above because I think that it is not usual for
git.git to have branches that start from a commit that is not among
the set given by `git rev-list --first-parent master`.

So "in most cases" all the merge bases are among the first parents of
master, which means that if bisect was smart enough to first test the
last of these merge bases and to discard the merge bases that are
among its ancestors, then bisect would not need to test the other
merge bases.

Even if there were a few merge bases that were not among the first
parents of master, the number of merge bases to test could be reduced
a lot.
