Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D3D1207B3
	for <e@80x24.org>; Fri,  5 May 2017 23:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbdEEXxG (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 19:53:06 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:32973 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbdEEXxF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 19:53:05 -0400
Received: by mail-pg0-f54.google.com with SMTP id u187so1224265pgb.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 16:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jmxI41oHgHIu9ygg+2Hg33pkV6T1j0FIskGPuWIDerA=;
        b=fAZW4MwWYIauyRq/eKXy4YwtfZhaPD/kI47RMpPcnK27VAIJ/8iyAL6oPUQtnvBsSK
         W85r8D3Sa2XpQde6OdMrpAU6vOtGgiZWDtDF3ELQ8fbFt2loXpfhKDOVx7v54JTBaiVk
         0KrTvCB5vdILAFXevI3jQfC49K/gXZzx89+cBQxn5bLdcHsdctC+U9YxRiVJudn3wPd6
         GhO2FF/HB1XfjOCOxceA5rvgjF54zfF+M2FHQc7moIhzrMsP+2PPiaVNzU0GhWYQMwfy
         kFPiHRWje02k+7tcOWA646NjgKuuasylJxHxBZPgE9TDuxICqnj1VZfE5KXhC0VJkLU6
         Gl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jmxI41oHgHIu9ygg+2Hg33pkV6T1j0FIskGPuWIDerA=;
        b=Xe8gruGb4EN0OYJJBsfPBPJ1OgljLpUx8Q0hhKeb/GQvASDYXpXDJ5D+0rLrXDiC00
         E8cdBI/At4t0VVcHhCIOpdK4SdYFAEOAIG120ofV4y7B+KNrjhO7hTXROSHjsnGo5Avc
         gMOaWDN2j+WU+IBnoLN6Xcn3JS+08b/F9Sd/ECdLesgJSRQEVZ30XgYdezvJ5CACWMlU
         gDKY7j39sv6DMakxw073oIZcX7fXC5VU4duURrsqfaR1AtOwHm4BmJUoZuZsZWJa1rGG
         1oDsbh02EXC3pVkrYe1s+xN5fRmzK/SHECn7/LDQK6r7R+hmyTmVINj87RjWhb02vdJC
         alEQ==
X-Gm-Message-State: AODbwcBMd1lBSXAP228yp4HtWFt9QUljU36tRoBz204vG0igDW+W49wh
        YYb/Q4kqXOQXOM7Wh5IWlWReHvHO3Y7kF60=
X-Received: by 10.84.248.73 with SMTP id e9mr3777228pln.76.1494028385000; Fri,
 05 May 2017 16:53:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.140 with HTTP; Fri, 5 May 2017 16:53:04 -0700 (PDT)
In-Reply-To: <20170505235017.GC55152@google.com>
References: <cover.1494027001.git.jonathantanmy@google.com>
 <28c40105e53a4d4d828092bc1697fff8992419d6.1494027001.git.jonathantanmy@google.com>
 <20170505235017.GC55152@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 5 May 2017 16:53:04 -0700
Message-ID: <CAGZ79kaq5x4RdXiopcP+-NvAiwkLE6A1yBjbHVaghDVRvOu-6A@mail.gmail.com>
Subject: Re: [PATCH 1/3] docs: correct receive.advertisePushOptions default
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2017 at 4:50 PM, Brandon Williams <bmwill@google.com> wrote:
> On 05/05, Jonathan Tan wrote:
>> In commit c714e45 ("receive-pack: implement advertising and receiving
>> push options", 2016-07-14), receive-pack was taught to (among other
>> things) advertise that it understood push options, depending on
>> configuration. It was documented that it advertised such ability by
>> default; however, it actually does not. (In that commit, notice that
>> advertise_push_options defaults to 0, unlike advertise_atomic_push which
>> defaults to 1.)
>
> This looks like a good fix to the documentation as advertise_push_options
> does indeed default to 0.
>

Indeed.

Thanks,
Stefan
