Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDFD31F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 08:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeCXIqT (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 04:46:19 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:38747 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeCXIqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 04:46:16 -0400
Received: by mail-it0-f46.google.com with SMTP id 19-v6so5316931itw.3
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 01:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g2c+zS20sS3CdQQYn+t5ucAh6vXzUFjM8JaYtrEZK0M=;
        b=ZrFxyOFCs5ZQES2Z1e5dK65toPnprK9REVHCGHtghzrnI8OKnouyFuzBYpaPPIs6Zj
         1RHlNZplv/CZWLhzHSggmwIhRYcn3ztsemnEiT8XELyzPuK6J+hQowQeHUIvsSL5JDSt
         DJ2QeWCo/Ep7FV7f73JW+LSe9FH6wzSUtfCsKEezwiVtwH2hz31Iqg4P12uFaB7AYbZ6
         AQgFVtMM9DpkqL2My3J1vXUWHE2w4nn3vMZ34myJIttTRq26pZBDBc+7li4z9DZ/o4Yj
         phUA4tH5Wlke+YOWb+ejctlZkaW8YLHtXUQSY5jHzSPCeDmc7cGL6OP8NNnqyvsKy9Yf
         CFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g2c+zS20sS3CdQQYn+t5ucAh6vXzUFjM8JaYtrEZK0M=;
        b=eghuuRTT50zn2e177MDp432Y54AnVrp+fdJBsMclZ6+CLLIwdlQf6EeJHzVNKjErRt
         6Ql0jN6EsTY2dDpbtyCYOcnnmjgbJG0b+FWWluTcmItSnEsOUGgaH1KIzV9Irl/B7w1/
         OIr8k1hG3ioNJYHdqzy9BjyzILDonMvRv3UVyGL37AjNHnoY8fxBhJOyLwEdOJcVwZqN
         5yvMYU0yzEUgSlXyA2l3/2Zcnh2N/e7dDn/fls7SFMoDku1PslH12uavMP1iOmSgdE7F
         YfiELmhkySLtVss9Mi9j9fiOjv47zOXv01Yb8lH2Aj+15ikkPdhwLnBZFIG4Io9C62gG
         weVw==
X-Gm-Message-State: AElRT7HTKrBJRDyOWM7KOssZ42TK30mheGfxstra3Gg04WCxR7buOxeZ
        nvEyMYqFEDl/Z1misDU1me/o4tx3JzvEv2yp0xDzONxx
X-Google-Smtp-Source: AG47ELvdTcrZh0KxPxA190Iho9gIGME7kcUpz0VjhaQ7PsxwfZREaYLx9jX3D+7YOpo54oezLFhRo8xdjZrf2qj7hQk=
X-Received: by 2002:a24:eec5:: with SMTP id b188-v6mr15558601iti.96.1521881176051;
 Sat, 24 Mar 2018 01:46:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Sat, 24 Mar 2018 01:46:15 -0700 (PDT)
In-Reply-To: <d64eca23-8a59-1aa2-597a-128e341f4af3@gmail.com>
References: <d64eca23-8a59-1aa2-597a-128e341f4af3@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 24 Mar 2018 09:46:15 +0100
Message-ID: <CAP8UFD3Y4_h1Rt4fC-BwKYwJtU-7DR3W2pTFHsg_u1_sXNxUnQ@mail.gmail.com>
Subject: Re: [GSOC]About the microproject related to CI
To:     Zhibin Li <08826794brmt@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Mar 23, 2018 at 2:44 AM, Zhibin Li <08826794brmt@gmail.com> wrote:
> Hi all,
>
> I'm Zhibin Li, an undergraduate from China and I'm interested in automated
> testing. Since the application deadline is coming, hope it's not too late
> for me to start with the microproject.

As the Student Application Period ends on March 27, I think there are
very few chances that your microproject and your proposal will get
advanced enough at the end of the period for you to be selected. You
can still try if you really want though.

> If it's ok, I would like to take Git
> CI Improvements 4 as my starting point. But the description on the website
> shows less details so I wonder what am I supposed to do more specifically?

It looks like the CI improvements 4 is:

install CVS on the build machines to run t94?? and t96?? tests
install SVN on the build machines to run t91?? tests
install Apache Web Server to run 5539, 5550, and 5561

So it seems to me that you should create a patch that changes:

https://github.com/git/git/blob/master/.travis.yml

so that the testing machines will have some software installed that is
required to run some tests.

See:

e7e9f5e7a1 (travis-ci: enable Git SVN tests t91xx on Linux, 2016-05-19), and

https://public-inbox.org/git/20180305200400.3769-1-sidm1999@gmail.com/

for example.

> Reporting the results or trying to figure out the how and why those results
> come out independently? It would be nice if you guys can tell me about any
> details.

No this is not about the results of the tests.
