Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2CC11F404
	for <e@80x24.org>; Fri, 29 Dec 2017 14:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbdL2OEF (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 09:04:05 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:39461 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdL2OEE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 09:04:04 -0500
Received: by mail-qk0-f178.google.com with SMTP id u184so52925245qkd.6
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 06:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qYifjUXgkFx3bvvVazmX1oJFncJilWK9xIiLg8jqajI=;
        b=TrAsv5CXceyllpa+3swWAUK81X3CjuponO1cbw8BMm1elWZtSY88YlVD4jpGMylIrw
         sqS9illLOnvXu7OhHlYW2oBQv7wbbu9pyoe99XSerqc/eFF7sU879OqRGE+dZiWd8Lml
         Z0lTmfIFFc8sip9p/z2VSuCGQqesztDvCOWvCHjZY7yjc1PAk5uzA9XkhQGI7qHQQDq3
         EUjit7Y5fWpoBudlo6LJE3Z8OejqwQCw6jW91xi0kgMt+A622FUJcn1qtWpBlxYSFjF0
         e2i2FEe60Pw7bQzpl+mzBDZ1CUoFL47W7y0ITdAkRnbYLs8dponJfZ3G5BAPjsNJHJkt
         nqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qYifjUXgkFx3bvvVazmX1oJFncJilWK9xIiLg8jqajI=;
        b=GRlYoek3BqyUwFMPnI92Jxr6piRRrODik2YZEUAd/jBXfbFnhgz8zpgJO2AGIlgP8H
         RvrxaGMTYBA1bLCuC4PHAdPzHY0PpezZyznLrwo8LIfGxBdNac8gg3QLJaSSfcuQWBaN
         +R1p4JkJaqQUZ6K1ZGriYMVgbieB84M52uT69L2AiZU/kpsW24e6M1mFlJkM+tlpwOB2
         0b60r7ZcOr9X6XTdGI9cM0p+hE7Q+QMRRlFzyLHPLmZSc7HQqRBDGoHGqh8wT0Hz/lLE
         +Idf68ImozswPiZwkaHcawzcagI+m/Lg19t1F/R3eeo1JC2cIH4nVWfkHLFnRcH/jzeD
         I7Jg==
X-Gm-Message-State: AKGB3mJK0XYpehqCE2YwnrEmkSKxL2lmoI0si+fkH4GDtKauvv53jUwr
        9fv1Gwnja+iaaZcoCp7ISVdOMmT6T2W8tnp3P/Y=
X-Google-Smtp-Source: ACJfBot08z9WqI8X90C95f3pSnsD/1GVQjXnoftQrt0O0KZT/qB4Qt3Zl8PmAl9JYp2nYASmsYgBABTYjfNblC7itPw=
X-Received: by 10.55.97.15 with SMTP id v15mr46014046qkb.71.1514556243676;
 Fri, 29 Dec 2017 06:04:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.16.154 with HTTP; Fri, 29 Dec 2017 06:04:03 -0800 (PST)
In-Reply-To: <20171229132237.GA12561@sigill.intra.peff.net>
References: <CAL21BmnycG4=Wm_e1S85QVPfs3vV_Q=TAjTAG-sv+f2mK6wbBQ@mail.gmail.com>
 <20171229132237.GA12561@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 29 Dec 2017 17:04:03 +0300
Message-ID: <CAL21BmkcDK+VRc2CBTKnV5eubLh8u37THYjXhuTgFKR4Z=VtTA@mail.gmail.com>
Subject: Re: Rewrite cat-file.c : need help to find a bug
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-12-29 16:22 GMT+03:00 Jeff King <peff@peff.net>:
> On Fri, Dec 29, 2017 at 01:05:50PM +0300, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=
=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F wrote:
>
>> Hi everyone,
>> I am trying to reuse formatting logic from ref-filter in cat-file
>> command. Now cat-file uses its own formatting code.
>> I am trying to achieve that step-by-step, now I want to invoke
>> populate_value function, and I have a bug somewhere.
>> My code is here.
>> https://github.com/telezhnaya/git/commits/catfile
>> All commits that starts from "cat-file: " are successfully passing all t=
ests.
>> So for now my last commit fails, and I am tired of searching for the
>> error. Actually, I just copied some values to another variable and
>> move some code to other place. All "intelligent" work will go further,
>> but now I need to fix current situation.
>
> The problem is that "cat_file_info" is NULL when you get to
> populate_value(), so the moved code doesn't trigger.
>

 Thanks a lot!
