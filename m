Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC8881F576
	for <e@80x24.org>; Sun, 11 Feb 2018 10:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeBKKRG (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 05:17:06 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34507 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbeBKKRF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 05:17:05 -0500
Received: by mail-wm0-f52.google.com with SMTP id j21so4688995wmh.1
        for <git@vger.kernel.org>; Sun, 11 Feb 2018 02:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=68pJUp6MpZsqsl8m3vinhEsBn3BZE81iAYrx7v779eY=;
        b=GFSnOuRa6CBLVa68mfY/VLsfcNBXw60T+Ie+zxr5nyLtyBfWKcTBSjpOJ3iYt8sP5c
         LdDkyovzaymv7SYJMhTr3WqvLUk8ZjXjyFzSQoON68cTJbpzT2YVSGCo3NS5h8EVcaB1
         WD79UCpcclIfAZ55Y+0aiCYd9eiuUwMkkSpxaEplVD4GJtSjygEwcuYDu5PpdO816Eih
         bFhAClDfRSBOSDkAFjUZC+y/LizEVzsk9zischmmGTs6kt4uzAPbFUqZM2n58GV4E0Yk
         FHGfwKu8SrMtMtRrWtdcXQGovVVtck6fzGAipbqxFIet82BTSsHLRJ3yRC/RGXXeqjgj
         yY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=68pJUp6MpZsqsl8m3vinhEsBn3BZE81iAYrx7v779eY=;
        b=fQspz1NXTNEBl4xT8/x+C+f5oOoPhtebbOGy0h2SINHFQV53oqgpgmE4hhOEUwAWYK
         vwHQ8zO6gxW2zBphI+tA+Z3kwT7WcXtio1osEPgZj3avZqr66Lh8MZZpmsUwhmP4GRUI
         CrRMiRDUzQE08FIsTeLp3hH25w/IHAqGhpVYNgs8Os6Q+qjJebgdTCODp/w8Kz816uwk
         3/MgsQCHAVGMHcoPm0k3cTuoH0Hqy18Dyo/rBVHQkwsWTZTXG5rjbYNOr8Chg2EVyLzL
         lqOwHv5dcN3PZZNhhZo0F5pmWnkwj+3s8z6JzmYFPBrK+vosOTwXrObd2Y2FGa6Wi1nP
         DJxQ==
X-Gm-Message-State: APf1xPDx5eNINkur7Sr/XXZyaZ/Pi/hfoxayGYKeCBKvFnOpg0GiqH65
        5EZ9DXtyofgpTDcxjjPwDw2yTgd4bH3WuTDyn34=
X-Google-Smtp-Source: AH8x226CGKY+4Y3caJSsvmTaJO1vtmlmuS4sR5Zct0oDNwuzmhtAYMMCwRsynou++Y1znn/nQyDojAzbKwhz6CZQjmk=
X-Received: by 10.80.211.7 with SMTP id g7mr11678258edh.76.1518344224010; Sun,
 11 Feb 2018 02:17:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.149.220 with HTTP; Sun, 11 Feb 2018 02:16:43 -0800 (PST)
In-Reply-To: <ec5c7aa2-b36b-aca8-d82f-9d131ac83b41@kdbg.org>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
 <87k1vpqq85.fsf@javad.com> <nycvar.QRO.7.76.6.1802071818240.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87o9kyitf7.fsf@javad.com> <ec5c7aa2-b36b-aca8-d82f-9d131ac83b41@kdbg.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 11 Feb 2018 02:16:43 -0800
Message-ID: <CA+P7+xq3sQ78-iwrc-fNVT-Z7n3xi2mFUsFtPsnN61Xd+7Eahw@mail.gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 11:13 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 09.02.2018 um 07:11 schrieb Sergey Organov:
>>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>
>>> Let me explain the scenario which comes up plenty of times in my work
>>> with
>>> Git for Windows. We have a thicket of some 70 branches on top of
>>> git.git's
>>> latest release. These branches often include fixup! and squash! commits
>>> and even more complicated constructs that rebase cannot handle at all at
>>> the moment, such as reorder-before! and reorder-after! (for commits that
>>> really need to go into a different branch).
>>
>>
>> I sympathize, but a solution that breaks even in simple cases can't be
>> used reliably to solve more complex problems, sorry. Being so deep
>> into your problems, I think you maybe just aren't seeing forest for the
>> trees [1].
>
>
> Hold your horses! Dscho has a point here. --preserve-merges --first-parent
> works only as long as you don't tamper with the side branches. If you make
> changes in the side branches during the same rebase operation, this
> --first-parent mode would undo that change. (And, yes, its result would be
> called an "evil merge", and that scary name _should_ frighten you!)
>
> -- Hannes

This is the reason I agree with Johannes, in regards to why
recreate-merges approach is correct.

Yes, an ideal system would be one which correctly, automatically
re-creates the merge *as if* a human had re-merged the two newly
re-created side branches, and preserves any changes in the result of
the merge, such as cases we call "evil merges" which includes
necessary changes to resolve conflicts properly.

However, I would state that such a system, in order to cause the least
surprise to a user must be correct against arbitrary removal, reorder,
and addition of new commits on both the main and topic side branches
for which we are re-creating the merges.

This is problematic, because something like how --preserve-merges
--first-parent does not work under this case.

As a user of the tool, I may be biased because I already read and
understand how recreate-merges is expected to work, but it makes sense
to me that the re-creation of the merge merely re-does the merge and
any modfications in the original would have to be carried over.

I don't know what process we could use to essentially move the changes
from the original merge into the new copy. What ever solution we have
would need to have a coherent user interface and be presentable in
some manner.

One way to think about the contents we're wanting to keep, rather than
the full tree result of the merge which we had before, what we
actually want to keep in some sense is the resulting "diff" as shown
by something like the condensed --combined output. This is obviously
not really a diff that we can apply.

And even if we could apply it, since the merge is occurring, we can't
exactly use 3-way merge conflict in order to actually apply the old
changes into the new merged setup? Could something like rerere logic
work here to track what was done and then re-apply it to the new merge
we create? And once we apply it, we need to be able to handle any
conflicts that occur because of deleting, adding, or re-ordering
commits on the branches we're merging... so in some sense we could
have "conflicts of conflicts" which is a scenario that I don't yet
have a good handle on how this would be presented to the user.

Thanks,
Jake
