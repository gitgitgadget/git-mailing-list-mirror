Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795A7C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 23:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D996140A
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 23:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFCXhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 19:37:45 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:43731 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCXhp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 19:37:45 -0400
Received: by mail-ej1-f52.google.com with SMTP id ci15so11678351ejc.10
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 16:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RgW+BYahXIFUf2sfoTSCqH0Awli+9famJ9zIQivzgqU=;
        b=RyW8EICvsI42deJYeKA/+TFFhRt++aRfUINdKXeLfXbHCf81QzpFI7dM46OA70SWNR
         bs3xjMBsK8luP8AIgRDSeRRDu+IvBch4mVFtSck5ftHayet1b+7lyRlteC1G1XlbQxuz
         7uKgJLzxYFWcw22jZdPyeOdXdHzCN/mtFDNOlZBJ3yc0Gt5fRU6UjZruhImJKYuOWjzM
         ioSHYvfdm2kU14Zy5mlbM38yRFBsXHoQknn2TTE7avvuZCAgsrS5FRXTuwAhJYrXZRob
         iOkBAz+SIUVF1xYR1hRCADcMkhw4trHyDzvOH+xD/9L0lamQcCDezJZXEmvmuAkQhBWC
         TeIg==
X-Gm-Message-State: AOAM531BhL2K8FsPjGZ53IQ4ru2d8ow2CA/BBtFUrgg2vOeGj9fJVORo
        sL2DMOLkq4PS5daB8cl73UokK5ly+XKvAQEXl7dyIFf9KfU=
X-Google-Smtp-Source: ABdhPJxVjtymOFDgtHweHgVrrCBG7iG5p5NtftMfn+QJn8Q0MLJ0SB5+/ou0hvXJfLu+LGPSRx3jUFj25Xws5W1Wzuk=
X-Received: by 2002:a17:906:c311:: with SMTP id s17mr1489152ejz.202.1622763343075;
 Thu, 03 Jun 2021 16:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local> <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <60b928374d90e_39cbe920835@natae.notmuch>
In-Reply-To: <60b928374d90e_39cbe920835@natae.notmuch>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 Jun 2021 19:35:32 -0400
Message-ID: <CAPig+cS74Ah3OyJPNQhvkdV6f7mkFgFQjHgfrrAE1gZsvN38RA@mail.gmail.com>
Subject: Re: Gmail OAuth2 in git send-email
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 3, 2021 at 3:06 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Eric Sunshine wrote:
> > The 2fa requirement is a problem for those of us who don't have
> > smartphones or SMS.
>
> You don't need either of those with an app password:
>
>   https://support.google.com/mail/answer/185833/sign-in-using-app-passwords

Google requires 2fa to be enabled in order to create app passwords,
and to enable 2fa requires a phone or a physical security device, so
I'm afraid I don't see how your suggestion is supposed to work for
people lacking such devices.

> And of course you don't need them for the second step authentication
> either, you can use any OTP client:
>
>   https://github.com/paolostivanin/OTPClient

Thanks, that's an interesting bit of information, though if a person
can't enable 2fa in the first place, then... (intentionally left
blank)
