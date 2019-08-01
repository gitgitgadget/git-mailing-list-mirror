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
	by dcvr.yhbt.net (Postfix) with ESMTP id DF2481F731
	for <e@80x24.org>; Thu,  1 Aug 2019 19:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbfHAT3L (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 15:29:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41353 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388609AbfHAT3L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 15:29:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so32514268pls.8
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A0GLYYnP4HhuqVZQmYM+WQe/PFjb2oo7FH1bOTAzaqE=;
        b=qDaOHR/ahQrRlesz9Lb4LPg8pgdIxOJz+Bd/x66SKmd/tPpC2aUYJm/W4uCpz9lyHc
         Xh0a3pigrCg/4YH/fWDpsA8uB/WPowId2Z6sL8I+pC3/ezj4s6Fqh0nEVblYdt5yaSBz
         2b8PThTCN0oS9xJWKHryPD5j3x9t4vWCt5vjU+EZLAVWRi2Fl8Rry5RgmqeVvh2V5Ex0
         X2tjHT5lyYcXDO7UGk5bCHK0J9riXxU4VCvsCneY3xNlfSHwdrkq+pjIY3QCRr6PSobs
         cnme0gfOEPSNB0i5FYH7zT9zxAfVI+xu8DKk9GXdunslNESkjo3lRD6tVkvf2RI2+Kzu
         sPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A0GLYYnP4HhuqVZQmYM+WQe/PFjb2oo7FH1bOTAzaqE=;
        b=eTqxxiEXj0htZ7+O7Dvyyekm7xF+r/cUqhiYDKnHCTQoHSVZwHV7xypFH+H59xL6Aa
         hXJdLbi1KgR461GqcEolPpQrsFmlZb9kF462RO2+Zplrox3/Xb/SJwq/Fm77f0zi0j4K
         Sp0599foK5UUNynEs1GggO9WjNQsGjsvRnvKTzS2lCAax180unLqF9DaFtJj/YH8uszz
         g18RXJWh1yUZE4dwz7cT3JAcUTrwVAeqx1AQ9azvAoFcFKUMif83dC/FUfO6951rf/jX
         uawO3rjNZXKXmALgLpraNJdWDqB4J73EtAMMmNDGRb7OlkLaePSWUUz1BEYMHMNGpVLf
         RpIg==
X-Gm-Message-State: APjAAAUOr+9DLmG8fXhFAOqcxjlCPDOXeZ78oMkl6L3UEg2o6vSyDC3P
        DJqz63liYHvWxSR3q2OchcU6UBGb2vDCXZiXLTA=
X-Google-Smtp-Source: APXvYqynpBvII99FNxh2NcsCO+koeo5vvK4t0GLzBAoSszeSW1tg4TVz8mq9DbzZGR55LKqpq3VAzkAvl2k7Q+m1SDA=
X-Received: by 2002:a17:902:758d:: with SMTP id j13mr126132213pll.197.1564687750687;
 Thu, 01 Aug 2019 12:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com> <20190801141221.3626-1-martin.agren@gmail.com>
 <xmqq8sscop4f.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8sscop4f.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 1 Aug 2019 21:28:59 +0200
Message-ID: <CAN0heSrrrefqh29PQAE0P88YkgbujnY0jPBiHfDJF4uFGVKtGQ@mail.gmail.com>
Subject: Re: [PATCH] RelNotes/2.23.0: fix a few typos and other minor issues
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 1 Aug 2019 at 17:57, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > Fix the spelling of the new "--no-show-forced-updates" option that "git
> > fetch/pull" learned. Similarly, spell "--function-context" correctly an=
d
> > fix a few typos, grammos and minor mistakes.
> >
> > One of these is also in 2.22.1.txt, so fix it there too.
>
> Thanks, but it would have been better for this to be in two
> patches.  I'll split them up.

Oh, right, I suppose you'd *much* prefer a patch that applies on maint
for the 2.22.1-fix. It didn't occur to me. Sorry about that. Thanks for
adjusting on your end.

Martin
