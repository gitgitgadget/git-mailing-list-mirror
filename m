Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5010E1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 21:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeARVWN (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 16:22:13 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36259 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752840AbeARVWL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 16:22:11 -0500
Received: by mail-wm0-f68.google.com with SMTP id f3so25789395wmc.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 13:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o0j7yfVv8XRh6c/S3EB5m5e9qB0iKA8l4dIrivv+aYw=;
        b=HWcHmvyDqyU25n715ql9AIqniG0PYHOgbvHF8IpshWOYeLXvOS9X88PRqeF9SOljtE
         /FzSQ3f9Hg5pkk9qs3FiI6rUmovf89QJGeTxVKge1cbTOUEkO02RUpHHhGyAOkqJTd8T
         hs5PkpoXmtCW3ko4KI45SKuyBzsQiH2lbQjnA0XhHG8OI7YPhmbPfonx0JWIfU9+6G8i
         3v4zkAy4K56qSxAZXQBawPo6Zq0puLQynrihC0Lhz5CjTIWXUteAnwHRqtUZ22yBD+ut
         KHZBCFH2HeJLmdoSogRhDDPlfSoVMMHT5fsslFB2sd726Hy1Ni64giXcjg/eB6cRth1p
         6ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o0j7yfVv8XRh6c/S3EB5m5e9qB0iKA8l4dIrivv+aYw=;
        b=rGOa2tx6Ewe7kCYG3C6Bao4vFMBZXkWxOL5h2UNmqInBnjGTJ8dq8U37BJzJrgCH1B
         DUAYwo81PwR6E8qAm/OK6CebWJQoZlCsXbwXPZNvn+Xgd0M5sjpuvUcL4TU6pLwcrLQN
         xfNpAS2gNEqp8ALbbGS5lajqsYM9/hNvIw+bwvmiNB2H7dmRP++ezGU6Fvs7gk7LcKrQ
         976eQVoqeUytfqZCFwciCl5EYHyt99kT2jk2CzxXztT3I9fy9JHdyx+p+KnE/81NhYoN
         gVKsA77az9ry84HbBjzBWRJPVZ82Afq36rtREQIaN0YYNe+Xj8DSb/NvMH7dVoMOBqJH
         pq8g==
X-Gm-Message-State: AKwxytdGOfKvXn5Fepv4d0mrZDMYG0CvB2KDpkR1cbHWtcJCjdhG3Lm8
        6w/5GVFW4L9S1vVzsch8nyINJHmGSweacRiP3tJIPg==
X-Google-Smtp-Source: ACJfBovJQ5fEyakJTD0d2aaFCVFUm+ITNrxrpqIv6yiUMcTEMB4g6smzlKdaNaj2LizcYuikfAolCT+cXTm56e7Z2Ec=
X-Received: by 10.80.164.233 with SMTP id x38mr9748093edb.293.1516310530212;
 Thu, 18 Jan 2018 13:22:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.212.44 with HTTP; Thu, 18 Jan 2018 13:21:49 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801182212210.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de>
 <CA+P7+xozcQD2xuys6mh8MsfcYZ_nb2c9yxhDxkc7FTN2SfoofQ@mail.gmail.com> <nycvar.QRO.7.76.6.1801182212210.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Jan 2018 13:21:49 -0800
Message-ID: <CA+P7+xo096LyacgFM3kLMHovXT3sWsf_m9AB7oENREZ7TfWa9Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to reset the revision
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 1:13 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Jake,
>
> On Thu, 18 Jan 2018, Jacob Keller wrote:
>
>> On Thu, Jan 18, 2018 at 7:35 AM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>> > This commit implements the commands to label, and to reset to, given
>> > revisions. The syntax is:
>> >
>> >         label <name>
>> >         reset <name>
>> >
>> > As a convenience shortcut, also to improve readability of the generated
>> > todo list, a third command is introduced: bud. It simply resets to the
>> > "onto" revision, i.e. the commit onto which we currently rebase.
>> >
>>
>> The code looks good, but I'm a little wary of adding bud which
>> hard-codes a specific label. I suppose it does grant a bit of
>> readability to the resulting script... ? It doesn't seem that
>> important compared to use using "reset onto"? At least when
>> documenting this it should be made clear that the "onto" label is
>> special.
>
> Indeed, `bud` helped me more in the earlier times of the Git garden shears
> when I had to *introduce* branch structure into the long list of Git for
> Windows' patches.
>
> If there are no voices in favor of `bud` other than mine, I will remove
> support for it in the next iteration.
>
> Ciao,
> Dscho

After I saw more examples, I don't mind it. I do think it's not
strictly necessary, but it seemed to help me with the readability. My
only main concern is that it's limited to a special label.

Thanks,
Jake
