Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 697EA20989
	for <e@80x24.org>; Mon, 10 Oct 2016 19:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbcJJTIb (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 15:08:31 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36820 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbcJJTIa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 15:08:30 -0400
Received: by mail-qk0-f181.google.com with SMTP id o68so127682978qkf.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=Q5PeJuSETtz9AHiUupLh6cCdNAyWvwR8XgAu6h7GHT0=;
        b=V2/NKiD1S0Fz9fOQPDnc0ZO8fNxfVbifS/sRt+yChWkDuagmF8a+CNOpTwyFxzTi3m
         8+uva2zsGXCSQNZ9sNA5qIA5yYK39uMYKXhLQUCOQobnkn8yhR5MxWR5pgXbEVfPc957
         YVdanfShqbOL0KAkeu3jyPHtuftq37a5imTVILlT/BVkoTQwPJ7NhFLFsTnuTPAer1UQ
         vIGJucGG8JbT1CvC1U94ERVWpbajDuYnq/xk8De1cYhC7PIvEo7FOqrlof0UaqpQ8Lu+
         693z1uDEbghrJEePpvd4BWQDTO2xOCY1ssDIO4WEr5FqMQotHyYhRsHNoumBQGBRlgDB
         lyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=Q5PeJuSETtz9AHiUupLh6cCdNAyWvwR8XgAu6h7GHT0=;
        b=NgtQMEcIqnlF5a8e8xWxdC8VbWA6ZPgjz+EZSOsW4YDlY/dBjhNCYOEUhNx4YLPdr7
         P2tXoeBSMDFuZaLpyBZ77n4kTv0WqngzcAQJe16tfFxQJlZ8pPsaR6/3pu2vHVTLhoRE
         iFzCZwdErRA6q/Pu+vd+TMsDw20oFfhJNbPS460//S8Si+JF/kB4bN1BjJJuK69BSDdh
         Nypt4YPwM603y0LR263jA8E9nDRxv9O4tDaaSlP9Y6LTYlDIVScaliaWzVQP/+mC05bA
         bsDl7lHt70xfZL7+1SMwMkLUjLn3NLRphlfpWRmpnH6UVcMEMLRcf54JgHyHUHhkC7HQ
         AI8Q==
X-Gm-Message-State: AA6/9RmbmeHp+kpi+M5oXpG4Y/85QQuuLwsL1Z85lAFOqCa9s2+lTRNDK/LGf9qVAdWDY7w1oPcfbr08NI5p89iG
X-Received: by 10.55.64.80 with SMTP id n77mr15087529qka.173.1476126509518;
 Mon, 10 Oct 2016 12:08:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 10 Oct 2016 12:08:29 -0700 (PDT)
In-Reply-To: <AB0A757A7BE241B39C8193A633C61FED@black7>
References: <1476039798.3060702.750483225.1DE6C48B@webmail.messagingengine.com>
 <4B3747D8D2724E98B6AC000FE4072A09@black7> <CAGZ79kaHOBaVCsVPen-K_5LyitcDzVbjL_kAqMkYKk_fQxH4PQ@mail.gmail.com>
 <AB0A757A7BE241B39C8193A633C61FED@black7>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Oct 2016 12:08:29 -0700
Message-ID: <CAGZ79kb2HWmaW3XpfHRj8vcOStPoQmR_NZe7RCRhw=FnnHbZ8A@mail.gmail.com>
Subject: Re: How to watch a mailing list & repo for patches which affect a
 certain area of code?
To:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Ian Kelling <ian@iankelling.org>,
        Xiaolong Ye <xiaolong.ye@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 11:56 AM, Jason Pyeron <jpyeron@pdinc.us> wrote:
>> -----Original Message-----
>> From: Stefan Beller
>> Sent: Monday, October 10, 2016 14:43
>>
>> +cc Xiaolong Ye <xiaolong.ye@intel.com>
>>
>> On Sun, Oct 9, 2016 at 2:26 PM, Jason Pyeron <jpyeron@pdinc.us> wrote:
>> >> -----Original Message-----
>> >> From: Ian Kelling
>> >> Sent: Sunday, October 09, 2016 15:03
>> >>
>> >> I've got patches in various projects, and I don't have
>> time to keep up
>> >> with the mailing list, but I'd like to help out with
>> >> maintenance of that
>> >> code, or the functions/files it touches. People don't cc me.
>> >> I figure I
>> >> could filter the list, test patches submitted, commits made,
>> >> mentions of
>> >> files/functions, build filters based on the code I have in
>> >> the repo even
>> >> if it's been moved or changed subsequently. I'm wondering
>> what other
>> >> people have implemented already for automation around
>> this, or general
>> >> thoughts. Web search is not showing me much.
>> >>
>> >
>> > One thought would be to apply every patch automatically (to
>> the branches of interest?). Then trigger on the [successful] changed
>> > code. This would simplify the logic to working on the
>> source only and not parsing the emails.
>> >
>> > -Jason
>> >
>>
>> I think this is currently attempted by some kernel people.
>> However it is very hard to tell where to apply a patch, as it
>
> This is one of the reasons why I use bundles instead of format patch.

Oh! That sounds interesting for solving the problem where to apply
a change, but the big disadvantage of bundles to patches is the inability
to just comment on it with an inline response.  So I assume you follow
a different workflow than git or the kernel do. Which project do you use it
for and do you have some documentation/blog that explains that workflow?


>
>> is not formalized.
>> See the series that was merged at 72ce3ff7b51c
>> ('xy/format-patch-base'),
>> which adds a footer to the patch, that tells you where
>> exactly a patch ought
>> to be applied.
>
> Cant wait for that.

Well it is found in 2.9 and later. Currently the base footer is
opt-in, e.g. you'd
need to convince people to run `git config format.useAutoBase true` or to
manually add the base to the patch via `format-patch --base=<commit>`.

>
>>
>> The intention behind that series was to have some CI system hooked up
>> and report failures to the mailing list as well IIUC. Maybe
>> that helps with
>> your use case, too?
>
> I envisioned that it would try for each head he was interested in.
>

Well the test system can be smart enough to differentiate between:
* the patch you sent did not even compile on your base, so why
   are you sending bogus patches?
* the patch you sent was fine as you sent it, but in the mean time
  the target head progressed, and it doesn't compile/test any more.
  collaboration is hard.
* or an extension to the prior point: this patch is fine but is broken
  by the series xyz that is also in flight, please coordinate with
  name@email.
