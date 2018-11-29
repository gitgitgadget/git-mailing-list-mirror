Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E52211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 02:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeK2Nz2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 08:55:28 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:38256 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbeK2Nz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 08:55:28 -0500
Received: by mail-it1-f174.google.com with SMTP id h65so1347506ith.3
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 18:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KuAdRgP4rJL0WVcTZVN0Ht6xLLr/F7huWl19YUbPG0=;
        b=uB2wgHHfW4Jaoj6Fyb8qWQ3DF2k3vhdGLPe/D2qhAqDOHTJuZEwHO2lKFZI9dGxU7y
         W6mJldV2pOLpHRfsQiyizxJ4tPVFrSOAu8R8k/SYSKh8bF7hvRMhj7evSK6puObHiiun
         xYD2R9CaC+vkyulji6m1CE4dpgXRQfqwwopWiiZEB6DM/PgC3jGnNXVAXB/dwBG2jIF4
         SderslC4qTYqQJo7IJSvNcTzgXZ4kwUUbrBN9TpaBv8FFw1R6WBfwjoE5Q9uCbFW3/UG
         ndHXFKSxm11C8AAZg9wPDDutMRTjz1HLFcOrX9Ax75oO/0QYdlZPXSYMfSBjjDA9ejXU
         4ZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KuAdRgP4rJL0WVcTZVN0Ht6xLLr/F7huWl19YUbPG0=;
        b=RdtucNfzXHLK4zU7OaXNxKQujRIMV/UdhWdHhZr3wO+MvwOukpTxANry5wFqFh4enk
         GFRsE512ZfgWowy8Jm9gHky8lXJMetavh8HOcuVsTK/oZ1Y9kYTNalnEpokiQeccyfZz
         52rG3CMk2Aid8ie2lSJekpBRi0T3smV2m9wSEvRO4t0eLijT54zfZyWf23SLj0w/A0/5
         G9PH2LImXT+YveKaVtbTjoTkh3kTy973tD6H5yOwobWsnrH3G2qlBOo6MayxTsbYGSfT
         oj9zyUjeirdVdVL6+e6s2YMWm3xbhrcGwX+WnkMvpUAvWdyH15V3k/L/Df/YVxjmoIDH
         ScqA==
X-Gm-Message-State: AGRZ1gKqmQoRGK41uChRB+ruQoY8S1wXMBebD4XWzeHXSz8aLQEnFos+
        +ChTazAQ7vE6weFCApAil8wAfAdNgfGeFiqmx3VBCg==
X-Google-Smtp-Source: AJdET5eEbqTCd2LRZz8fvtMc7Edz1t/WCK89gmOMHdvl+JgYNCc7yo3+2ECr0WdHIt6hxdxBveMMw/MaXgNwnTr33ZY=
X-Received: by 2002:a02:16c5:: with SMTP id a188mr33263911jaa.99.1543459899407;
 Wed, 28 Nov 2018 18:51:39 -0800 (PST)
MIME-Version: 1.0
References: <CAGyf7-F6BiqSa7LOWxvHZPfO+UaohQR78rCgvN9En+1P4du2Nw@mail.gmail.com>
 <87efb6ytfj.fsf@evledraar.gmail.com> <CAGyf7-F-zs9Xyx623HizpOrv80y3PydReFYw-64w3T7Xfr3CNg@mail.gmail.com>
 <87d0qqysay.fsf@evledraar.gmail.com> <CABPp-BFBLKU5jnpr7scXJdj==qNtHJZ8R+LLMRE7qXT47eXXDg@mail.gmail.com>
 <CAGyf7-FwGRVtFYbOGW8DmY9F-cgun0n5K-ZWBjXCR=wvWh=8dQ@mail.gmail.com> <xmqqtvk0r87v.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvk0r87v.fsf@gitster-ct.c.googlers.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 28 Nov 2018 18:51:28 -0800
Message-ID: <CAGyf7-FVxHak7zN7jpEe4xu7mWn4T7H4szvsLqNGM1UH_0_5eg@mail.gmail.com>
Subject: Re: Forcing GC to always fail
To:     Junio C Hamano <gitster@pobox.com>
Cc:     newren@gmail.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 5:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> > Another issue with the canned steps for "git gc" is that it means it
> > can't be used to do specific types of cleanup on a different schedule
> > from others. For example, we use "git pack-refs" directly to
> > frequently pack the refs in our repositories, separate from "git
> > repack" + "git prune" for repacking objects. That allows us to keep
> > our refs packed better without incurring the full overhead of
> > constantly building new packs.
>
> I am not sure if the above is an example of things that are good.
> We keep individual "pack-refs" and "rev-list | pack-objects"
> available exactly to give finer grained control to repository
> owners, and "gc" is meant to be one-size-fits-all easy to run
> by end users.  Adding options to "git gc --no-reflog --pack-refs"
> to complicate it sounds somewhat backwards.

I think we're in agreement there. I was citing the fact that GC isn't
good for targeted maintenance as a reason why we use "pack-refs"
directly, which sounds like what you're saying as well. I don't think
that inflating GC with options to skip specific steps is a good idea,
but that does mean that, for those targeted operations, we need to use
the lower-level commands directly, rather than GC.

Bryan
