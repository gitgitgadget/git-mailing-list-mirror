Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A1F41FD09
	for <e@80x24.org>; Wed, 31 May 2017 19:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbdEaTIY (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 15:08:24 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:37201 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdEaTIX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 15:08:23 -0400
Received: by mail-it0-f51.google.com with SMTP id m47so1854166iti.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tFViCyECuJjtJ+KVbNdmgZqbpvh4t5mcW81gfsc9HcA=;
        b=Yq6OlVXWoRksUcV1k5DvO/48jW0nwnapgUv09LiyD7gxrkqlau8smwww+m0YukFAja
         hsnxKBu49izGydXVjLFcVlst/LtVF09M9UNRxrrGnRa/sck3rmejDvXf+NjXlhTRRiAa
         uJfO+6XGMLKWJUcn6sdKcD64Jg59i84+e7XlFaaGscqp0EcOtX3oMiibWbOybAapzI9Y
         w84o67Z1c4Cs8W4spXicB1TuXgy1ed8IZdjT6OVSucRFBomLtjGxHSp4VKWAu6IKLmTt
         7itft2UgPrflWDg0YYuTqlaaQt+YdpRxu2jixNQUiZAJgl0irKyO00lv3Rpct4VqKfjD
         W3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tFViCyECuJjtJ+KVbNdmgZqbpvh4t5mcW81gfsc9HcA=;
        b=Ih9tRVdYcaiMJnuA9jHBCp2XU5Jk1fPIVJN9h9UPfW5IO317lHleB7XIKqV2pqfL7y
         VkNyRqHSkbIVFkPhTPADNcBugXl6LOurQwcAb01sn+LfxdAW9rjqGtSdCRTsFDp2b6ZY
         w26PGROZ2iZzoRcC1qKakE9EURVUWqjJISfRaXCo6t4s8gMzZkYIuantqPPjtlM/3Jt5
         uqUFS6843nPV2KSe5ZUXsJgL/AS7TMq2VsmPW3LxpwtrgD/ke+SS+uIq1fDdKy30Vv3i
         m78QwJd0pisb1phxWYrV2Jtf6EwPiiSr3FD3kkpvxWHRXXOYoQKyYwu4lmCcqb9olSGS
         lRgw==
X-Gm-Message-State: AODbwcDbeKbbebrNXY/i0Oy7qys20QcICJLPfUgZK7qpKUVAT3tIDdcd
        Q0nPlP0AcZFDUlBqjlJvVSFLqGIfROtk0CHhlw==
X-Received: by 10.36.70.211 with SMTP id j202mr8611440itb.22.1496257702336;
 Wed, 31 May 2017 12:08:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Wed, 31 May 2017 12:07:41 -0700 (PDT)
In-Reply-To: <CAD1ypiWOcKaLJJzZC=gw75EDFnw_1ZqC94B5p9i722T-sijN1Q@mail.gmail.com>
References: <CAD1ypiWOcKaLJJzZC=gw75EDFnw_1ZqC94B5p9i722T-sijN1Q@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 31 May 2017 15:07:41 -0400
Message-ID: <CAJZjrdWrrZBCR0xQMSFbCL6rwPThNNitkUA2AoOhOWQkxkUv9g@mail.gmail.com>
Subject: Re: Coloring
To:     Irving Rabin <irving@edmodo.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 2:33 PM, Irving Rabin <irving@edmodo.com> wrote:
>
> Folks, I am reporting an issue with coloring of the output of Git
> commands, like status, diff, etc.
>
> Specifically, if the field is supposed to be white, it doesn't mean it
> should be literally 0xFFFFFF. It should be the color that I have
> configured as White color for my console emulator.
>
> I like light-screen terminals, and I configure my ANSI colors in the
> way that they are clearly visible on the background and clearly
> distinct between themselves. In my terminal settings background is
> light-yellow, Black is black, Yellow is brown, Red is dark red,
> Magenta is purple and White is dark gray. I set it once and I can use
> it everywhere - all Unix commands work correctly, I can edit
> highlighted source code in Vim, and all my color settings are
> respected.

Can you elaborate on how it is that you redefine your terminal color
scheme? There are multiple levels at which you can do that, which will
have some bearing on the answer.

> However Git behaves differently. When I run git diff, some of the
> output is literally white on light yellow background. It is like "we
> know what is White, so we ignore your settings". And it is quite
> irritating.
>
> Is there a way to make Git respect terminal settings and not to
> override them with absolute colors? If so, please advise. If not, then
> I guess it is a bug to fix, right?
>
> Thanks,
> Irving Rabin
> Software Developer @Edmodo
> 408-242-1299
