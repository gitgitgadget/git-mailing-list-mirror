Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F7920989
	for <e@80x24.org>; Mon, 10 Oct 2016 18:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751056AbcJJSns (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 14:43:48 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33340 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbcJJSnr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 14:43:47 -0400
Received: by mail-qk0-f174.google.com with SMTP id n189so126048738qke.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=JIq2OeAT7GbPM/ez6jiizE9IhWxE+ZB6pYMJ0EidLpE=;
        b=AbpHJaZ4zNTL7Bk9ZWm19AsNyzbKDNez03GH5mSiu2vS3upPt4ktETWamX4TIJDKqe
         nFfi1xpziTft6Tiu+HsT7YbDGyDlkGpHp8R307AyKCCkBLzK5KGgbWWkyN38zK7mJ+To
         DCN3HQYwrww1mCJnbjUqgL8z3T+lLtwE6kRKGRd1a0klHkoOGSVDJJqhL6amapx9/mBy
         rhyaeFZqFOZEVLDaItOYvUyyk0DEIGdYJ+Wv/gD46yfzOuBlHP2cDAsIA5j/SgTiqYQv
         0fOAbtnYSzWMixSA5nhMY0+5XWxgJzPcdHOJ6yElSyxbe6mV0K2iRAesM5uVaamsQawM
         pArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=JIq2OeAT7GbPM/ez6jiizE9IhWxE+ZB6pYMJ0EidLpE=;
        b=e5JceMeD/LTRmh99sy97KCnvg65ZoATAU2HxT75f4/U9HhKSeRnWMxZHf/fMqyUNH2
         h5bZUhET4jKKDhnbqTPE8GGNu9Jqq1uolfjl3KfyK5lRGdFsfhziAvXzRYl8L8SFn72x
         AD3zJmiJ1qTPeJP/7UPuDBXHx+OY1B7n9u+KURbNOzG9HSD6fVk9TnztJFcaQE1ZKWmM
         nzJEdUSXNUPd3Gx6d3UsGnopRQmQxjQVPonHrEegNT+GqQ4Pq7QMjvEMyq1uRgqvZP82
         mP8Heemephv0JGIpOlI+z+e4TTgXkUrRL5qaGBZXpKpEWukz/1pfP1CbBEvCsSwrjPXP
         OWoQ==
X-Gm-Message-State: AA6/9Rl923kvFQ/iEc5557R7gWYG6V8VrXEDEaH77eRCq20ZoYeGvdK7UgeLoN9jM7+mPEIcJp6NZMcK285VqBOc
X-Received: by 10.55.129.1 with SMTP id c1mr31481798qkd.53.1476124980133; Mon,
 10 Oct 2016 11:43:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 10 Oct 2016 11:42:59 -0700 (PDT)
In-Reply-To: <4B3747D8D2724E98B6AC000FE4072A09@black7>
References: <1476039798.3060702.750483225.1DE6C48B@webmail.messagingengine.com>
 <4B3747D8D2724E98B6AC000FE4072A09@black7>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Oct 2016 11:42:59 -0700
Message-ID: <CAGZ79kaHOBaVCsVPen-K_5LyitcDzVbjL_kAqMkYKk_fQxH4PQ@mail.gmail.com>
Subject: Re: How to watch a mailing list & repo for patches which affect a
 certain area of code?
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Ian Kelling <ian@iankelling.org>,
        Xiaolong Ye <xiaolong.ye@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc Xiaolong Ye <xiaolong.ye@intel.com>

On Sun, Oct 9, 2016 at 2:26 PM, Jason Pyeron <jpyeron@pdinc.us> wrote:
>> -----Original Message-----
>> From: Ian Kelling
>> Sent: Sunday, October 09, 2016 15:03
>>
>> I've got patches in various projects, and I don't have time to keep up
>> with the mailing list, but I'd like to help out with
>> maintenance of that
>> code, or the functions/files it touches. People don't cc me.
>> I figure I
>> could filter the list, test patches submitted, commits made,
>> mentions of
>> files/functions, build filters based on the code I have in
>> the repo even
>> if it's been moved or changed subsequently. I'm wondering what other
>> people have implemented already for automation around this, or general
>> thoughts. Web search is not showing me much.
>>
>
> One thought would be to apply every patch automatically (to the branches of interest?). Then trigger on the [successful] changed
> code. This would simplify the logic to working on the source only and not parsing the emails.
>
> -Jason
>

I think this is currently attempted by some kernel people.
However it is very hard to tell where to apply a patch, as it is not formalized.
See the series that was merged at 72ce3ff7b51c ('xy/format-patch-base'),
which adds a footer to the patch, that tells you where exactly a patch ought
to be applied.

The intention behind that series was to have some CI system hooked up
and report failures to the mailing list as well IIUC. Maybe that helps with
your use case, too?
