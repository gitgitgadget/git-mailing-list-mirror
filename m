Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 384D0207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 15:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1173297AbdDXPTZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 11:19:25 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36081 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1173292AbdDXPTT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 11:19:19 -0400
Received: by mail-it0-f51.google.com with SMTP id g66so64440566ite.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 08:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z4kf/hPSClqbxZqgGqK3qBdILMt8y97v7F3bA8eaI7g=;
        b=cxScmY4eF3hqmhDY/PHdMsz7LTEuZWmqUGmumk72ub/7lCdVWEc5wxG6qW9HjmENRM
         qIZpbQMprMdIFDQVe48RGxnoo9ceJA17LY9iBsOd7j6/Mhb6vXVlZbZm6RKw/GwtEp3n
         ThvnVSAIuI+L9UCryJ3kKY852HeAhz7gm9hGMnJkSNdZVl0zrLutt+CquZESJtmniqH6
         8s/Y9PW/gohIPxfpTo69nxqZiMsRnabUJB0DCu5P9ZT7HTPd2nI0UhLQYtSXwqfI4H3c
         a+gupusSpS4Oyj1Oc3zpc8Lto7ZkNhbzixN5oMYg7wWW4PTgoruhRWGT5Jxy9yNuwCYe
         sjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z4kf/hPSClqbxZqgGqK3qBdILMt8y97v7F3bA8eaI7g=;
        b=i/KXjxylPXjfe5bbEdb1+/EyEa0mXu4EEp8ePgS+NObPkqqPxkwuPgFXPy3Mbtxpm/
         P5lgR4kC928zoDUEcG/ycMz2BmSg1Jx58t6J9qyyTFmkovSIjr0eaSsl1AzQFVL7q81X
         NuL4+gQCpObjOtVTOy9aqYiBln3206aPuSwv/eKJMOPJw53sw6/8sCWk7COik4A6D7xl
         U6wYcqfOEvQaO93mowXXVEzFciWpjvIn00hqCrJG11hqmNj8YKnnyIusJ04oHrRLFCDh
         Yge5Ias3Pm28Zb2QiBF3PRoSohuOhwNeg4wVRtZeTCuF6h0rH21P2ZYzJv488Ys72+TY
         mDBg==
X-Gm-Message-State: AN3rC/4jzhAVhoBNmiyTXobzxt49rYWF5mtJbCz6o/DJBZAaV7G/tjEl
        bx3mtWXX4wi3Fzd16h2TSrT6KsPv1g==
X-Received: by 10.36.103.86 with SMTP id u83mr13506693itc.91.1493047158193;
 Mon, 24 Apr 2017 08:19:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Mon, 24 Apr 2017 08:18:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1704241609300.3480@virtualbox>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com> <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
 <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704211135430.3480@virtualbox>
 <xmqqfugy4pnx.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704241609300.3480@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 24 Apr 2017 17:18:57 +0200
Message-ID: <CACBZZX7AmzFw-jVC_hd1t+qjK5jD485XD8g6U72p4RLoRD_kJA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 4:19 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
>
> On Sun, 23 Apr 2017, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > Part of the reason is that you push out all of the branches in one go,
>> > typically at the very end of your work day. The idea of Continuous
>> > Integration is a little orthogonal to that style, suggesting to build
>> > & test whenever new changes come into the integration branch.
>> >
>> > As a consequence, my original setup was a little overloaded: the VM
>> > sat idle most of the time, and when you pushed, it was overloaded.
>>
>> I do not see pushing out all them in one go is making the problem worse
>> for you, though.
>
> Oh no, you don't see that? Then let me spell it out a little more
> clearly: when you push out four branches at the same time, the same
> Virtual Machine that hosts all of the build agents has to build each and
> everyone of them, then run the entire test suite.
>
> As I have pointed out at several occasions (but I was probably complaining
> too much about it, so you probably ignored it), the test suite uses shell
> scripting a lot, and as a consequence it is really, really slow on
> Windows. Meaning that even on a high-end VM, it typically takes 1.5 hours
> to run the test suite. That's without SVN tests.
>
> So now we have up to four build agents banging at the same CPU and RAM,
> competing for resources. Now it takes more like 2-3 hours to run the
> entire build & test.
>
> The situation usually gets a little worse, even: you sometimes push out
> several iterations of `pu` in relatively rapid succession, "rapid" being
> relative to the time taken by the builds.
>
> That means that there are sometimes four jobs still hogging the VM when
> the next request to build & test `pu` arrives, and sometimes there is
> another one queued before the first job finishes.
>
> Naturally, the last two jobs will have started barely before Travis
> decides that it waited long enough (3 hours) to call it quits.
>
> To answer your implied question: the situation would be much, much better
> if the branches with more time in-between.
>
> But as I said, I understand that it would be asking you way too much to
> change your process that seems to work well for you.

Is getting the results of these builds time-critical? If not perhaps
an acceptable solution would be to use a source repo that's
time-delayed, e.g. 24hrs behind on average from Junio's git.git, and
where commits are pushed in at some configurable trickle.

>> As of this writing, master..pu counts 60+ first-parent merges.
>> Instead of pushing out the final one at the end of the day, I could
>> push out after every merge.  Behind the scenes, because some topics
>> are extended or tweaked while I read the list discussion, the number
>> of merges I am doing during a day is about twice or more than that
>> before I reach the final version for the day.
>>
>> Many issues can be noticed locally even before the patches hit a
>> topic, before the topic gets merged to 'pu', or before the tentative
>> 'pu' is pushed out, and breakage at each of these points can be
>> locally corrected without bothering external test setups.  I've been
>> assuming that pushing out all in one go at the end will help
>> reducing the load at external test setups.
>
> Pushing out only four updates at the end of the day is probably better
> than pushing after every merge, for sure.
>
> Ciao,
> Dscho
