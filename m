Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CAFA1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 13:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeDKNNW (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 09:13:22 -0400
Received: from mail.javad.com ([54.86.164.124]:44640 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752906AbeDKNNV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 09:13:21 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 8E1673EC38;
        Wed, 11 Apr 2018 13:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523452399;
        bh=CqhFZEf9ClO5sxSsmnQPg/dc7XZc46WdDYqVTg2WAj8=; l=3482;
        h=Received:From:To:Subject;
        b=PUBEmLjjZj7fggP3/Kys/GRoB52KWuh34MV4UXQPI4En0v79Zf0IX/w1ao6OuUbNe
         j0Xv/qTO/ANXPftUQ7JwHkNMDKKp/08ChPzLIczbOIP6rL7crFUSOBTvLIEjZhqZ3j
         GzdMGYloUKIxoBkZaqQAAOWVCpcq32vXn24O8eC8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523452399;
        bh=CqhFZEf9ClO5sxSsmnQPg/dc7XZc46WdDYqVTg2WAj8=; l=3482;
        h=Received:From:To:Subject;
        b=PUBEmLjjZj7fggP3/Kys/GRoB52KWuh34MV4UXQPI4En0v79Zf0IX/w1ao6OuUbNe
         j0Xv/qTO/ANXPftUQ7JwHkNMDKKp/08ChPzLIczbOIP6rL7crFUSOBTvLIEjZhqZ3j
         GzdMGYloUKIxoBkZaqQAAOWVCpcq32vXn24O8eC8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523452399;
        bh=CqhFZEf9ClO5sxSsmnQPg/dc7XZc46WdDYqVTg2WAj8=; l=3482;
        h=Received:From:To:Subject;
        b=PUBEmLjjZj7fggP3/Kys/GRoB52KWuh34MV4UXQPI4En0v79Zf0IX/w1ao6OuUbNe
         j0Xv/qTO/ANXPftUQ7JwHkNMDKKp/08ChPzLIczbOIP6rL7crFUSOBTvLIEjZhqZ3j
         GzdMGYloUKIxoBkZaqQAAOWVCpcq32vXn24O8eC8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523452399;
        bh=CqhFZEf9ClO5sxSsmnQPg/dc7XZc46WdDYqVTg2WAj8=; l=3482;
        h=Received:From:To:Subject;
        b=PUBEmLjjZj7fggP3/Kys/GRoB52KWuh34MV4UXQPI4En0v79Zf0IX/w1ao6OuUbNe
         j0Xv/qTO/ANXPftUQ7JwHkNMDKKp/08ChPzLIczbOIP6rL7crFUSOBTvLIEjZhqZ3j
         GzdMGYloUKIxoBkZaqQAAOWVCpcq32vXn24O8eC8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523452399;
        bh=CqhFZEf9ClO5sxSsmnQPg/dc7XZc46WdDYqVTg2WAj8=; l=3482;
        h=Received:From:To:Subject;
        b=PUBEmLjjZj7fggP3/Kys/GRoB52KWuh34MV4UXQPI4En0v79Zf0IX/w1ao6OuUbNe
         j0Xv/qTO/ANXPftUQ7JwHkNMDKKp/08ChPzLIczbOIP6rL7crFUSOBTvLIEjZhqZ3j
         GzdMGYloUKIxoBkZaqQAAOWVCpcq32vXn24O8eC8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523452399;
        bh=CqhFZEf9ClO5sxSsmnQPg/dc7XZc46WdDYqVTg2WAj8=; l=3482;
        h=Received:From:To:Subject;
        b=PUBEmLjjZj7fggP3/Kys/GRoB52KWuh34MV4UXQPI4En0v79Zf0IX/w1ao6OuUbNe
         j0Xv/qTO/ANXPftUQ7JwHkNMDKKp/08ChPzLIczbOIP6rL7crFUSOBTvLIEjZhqZ3j
         GzdMGYloUKIxoBkZaqQAAOWVCpcq32vXn24O8eC8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523452399;
        bh=CqhFZEf9ClO5sxSsmnQPg/dc7XZc46WdDYqVTg2WAj8=; l=3482;
        h=Received:From:To:Subject;
        b=PUBEmLjjZj7fggP3/Kys/GRoB52KWuh34MV4UXQPI4En0v79Zf0IX/w1ao6OuUbNe
         j0Xv/qTO/ANXPftUQ7JwHkNMDKKp/08ChPzLIczbOIP6rL7crFUSOBTvLIEjZhqZ3j
         GzdMGYloUKIxoBkZaqQAAOWVCpcq32vXn24O8eC8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523452399;
        bh=CqhFZEf9ClO5sxSsmnQPg/dc7XZc46WdDYqVTg2WAj8=; l=3482;
        h=Received:From:To:Subject;
        b=PUBEmLjjZj7fggP3/Kys/GRoB52KWuh34MV4UXQPI4En0v79Zf0IX/w1ao6OuUbNe
         j0Xv/qTO/ANXPftUQ7JwHkNMDKKp/08ChPzLIczbOIP6rL7crFUSOBTvLIEjZhqZ3j
         GzdMGYloUKIxoBkZaqQAAOWVCpcq32vXn24O8eC8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523452399;
        bh=CqhFZEf9ClO5sxSsmnQPg/dc7XZc46WdDYqVTg2WAj8=; l=3482;
        h=Received:From:To:Subject;
        b=PUBEmLjjZj7fggP3/Kys/GRoB52KWuh34MV4UXQPI4En0v79Zf0IX/w1ao6OuUbNe
         j0Xv/qTO/ANXPftUQ7JwHkNMDKKp/08ChPzLIczbOIP6rL7crFUSOBTvLIEjZhqZ3j
         GzdMGYloUKIxoBkZaqQAAOWVCpcq32vXn24O8eC8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523452399;
        bh=CqhFZEf9ClO5sxSsmnQPg/dc7XZc46WdDYqVTg2WAj8=; l=3482;
        h=Received:From:To:Subject;
        b=PUBEmLjjZj7fggP3/Kys/GRoB52KWuh34MV4UXQPI4En0v79Zf0IX/w1ao6OuUbNe
         j0Xv/qTO/ANXPftUQ7JwHkNMDKKp/08ChPzLIczbOIP6rL7crFUSOBTvLIEjZhqZ3j
         GzdMGYloUKIxoBkZaqQAAOWVCpcq32vXn24O8eC8=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f6FYr-0008RZ-Bu; Wed, 11 Apr 2018 16:13:17 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
        <cover.1523362469.git.johannes.schindelin@gmx.de>
        <87tvsj6rn2.fsf@javad.com>
        <nycvar.QRO.7.76.6.1804110009080.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <871sfm737e.fsf@javad.com>
        <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 11 Apr 2018 16:13:17 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1804111324350.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 11 Apr 2018 13:28:51 +0200
        (DST)")
Message-ID: <87h8oh51jm.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Sergey,
>
> On Wed, 11 Apr 2018, Sergey Organov wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > On Tue, 10 Apr 2018, Sergey Organov wrote:
>> >
>> >> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> >>
>> >> > Once upon a time, I dreamt of an interactive rebase that would not
>> >> > flatten branch structure, but instead recreate the commit topology
>> >> > faithfully.
>> >>
>> >> [...]
>> >>
>> >> > Think of --rebase-merges as "--preserve-merges done right".
>> >>
>> >> Both option names seem to miss the primary point of the mode of
>> >> operation that you've formulated in the first sentence. I suggest to
>> >> rather call the new option in accordance to your description, say,
>> >> --no-flatten, --keep-topology, or --preserve-shape.
>> >
>> > A very quick A/B test shows that neither --no-flatten nor --keep-topology
>> > and certainly not --preserve-shape conveys to Git users what those options
>> > are supposed to do.
>>
>> In fact, my preference would be --[no-]flatten, exactly because the
>> default mode of rebase operation flattens the history, and thus what I'm
>> talking about is:
>>
>> git rebase --no-flatten
>
> And this is the option out of the four that fared *worst* in the A/B
> testing. Not even experts in Git internals were able to figure out what
> the heck you are talking about.

It was you who introduced the "flatten" term, not me. I took it from
your descriptions.

So they are able to make sense of your own:

>>> Once upon a time, I dreamt of an interactive rebase that would not
>>> flatten branch structure, but instead recreate the commit topology
>>> faithfully.

Yet they can't get:

--no-flatten::
	Instead of flattening branch structure, recreate the commit
	topology faithfully

Are you kidding?

Well, suppose for a moment that nobody could even guess what "flatten"
means indeed. Then are you willing to remove the "flatten" from both the
description of our patch series and from the proposed patch to the Git
manual:

-r::
--rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
	Rebase merge commits instead of _flattening_ the history by replaying
	merges.

???

>
> Now, you can beat that dead horse until it is pulp. Your choice. I'd
> rather go on to more interesting things, because as far as I am concerned,
> the naming issue has been settled, with you being the only person in
> disfavor of --rebase-merges.

It was rather --recreate-merges just a few weeks ago, and I've seen
nobody actually commented either in favor or against the
--rebase-merges.

git rebase --rebase-merges

_is_ plain simple ugly.

>
> What you *could* do is finally take your RFC to the test. Run it with the
> concrete example I showed you in
> https://public-inbox.org/git/nycvar.QRO.7.76.6.1803261405170.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/
>
> It is high time that you demonstrated on this concrete case study how your
> proposed solution performs. And then tally that up with Phillip's
> strategy.

What you could do is to stop shifting the subject of discussion.

The RFC v2 and Phillip's strategy are essentially the same, as has been
already shown multiple times, both theoretically and by testing. Ask
Bugga for details.

One way or another, this doesn't make

git rebase --rebase-merges

even a bit less ugly.

-- Sergey
