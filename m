Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30EC51F51C
	for <e@80x24.org>; Thu, 24 May 2018 06:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935533AbeEXGkA (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 02:40:00 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:43998 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935439AbeEXGj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 02:39:59 -0400
Received: by mail-vk0-f54.google.com with SMTP id x191-v6so312012vke.10
        for <git@vger.kernel.org>; Wed, 23 May 2018 23:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Glk4hPgYAXI9A2hGyEfw+cdfCoz/jGnfVM3RAQzyPlE=;
        b=j4M3vYuFyQwAissmVzIKGi/otk8AOcIewcEE7SUaztr6l6xNFXqPXX+kpI+GPNUF4q
         PuK15ozcgTuOR5+lHtZCqpfXQ3+vbgSWXkORl65CSbxQc6sjcMpwf0tZeSdr8F7tL3mq
         N8MOlZ405AEZAkQh6n/keK5vw5zyWRo2NYnFoHzrDwJUBi8M1ZfWpAbvbla6lZb7cP2Z
         7Lkf2IdXP2lfjhJPEQh85zly1E/mu0HZzAYeckfM+ebpV5bdXyIR1r/z+xMm0d7JiR9s
         fYVFi5a+Z0wgwJUueZ+aotEPnoOj+9GADDJJr9wHEqSkJjtUji9GfVJzofEmWNAzAMPM
         oFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Glk4hPgYAXI9A2hGyEfw+cdfCoz/jGnfVM3RAQzyPlE=;
        b=lo67M6gZwFQyJz35jDjFFCELfuLFatmitTHi0yfsDh9lEDt9j+uGzoYoIfUoFDenod
         ir405gJg0z7agUhS3dqPb3lEt6tAcCxJl5HoaiDRn3FCO2YO2e9RXHHyhbhTSm8NfBdO
         /ZoEgIgciZmBMGspKL7aZn9g9rYn+cLhTlWn0ktsuy8crtM47Yi+z4qDPcup4rLE/QwA
         seqt285I5jQk/r5BbfV2zOOLPco/BH9Hd8PbjTh3pANEL/lxqiiIenUa0uKzwjTiadpA
         9aBfaf2C0T7FW6vjsml9wleYrAOVh3OiJUUm08k08k1TQbNxVJd1tNtqsWuOeGYTr8/O
         hQ4w==
X-Gm-Message-State: ALKqPwfJkQMwd9XOgdjpXLjGUGXpWeD+zy4ghJV6Du6CkvVmMDxZRCR/
        xaaGSLIA8p68eys6gMQ5OKMYSL3rWzia+SKoAic=
X-Google-Smtp-Source: AB8JxZrWy1FOIvl1/WfilCgavs4zUEanotG8L7J4uPuxwbsmfKGlQ8JqWJ1IGeg0/bOxpre4lP9Suf4kbbDt9PDaVoI=
X-Received: by 2002:a1f:c155:: with SMTP id r82-v6mr3790330vkf.76.1527143998630;
 Wed, 23 May 2018 23:39:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f04:0:0:0:0:0 with HTTP; Wed, 23 May 2018 23:39:58
 -0700 (PDT)
In-Reply-To: <xmqqwovtudia.fsf@gitster-ct.c.googlers.com>
References: <xmqqwovtudia.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 23 May 2018 23:39:58 -0700
Message-ID: <CABPp-BHrzaJ4O0WXJM2YhTMzSx-6nxhHTi4VmL0xXph0ts3Msg@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2018, #03; Wed, 23)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, May 23, 2018 at 5:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.

I don't see the series posted at
https://public-inbox.org/git/20180522004327.13085-1-newren@gmail.com/
(various merge-recursive code cleanups) -- or its predecessor --
showing up anywhere.  Did it slip through the cracks, by chance?
