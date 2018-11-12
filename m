Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650E61F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 19:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbeKMFFR (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 00:05:17 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34446 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeKMFFR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 00:05:17 -0500
Received: by mail-ed1-f66.google.com with SMTP id w19-v6so8330646eds.1
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 11:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NffV0/BWnmMMm9sZmU5obQRtL+k4YJRj7xfgTOgIHyE=;
        b=UHxM+YhRbYg+SYP1gTNuxAor8RWoXzmMjEdpCfKG6ILhaWnngGydvCiXKQH+SXRtUW
         F5yZgLZOOnKKvqbJEwevYOPXm60dq5az0mkgL7uGgccXJxvGlopgVOqLEr68CnFMZayD
         54seLt0NtRY4esnnZQOaTpEve4+vIQyLF3a9vZdN8MoX8uxUgUs7rjbHItNf0CDVmQpX
         JgOa4kNsNB126+sgdIPYaIulmOkNNa5kl245tE81qJXz1J6Nwkn9EZFhc22k9J2GLP65
         WqF0cJ/ZyOVbejdxZQTVVBSY3e+E+ac66vQL6HS+m5qUA3mFHZGSYPptaRyAFBGLAfiO
         EoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NffV0/BWnmMMm9sZmU5obQRtL+k4YJRj7xfgTOgIHyE=;
        b=nt/gD0CSXH0lVLRlKF4tyCzaYNx7lSeEVF51G8VfPmrg6dfHkx1q+f7F5KWmc2aD+w
         oytMZUMhiffhsUG6YfNplvmLUBXJfVJaLXFc80971UAUwirW8NP8bH+kzxX6JYqEDwcT
         eNWVeuOwUlLQVN+JbgGb4CP+9PZ4kY5qb0O9iF889p3Rv1BZPW0mp6ie2HPIA1mQtIal
         7HVgx9kYRzvBCWdMLGs1ZRTHwMy3NxUkPGm9F9Lp0CWN1CSVhpGB0orqFe5iJ+CTUfvN
         2bhGRxpQoTtCLUVCr6Pus1Bn6OQOTOO1EE5U/T0aRBy3YnX0fUAgHzLgfiYKcjlMZXvZ
         ygKQ==
X-Gm-Message-State: AGRZ1gJhGExVO32qKcB1DdIpeS8ricnwjMQoinYN625e0PNysi0QmZK4
        JNemUY5BLDBqK8zvHx7JxyGBdWMwNgWw5mT+cOcmyg==
X-Google-Smtp-Source: AJdET5fesV+mN8PTjGRSfmAMM2j/21X8uNyyJDey1oglv4pl/U77hGCfM5NOArTgq6owTDFZrbrgmzqIsUfsEb9dIB0=
X-Received: by 2002:a17:906:b7d1:: with SMTP id fy17-v6mr10222677ejb.70.1542049842794;
 Mon, 12 Nov 2018 11:10:42 -0800 (PST)
MIME-Version: 1.0
References: <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com> <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com> <20181027093300.GA23974@sigill.intra.peff.net>
 <87lg6jljmf.fsf@evledraar.gmail.com> <20181029150453.GH17668@sigill.intra.peff.net>
 <87bm7clf4o.fsf@evledraar.gmail.com> <20181029232738.GC24557@sigill.intra.peff.net>
 <20181107225524.GA119693@amazon.com> <20181108120256.GA29432@sigill.intra.peff.net>
 <20181112144627.GA2478@sigill.intra.peff.net> <7f0dd0f6-ea74-9e8a-5bf9-936529d665cf@gmail.com>
In-Reply-To: <7f0dd0f6-ea74-9e8a-5bf9-936529d665cf@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Nov 2018 11:10:31 -0800
Message-ID: <CAGZ79kZg3B+SxG2ZGr3NA+SNPK-r3HL5ehMA+riRr9TRrGLrCQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] caching loose objects
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, gerardu@amazon.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, tikuta@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 8:02 AM Derrick Stolee <stolee@gmail.com> wrote:

> This cleanup is actually really valuable, and affects much more than
> this application.

I second this. I'd value this series more for the cleanup than its
application. ;-)
