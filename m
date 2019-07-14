Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D344F1F461
	for <e@80x24.org>; Sun, 14 Jul 2019 11:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfGNLAx (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jul 2019 07:00:53 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45163 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbfGNLAw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jul 2019 07:00:52 -0400
Received: by mail-ed1-f41.google.com with SMTP id x19so6882166eda.12
        for <git@vger.kernel.org>; Sun, 14 Jul 2019 04:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fx7IATtF3LOFeFWmMaQvFmPfbmICjbkveA5dxZftdrQ=;
        b=m2sQupS30OIFGh+n236NRvztX5MRcXDsxhDNqAMT5Use86B4xBMiBC1kvQYkYlqqAf
         wXyHARanPUpXXy+DMeu/PbiUdL1JKH6MatsCaWFkNxUaOMXfOfgfZsppCdM7qwCODHfU
         vGVcbxaXNbYGlbLulZ5DVYUnxIkhdS82QQRCL3nhMvnGg3tj02sFolqxLkSc7LqPNDjJ
         O3qeIbFIBByjs0Egy6XIGYEg95IzuVDj4iH47NsFAgwiQPMujm9phPX/y3iy/asTtGt4
         GtPOSGK829aBGrjd7kelJsDaNXgYSsiEN2FJHncZ3NivVvKXQ7AJQwnaFekbjLQB15wj
         i3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fx7IATtF3LOFeFWmMaQvFmPfbmICjbkveA5dxZftdrQ=;
        b=NmQFlXJUIL2HtlCUGBmd0NFbAwBoAi0449fzOXwLQfQqYJb2Qy5Kt8Abkw1PkLwjKQ
         R9kU6Rqm2uNz82Q9MvGeslXzrXeOVbqm3y+0EdYs0E2Q5Zv3jCnIaxkzXMC7OOHdJQN4
         PXDdRQXdPd0wJwmOcQKGaxAI0n9CeTeszr1cMFwJU06jbVb5QHWNXHoj/wJDugkML85f
         vC18wMLZk87KijZPsibL4aRalLT71PeNYkpMxNEHHajaZ6XS5J1oAMWwRfWaFLleWfRI
         SM4VILmlLWt2OcJoeu55VTlwgW6Bt6yoGYOoiNg+3V/DFWwrAncjXR5epAVnJMoVC7mD
         SvQg==
X-Gm-Message-State: APjAAAW3GqsSjA5z0+dTwDYDZ8cHwtJDFRl6ensZnpUxXYPo8iAHZQ4i
        kg6RVP9yCFo9cbIW0HO4f5o3yzNNj4shreb1ouo=
X-Google-Smtp-Source: APXvYqyCOdt+m0qZKFc+AnEm1EI6FVuLYlBFUXzuVRIvAvueazIrHO61EJ8B9901KloVh2fzDL57lK4mXH0IZCXwbcQ=
X-Received: by 2002:a50:eb92:: with SMTP id y18mr17755005edr.245.1563102050702;
 Sun, 14 Jul 2019 04:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
 <CAHd-oW7V_oK5Tqg-fF3G-7r+k7eX8czyaT77yBPoEDoXVthj8g@mail.gmail.com>
In-Reply-To: <CAHd-oW7V_oK5Tqg-fF3G-7r+k7eX8czyaT77yBPoEDoXVthj8g@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 14 Jul 2019 13:00:39 +0200
Message-ID: <CAP8UFD2eHq+BynC9LHNvPB6Sk=1zTvM-r2VRD8sdxhCe+uNrVQ@mail.gmail.com>
Subject: Re: [GSoC] My project blog
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Sun, Jul 14, 2019 at 9:38 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> I just posted a new update about my GSoC project here:
> https://matheustavares.gitlab.io/posts/week-8-a-working-parallel-inflation
> Please, feel free to leave any comments. I've finally solved the race
> condition problem and now we have a working parallel inflation :) But
> there's still some tasks to be done on it before I have a proper
> patchset.

Great that you solved the race condition!

I agree with the tasks you list in the next steps. I would even
suggest that, right after splitting the changes into logical patches,
you ask your mentors (Olga and me) to review it, and then send it as
an RFC patch series to the mailing list. When you do that though,
please list the other tasks and limitations of your patch series in
the cover letter.

Thanks,
Christian.
