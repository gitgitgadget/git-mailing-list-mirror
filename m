Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1DF31F6C1
	for <e@80x24.org>; Fri, 26 Aug 2016 06:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbcHZG65 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 02:58:57 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35460 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbcHZG64 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 02:58:56 -0400
Received: by mail-qk0-f170.google.com with SMTP id v123so68339901qkh.2
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 23:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T94mXYMh4hv9S9ldOEpgwZ7ZrVe4217ROVDuwl6ysiA=;
        b=x9U1I11hIwwu2+nfPoVpV76ZBy9zpGwB+31XaM/V43ngdVt8SZPl9/aiwfDpknXn2N
         G9RwWeUoDEpRUrwKCn3ajVXzd2tjiv+g0RPyN2kk/7wfyTR6RE+Zcikg/RihsW/P6Xtc
         LQSmybd4unWYeLhwcrn7eNb9pIW7pdxLQQviktCUAR8W2i7TQtmPEhKlQ5GZjaCxIrR+
         ghb096SPM8b7w8FpPyXBNx1nS/LqAOsLvdcSQNaphUeUUk/O7HB5lMENsOOGnhYy0p5t
         SdyzwvqGDpzMEeXeV8SUKhTF+0JVzw72hPpEHG2R/L2Aixy83Vy7rXqr6d+QHndWqo8s
         Gv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T94mXYMh4hv9S9ldOEpgwZ7ZrVe4217ROVDuwl6ysiA=;
        b=etkY9VbIC7PY0d+sN6wsX6y+9KCWgH1JsjZsIiQBieV0UARiEKcRhWcr7Pbh0of1hK
         lPRMZCd9ZBsnydcRLXL8tE7ahWcJ/SrtcPFIOGVZDYmT6yrac9/8ueXUW9Mfa0vxoBch
         lemK+u/3spZqW71Bb9WC6pRuSCoveraysmQT1hMk12h5WlfCDXipoqe5I1+sg4vrqrle
         vkE/v3AnGWv7OuEVSPYs8mJvCX2Ybz6YAAGF3jh4t5oP7WBYe+4o7Bk3685YdUJEXkKj
         dGl5B0N4fHoFLCPSMxi9ZS1EFvrHBeskuMoL3AdvwbRVmwMWrS07/TvLhQ8QJfEPvm5E
         x0kw==
X-Gm-Message-State: AE9vXwMSzxF02bhj/GeHhAeKnWIUTebZbgkZE5jHQklPWmqu65OGQ7LCiHHt2crTv0EnSS/lCByqb3ut9O8TgA==
X-Received: by 10.55.174.2 with SMTP id x2mr1466850qke.63.1472194735066; Thu,
 25 Aug 2016 23:58:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.49.71 with HTTP; Thu, 25 Aug 2016 23:58:14 -0700 (PDT)
In-Reply-To: <90165dce-c508-4cb4-ec6e-c3d271181fe3@gmail.com>
References: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
 <CAH5451n0=kmr9SeOKSH5iiJr5Lnr2TapfZrTUR6Pm90xUEKFxQ@mail.gmail.com> <90165dce-c508-4cb4-ec6e-c3d271181fe3@gmail.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Fri, 26 Aug 2016 16:58:14 +1000
Message-ID: <CAH5451nMeuZttRgM8LK3JcPhfOYHieyawV2pJzp0jdh2KAf60Q@mail.gmail.com>
Subject: Re: [RFC] Proposed questions for "Git User's Survey 2016"
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
> Andrew Ardill pisze:
> > Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
> >> 25. What [channel(s)] do you use to request/get help about Git [(if an=
y)]
> >
> > It may also be useful to ask how people hear news about git, such as
> > when a new release comes out. Not sure if worth a separate question,
> > as there is a lot of crossover in the resources available for this and
> > for requesting help, but knowing this information would help us
> > understand what kinds of users are responding and which communication
> > channels are effective for git news.
>
> How would you propose such question would look like, and what proposed
> answers would be (if it were not a free-text / essay question)?

Something like:

XX. How do you hear about git related news (such as new releases and
community events)?
    (multiple choice or single choice?)
 * I wasn't aware there was any news
 * I don't read any news, but I'm aware of it
 * through news aggregation sites (such as reddit or hacker news)
 * from a newsletter (such as Git Rev News)
 * from a mailing list (such as the git developer or the git for windows li=
st)
 * other

It would be good to allow a list of specific resources to be written
to capture things we don't know about, and specific instances of the
categories above, eg:
"hacker news, git mailing list, git rev news"

> Note that there might be a problem of severe bias: people who heard
> about Git User's Survey 2016 are probably ones that watch news about Git.
> Still, it would be useful to know if people read RelNotes...

Agreed, the intent behind the question is to work out what are the
effective communication channels so that they can be used more
effectively.


> That is, if people have a pattern to their upgrade of Git, and can
> tell how often they upgrade.
>
> XX. How often you upgrade Git?
>     (multiple choice or single choice?)
>
>  * as soon as new version is released
>  * when there is new binary package / distribution package
>  * when updating distribution / system
>  * around every month, or more often
>  * around every 6 months or more often
>  * I use what is installed on system
>
> Something like that?

Exactly, looks great.

Regards,

Andrew Ardill
