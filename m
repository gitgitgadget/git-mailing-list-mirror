Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BEC8200B9
	for <e@80x24.org>; Sun,  6 May 2018 20:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeEFUvV (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 16:51:21 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33759 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbeEFUvU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 16:51:20 -0400
Received: by mail-qt0-f195.google.com with SMTP id e8-v6so28963716qth.0
        for <git@vger.kernel.org>; Sun, 06 May 2018 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TUUYvktwXvKq/AD+HjIcQtMvByzCjUxQ9xsANQbKODE=;
        b=E3nYJOOIpWUNOma7kmHhy0JHUDXo2T6ZhdsbUmlU01xJNel0FlVMR4Qrox7f6mLDne
         apYjvlEcl0kzN3HW0ADBem3SyLO7Frr2HwJJ8y4Jq4mtbNfaCdKhZB/C65Ptwno5SDV4
         PKUbHi819i6nL/RTSnwhgIODllIiqaS/UzixohT85gO3daa3fSSnupvH5yk4bRzY9iDi
         jEl/WfxsO41RxUbOqZ4f8th3uErdn3qVTQi3lTNrN3y1NEeWzPcfbEh2VM2+Bu5unO4C
         0ZBMg3MNpIF0Iji7yHrpz/XbNGY91gisVZp8n6g4GczIRf2/x4K93m/L8IU50QDx2WYw
         eoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TUUYvktwXvKq/AD+HjIcQtMvByzCjUxQ9xsANQbKODE=;
        b=k7SfnXRgzxDBDCgY92anMADytk3+g4o5jIO48aMCFIh8T45Oampq9WIsmG1Yh0xcIL
         aHTI3wRL4f+mL0+DqUPoNzaZQpfNlfF5qMv7m7W0h1DeUnF5i7TmCpxXMINFs/U/I4qs
         IoE62KA8EUFzLY8P0nOjdKRl+BtDQu6usL2O1wAUWVwMX1TJzCjhweDWN9p4dSbxARA5
         0WtMp5arA6sgHM+PvbPYdlCWI958zxKIO/GsiYgww2U5LVIF7l7iQeOeD043qoHc6NEr
         WD+sliIImbOnhoR3JCPA94nBViiZQI/7yl/RmlMSqRvSySXeX8PeZP/XKwox2egXTItF
         pGmA==
X-Gm-Message-State: ALQs6tCI/wE17K0vijmq0olJrjA1cHpQBrjVb/Hvy08a1zFZlDzvFUBy
        EBMrYwyP7GIQh0yF3ohbIqGCl5O6QglCwekHHHE=
X-Google-Smtp-Source: AB8JxZovG8nirjVK0gZXAOfEizRL1PJ+e/AmLSu3A+7kic3wXmb/lH7Z0P3eU0++k0BieDU37T6TVB9YOqsq6kJdMmE=
X-Received: by 2002:a0c:f3d0:: with SMTP id f16-v6mr31494143qvm.113.1525639879669;
 Sun, 06 May 2018 13:51:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Sun, 6 May 2018 13:51:19 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 May 2018 16:51:19 -0400
X-Google-Sender-Auth: gzYPW26bMezuwd0CpQsxPfZipSk
Message-ID: <CAPig+cS0pvdg78fGUu8m2xspDDMHxi=uAMCkbLuthy7R4p3fQw@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 6, 2018 at 8:21 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sun, 6 May 2018, Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> > On Sat, 5 May 2018, Jeff King wrote:
>> >> One minor point about the name: will it become annoying as a tab
>> >> completion conflict with git-branch?
>>
>> If tbdiff were "Thomas's branch diff", I would call this jbdiff ;-)
>> but I think the 't' in there stands for "topic", not "Thomas's".
>> How about "git topic-diff"?
>
> Or `git topic-branch-diff`?
>
> But then, we do not really use the term `topic branch` a lot in Git, *and*
> the operation in question is not really about showing differences between
> topic branches, but between revisions of topic branches.
>
> So far, the solution I like best is to use `git branch --diff <...>`,
> which also neatly side-steps the problem of cluttering the top-level
> command list (because tab completion).

Let's, please, not fall into the trap of polluting git-branch with
utterly unrelated functionality, as has happened a few times with
other Git commands. Let's especially not do so merely for the sake of
tab-completion. git-branch is for branch management; it's not for
diff'ing.

Of the suggestions thus far, Junio's git-topic-diff seems the least
worse, and doesn't suffer from tab-completion problems.

Building on Duy's suggestion: git-interdiff could be a superset of the
current git-branch-diff:

    # standard interdiff
    git interdiff womp-v1 womp-v2
    # 'tbdiff'-like output
    git interdiff --topic womp-v1 womp-v2

(Substitute "--topic" by any other better name.)
