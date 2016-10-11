Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD7F1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 21:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754208AbcJKVxQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 17:53:16 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:36337 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753032AbcJKVxP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 17:53:15 -0400
Received: by mail-qt0-f173.google.com with SMTP id m5so4944058qtb.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 14:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lJuharL3qkicefU7hMe+tWwxJxfco96Z0TPZ7HceDq0=;
        b=YrMIXk5NtKydN66sF9AgUAZ4uhYTquSh6zQ+sBSCB0QO7lC7X3C3N9caFYC5DmmxKr
         wR2E4qt5wzJBijT3g8WBMEOyveRJEutqxZSS6EDnUjt1ukviuk1P3rNJtGg3U6Nsr3RY
         3O8wO4ZjzhZvWBKkJ//41a37fDV3AVpZc8QPBEPKOkGt9chlmxh/gZcWAPv9vUPXcHOw
         wH7TIfAV4bMQv5Dlzi5Iw/LnuFdrJa39BjVQvq9Z6BZMl8ND7EQnOe+6NKxagNvqaiYT
         2aRtsKns8clFdN1Ouge6s7UzEsiE8e3CSK4iup6RDiOqkYn188grcx16A/lboibODTzu
         B4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lJuharL3qkicefU7hMe+tWwxJxfco96Z0TPZ7HceDq0=;
        b=Thko+THpg9ddgFchtvfmo49FziCm7lznNFutKWBWbLJLJUgLc1fogD/x9TGo/XVIMz
         5qTUH81p+ux7hW/bRVqFb0sKn3Iuo175cy1sh5I5zVhkqCEIGPJpuR2GMwmAnopW72WU
         Uw4isNgi+xbUz6sMVnyz6iHExVKvhNwCZ1y8eFUl/8ecSzzZ2B3FL5Jl5EUnlvbtEZ8J
         SN3WFt3m5mebqxPURBK5ugAcvkSIqWIlOQdLfp/0MWAA5zA2rtwGrY5DJ1Qirts19Ycr
         BSD1E1CFq+Wbg5IVlvHtUoWIh730UcjyBgCumyC91Wk56nkmH8kRYI6/AUQeqjPAN0Ld
         Dp5w==
X-Gm-Message-State: AA6/9RnYDenaCayx4rTF6jhOtOARMw99O4uQ3Fe4il5w9JElZ9MKrGxIltneGy+p3KEyy0WAgsNa+IJBObOI8www
X-Received: by 10.237.47.194 with SMTP id m60mr5644881qtd.55.1476222794730;
 Tue, 11 Oct 2016 14:53:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 11 Oct 2016 14:53:14 -0700 (PDT)
In-Reply-To: <20161011173749.GC9085@google.com>
References: <20161011002115.23312-1-sbeller@google.com> <20161011002115.23312-27-sbeller@google.com>
 <20161011173749.GC9085@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Oct 2016 14:53:14 -0700
Message-ID: <CAGZ79kYYW9VE1yWvLgNHXg=UG2FTh0V9c=38aSLnLVvrpU2Pmw@mail.gmail.com>
Subject: Re: [PATCH 26/28] attr: make git_attr_counted static
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 10:37 AM, Brandon Williams <bmwill@google.com> wrote:
> On 10/10, Stefan Beller wrote:
>> It's not used outside the attr code, so let's keep it private.
>>
>> Change-Id: I0d15e0f2ea944b31d68b9cf1a4edecac0ca2170d
>
> Looks like you forgot to remove this :)

will be fixed in a reroll.
thanks!

>
> --
> Brandon Williams
