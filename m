Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909A81F45B
	for <e@80x24.org>; Fri, 28 Dec 2018 15:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbeL1Pjd (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 10:39:33 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39008 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732034AbeL1Pjd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 10:39:33 -0500
Received: by mail-ot1-f53.google.com with SMTP id n8so18929025otl.6
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 07:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IpOVcYSJBBaTRMX3mZE66ON2QGXTLwCzFT5ZN/YHOOE=;
        b=SIFASP5Wo6iN1wF6R/l3NWlpZDd3l5o+NEWjhqBHdK4e8IC4XLEGq36o7AHgYzmLkX
         NRgtEPJZsa8G79yhyBaQS6Drqp8UDTkSOl2NkauY+UAa1j//CvVROh4kRYBRp1cbfaYc
         cuRsJUad8DmlgTbI4ZWMeSuxgH68aPmJa3VqFBc7A4lqRAOaQd2TOh0APUkcy0WaYykz
         wMj7krIGiZyKq9ptBNQABeHZ97+s5g5Jy8WIjFP8daPlXpx0ziqNGLFRtO9RPLyiNn1c
         6Mbb0CngaPE9Cptwy+ee3nSF/9VuZ5+P7oLB3hmqqzw7oieuqIiiYFUOIUgcgfLzms4+
         q5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IpOVcYSJBBaTRMX3mZE66ON2QGXTLwCzFT5ZN/YHOOE=;
        b=qMG1X8YYWLnFRuiqMVD69lrqRIakZayvTLo+R/wsOKeq5b20gCO1y5GH7yFd+2+9Wf
         ZPQ1R4PjwcUUbAIt+06VQDiFAxPtcYKIS72dbEFC9ImmttOWoHih1BsDPHJt9O3CsFqF
         prT+lw7Zld58dDr44ki5rRVF6l+tH0ZJCdLHfK9aScHyMHcWanTs7XzQ1laTeHTSWbR/
         N6GMs7wmEdUX8932AHZuHljtx//1RSL/Z6Y1S7m7F5XPtzPFe7/IUUO2WWODcnd9Bj7L
         1QjU5lLx1Tv8t0dQy722As4OECHSJSUsvolvqCUv78ssd85NmsC7D8Zgo5TgnatG07Es
         MZ9A==
X-Gm-Message-State: AJcUukdBzmh5oDt3H9eQBIGRILxJp2k8aEVx2CgxgIf7b+manT9A7wxa
        VFImgaqSV/SQIOqshfDWJCGPflImWnnXjR7FZoQ=
X-Google-Smtp-Source: ALg8bN7sJM11Zi/BPEVNt5LS729Jjg9tvztGZ80H4sPhoU2vn6YNmui6u+4jGNG6dyPjWXxg0AlEw8y48kVr2u/DRYE=
X-Received: by 2002:a9d:2ae2:: with SMTP id e89mr19750826otb.290.1546011571796;
 Fri, 28 Dec 2018 07:39:31 -0800 (PST)
MIME-Version: 1.0
References: <CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com>
 <20181221234231.GB10611@genre.crustytoothpaste.net> <87y38few5h.fsf@evledraar.gmail.com>
 <20181223231834.GD26554@genre.crustytoothpaste.net> <87wonzes23.fsf@evledraar.gmail.com>
 <20181224022042.GE26554@genre.crustytoothpaste.net>
In-Reply-To: <20181224022042.GE26554@genre.crustytoothpaste.net>
From:   John Passaro <john.a.passaro@gmail.com>
Date:   Fri, 28 Dec 2018 10:38:54 -0500
Message-ID: <CAJdN7KgO4gGSkcDq1dOHZZYDj0qGnRq+AU4CF+UzHdJtNYGhng@mail.gmail.com>
Subject: Re: Can git choose perl at runtime?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        John Passaro <john.a.passaro@gmail.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 23, 2018 at 9:20 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> I think we should just ask Homebrew to ship a functional, complete Git.

They are doing just that:
https://github.com/Homebrew/homebrew-core/pull/35446
If for some reason this patch doesn't make it in, I'll keep bugging
them about it, but this does seem like the preferable solution.
Thank you everybody for chiming in.
