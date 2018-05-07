Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849DD200B9
	for <e@80x24.org>; Mon,  7 May 2018 17:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeEGRHu (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 13:07:50 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33823 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbeEGRHt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 13:07:49 -0400
Received: by mail-ua0-f196.google.com with SMTP id f22so18832810uam.1
        for <git@vger.kernel.org>; Mon, 07 May 2018 10:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wEV+Tmwo32xuPmpcMdKJRdZlxNDOefemw5MXGSIujLU=;
        b=HuYSLShasBHm8wqnw029ROYmC84kN3NFRbLvld+vMwJKWC0RHT8R7iShhqBMsk1Gn0
         3GGIVGZCAjku7UjudrKmYMq4p0CwG2YEld85KX2+aUGK42IktyFrBOzVBbR+dhEQEl3X
         2og6JiYmD+HbNJaNraEIqlo1joniMLYXV/9OB8H06WZFSMmeiZC5Tc1Y/uylBu/6gm3i
         jtJZeI8oVEyCIRtiGYx5lGVUCGRvkuN6CtLh+Qm46iXovvDV4mxH2I4Mz1n5Bhy1HdAM
         P8eIJpFtONU6Vbb2XWYTFg2R+Y0bMxrT3/g63U+17YwlIWHX8JD3PbxypuV+RRCt4TZJ
         0GGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wEV+Tmwo32xuPmpcMdKJRdZlxNDOefemw5MXGSIujLU=;
        b=Gyk9cZz9JbflpNKXLhCHKnA6/040LBAt40kFbWKoxHEBuDHauULYmbN3WZlpcxC3nu
         gaTNkxjgjgg5dJWWtwzP7r66IeghNbJRtKTrQXuDgxgibfes43BJshyYIh1fxMI06Jdd
         zeyXOtQiaCFn/A8TCdirLuor8kfPzQkTPuMTVUFF34AOgtKG2NVRecUKRbPvufP07GCO
         ix2d0QXwfGvdfyV3ZXH0tzjS7oFVDgipr8vJqFHg5AxdCKyQOYl4/7HZr12d4PJyjqV0
         FfuS5gBfqsdYiNGgBvhIzJxWmT67sPPrEgPkusAVAWl7y7mUx4dj8IWrc6qao+n17KgJ
         +v4Q==
X-Gm-Message-State: ALQs6tCS8j5N8h3G3roFYWolcfb5ldhtR91DsMz5O6lZlq1TmWIpdOq3
        fL0zW/YKqc13p/amEXW77yoVfZ+DL6D09vPV6KU=
X-Google-Smtp-Source: AB8JxZp+Eckhy3ob8vYO7RQVVnjQaOwVVPaUOzBaOzmgjEB11AWSUJLR7Z0tRpssMuN6VhsKf9jrrRM/yMjqpVGOl9Y=
X-Received: by 10.176.83.38 with SMTP id x35mr32611753uax.29.1525712868644;
 Mon, 07 May 2018 10:07:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 7 May 2018 10:07:47 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805052141550.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de> <CABPp-BEEgeo=5hkaTe8LrOMONSv3VdPi_cP4ADMC69oG3htC1g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805052141550.77@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 7 May 2018 10:07:47 -0700
Message-ID: <CABPp-BFQ2y1-FuA1wwnvFefjTFxunM4qeFke6icc5vAPs7k8GQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Add `branch-diff`, a `tbdiff` lookalike
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Sat, May 5, 2018 at 1:03 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Elijah,
>
> On Fri, 4 May 2018, Elijah Newren wrote:
>
<snip>
>> - tbdiff aligned output columns better when there were more than 9
>> patches (I'll comment more on patch 09/18)
>
> I added a new patch to align the patch numbers specifically. I considered
> squashing it into 9/18, but decided against it: it will make it easier to
> read through the rationale when calling `git annotate` on those lines.

Awesome, thanks.

<snip>
>> Also, I don't have bash-completion for either tbdiff or branch-diff.
>> :-(  But I saw some discussion on the v1 patches about how this gets
>> handled...  :-)
>
> Oh? Does 18/18 not work for you?
> https://public-inbox.org/git/71698f11835311c103aae565a2a761d10f4676b9.1525448066.git.johannes.schindelin@gmx.de/


It looks like it does work, in part, there were just two issues:

1) I apparently wasn't using all the nice improvements from the
completion script in my locally built git, but was instead still using
the one associated with my system-installed (and much older) git.
(Oops, my bad.)


2) Your completion commands for branch-diff will only complete one
revision range, not two.  e.g.
    git branch-diff origin/master..my-topic@{2} origin/master..my-top<tab>
won't complete "my-topic" as I'd expect.


Elijah
