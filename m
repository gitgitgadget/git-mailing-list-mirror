Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53517200B9
	for <e@80x24.org>; Thu,  3 May 2018 21:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeECVvQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 17:51:16 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34911 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbeECVvP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 17:51:15 -0400
Received: by mail-wm0-f44.google.com with SMTP id o78-v6so1423751wmg.0
        for <git@vger.kernel.org>; Thu, 03 May 2018 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+nmpjJH91rlFAXTwhh5SXXUFLvVbE/eCN08an6VkIB4=;
        b=RFKqW6TdWraHHFIrqGahgw5SMlcV/ty8xv2Cc82QjmJ75QjqxI9o3XtsxfhvQ2Pn3k
         Hvkwy61F7TFEIngLLsUpfUjK3dq8vW6SoRjlDRMhLjax/szSkIycxjVsJzL1zCMMSbSp
         nABK6UhX9um5YgI8OG3+0sR3FqNSTsPo1vGsNCIU2sDbYohBd24qrPckPdv3a7+53XV3
         WT6u1copRQVVDQNqOTomu7oTpG9gcSd5y9b2I03txs/1giVYMy08V82VCbSCOz0u8/5t
         m9GYT/RA9JiTCSx/CwS14v7Dwx/LWXni12rGN1d8AfZXoeIR/ngOd9MyTstZSxWPsgy1
         taqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+nmpjJH91rlFAXTwhh5SXXUFLvVbE/eCN08an6VkIB4=;
        b=r8kthMy21JOIrq4gdirAQjlyeecJixyUBfJ9vXS1ai9Z6IOVeQfPRtVcvItS/QTmr/
         kicxGGNLvfrB4qCHAIoCVzbYRmf9ZAPXZvRsgK0kenn6AvOmBWbcSxMo9Wifyzht3jWd
         qTQy8gtD4+XvHFC7n35dnlYWa0Ql5v2E/LlMbxutDEDiM23fgNRwAJxVc3iQ3aud+avr
         kjUbaEa2Oyr4tX6chZd3lHaNMFpMzPDddltKAN45LbHvnrgGolv2geDLJKzjEHv/rJED
         Pmx82wigfj/LWAJEEbr+FMWL/SnRIzi2e7YCq2DoXoO+IYpnZu+SOE+WQ97wIhcAdBrp
         WMaw==
X-Gm-Message-State: ALQs6tBbPtgLrzYWVwVEOCfow0R+lfSR+E5agXR7FCWsnx5KUQn+7rYb
        to/HX2Tay8YV/1lpBGC+h7uO5/202iXPsvPqu/0=
X-Google-Smtp-Source: AB8JxZov8vBbscBevA2Iq3Vsii2hO0ATRB+7VxiQTuZ928J0/CY7Ml0IcS9uufbUXi8LXNZf5tIUVSrECBJ0hi4M6fg=
X-Received: by 2002:a50:cd45:: with SMTP id d5-v6mr32271534edj.118.1525384274455;
 Thu, 03 May 2018 14:51:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.234.135 with HTTP; Thu, 3 May 2018 14:50:54 -0700 (PDT)
In-Reply-To: <87po2cy5qd.fsf@evledraar.gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <87po2cy5qd.fsf@evledraar.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 3 May 2018 14:50:54 -0700
Message-ID: <CA+P7+xrHeAtYjOCNd28t3Kv7G0hsvdVm+dwyVWuGx=XjS3nskQ@mail.gmail.com>
Subject: Re: [PATCH 00/18] Add `branch-diff`, a `tbdiff` lookalike
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 11:05 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, May 03 2018, Johannes Schindelin wrote:
>
>> The incredibly useful `git-tbdiff` tool to compare patch series (say, to=
 see
>> what changed between two iterations sent to the Git mailing list) is sli=
ghtly
>> less useful for this developer due to the fact that it requires the `hun=
garian`
>> and `numpy` Python packages which are for some reason really hard to bui=
ld in
>> MSYS2. So hard that I even had to give up, because it was simply easier =
to
>> reimplement the whole shebang as a builtin command.
>>
>> The project at https://github.com/trast/tbdiff seems to be dormant, anyw=
ay.
>> Funny (and true) story: I looked at the open Pull Requests to see how ac=
tive
>> that project is, only to find to my surprise that I had submitted one in=
 August
>> 2015, and that it was still unanswered let alone merged.
>
> I've been using branch-diff and haven't found issues with it yet, it
> works like tbdiff but better. Faster, uses the same diff as git
> (better), and spews to the pager by default.

I'm hoping to take a look at this as well, I remember looking into
tbdiff in the past, but also had trouble getting it to work. I've
tried a variety of similar things, including 4-way parent diffs, but
nothing quite gave the results I expected.

Thanks!

Regards,
Jake
