Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E80F1F461
	for <e@80x24.org>; Sat, 31 Aug 2019 19:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfHaTpH (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Aug 2019 15:45:07 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:39649 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfHaTpH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Aug 2019 15:45:07 -0400
Received: by mail-wm1-f53.google.com with SMTP id n2so9390263wmk.4
        for <git@vger.kernel.org>; Sat, 31 Aug 2019 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OaCYOa/yN/aOFrU58UXaEd67U4dF5/plsOijgZVRHxQ=;
        b=hS0v8HikLRSiOnjePlm9DwPu4kFCcH8SdllOtvQ880MK+u91bXYQLV7depgY0RhnP4
         gQbl1wFxYXbRyU//cayALtatX8Ww7PHayScCpDn5N4ickoWeDJoSubHUAf09WvW4lFDv
         8cmE4iEF0p/AAIUxlJ5JKZNre+1DIeKds9KEk4b32URQzAR+yQ2LqcgCZQFpnPJb8Xwu
         KyKWSFYtrcoWaYJ7fuYxTe/p8Q3m0lNkNJIRMkO5oImKjcFcj7wekfO/FlcKNqboToHm
         H/ni2NX2lfrDWaIUkzcDdl2N5vcEO4/1EMquX0DFPaZyNLyuD5A361h4nr8UKKvN2FmI
         E88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OaCYOa/yN/aOFrU58UXaEd67U4dF5/plsOijgZVRHxQ=;
        b=gvtRn8M4vfLLZzyFi1WTyOs3zrVFCUEsUGukEzVN5clu8DkkQudYUhC8RRvrkgoITc
         qvwOW22nvFhbx32xBslGzGnoFenuW6tHnLnOy/ba8QUY4QIZfDpeoylB+b/4WJ0pmgrF
         aWxj2VMStvDhmwsENzlYIWYiQEBpyC2L/p9/nf2AUlhHRyUGrPcQqr3zN1o1k25ST9H0
         68oZRSKYzKjpqpNaNBelnhvPYf54rsdrfT6LngTWH3ciLU8yW3bLwTH4u9eUizif3vBa
         Ir4dBGFOERCH5ftdxrx9dT5IwbSUi/x3qPdSY9qZsa1rwThNlhjlP/bXDqJGoeRbsYfm
         f6RA==
X-Gm-Message-State: APjAAAU+IoLu2TSFFJITku3u2ZUjpVf5hRYvjhaDPo/JgJz6PRzexGYd
        HLXKgSJwnoVjVzrprGnj7t7tVAZVF7N4OteFwBU=
X-Google-Smtp-Source: APXvYqz/NpF6cFHvy9ZVe3jG1C9MY6ec8eXPkyPqPPJ+iQLU7pTLBQHQkh57EJK9AZOpGblSaLHtdVBii/WTT4cEZoM=
X-Received: by 2002:a1c:18a:: with SMTP id 132mr26707792wmb.15.1567280704993;
 Sat, 31 Aug 2019 12:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190827051756.GA12795@sigill.intra.peff.net> <CAP8UFD31Pp9XMDpaNfYP9ph_W0LV43sXvSvppXDjrTSp89S7ZQ@mail.gmail.com>
In-Reply-To: <CAP8UFD31Pp9XMDpaNfYP9ph_W0LV43sXvSvppXDjrTSp89S7ZQ@mail.gmail.com>
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
Date:   Sat, 31 Aug 2019 22:44:53 +0300
Message-ID: <CAL21BmnZr6ubcZOmJebST8e4UccWnPHwDGqLimwrHVCmf61Jmg@mail.gmail.com>
Subject: Re: Git in Outreachy December 2019?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D1=81=D0=B1, 31 =D0=B0=D0=B2=D0=B3. 2019 =D0=B3. =D0=B2 10:58, Christian C=
ouder <christian.couder@gmail.com>:
>
> On Tue, Aug 27, 2019 at 7:17 AM Jeff King <peff@peff.net> wrote:
> >
> > Do we have interested mentors for the next round of Outreachy?
>
> I am interested to co-mentor.

I am not ready to give the answer right now, but I will definitely
think about the project proposals, I want to help with that part. By
the way, we can take some projects (with description) from this summer
round of GSoC. 3 of 4 projects were not selected.

>
> > The deadline for Git to apply to the program is September 5th. The
> > deadline for mentors to have submitted project descriptions is Septembe=
r
> > 24th. Intern applications would start on October 1st.
> >
> > If there are mentors who want to participate, I can handle the project
> > application and can start asking around for funding.
>
> That would be really nice, thank you!

Thank you!
