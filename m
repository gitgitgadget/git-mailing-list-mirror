Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0112E20248
	for <e@80x24.org>; Mon, 18 Mar 2019 16:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCRQhn (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 12:37:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38875 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfCRQhn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 12:37:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id e10so10195790edy.5
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VL75488tZHUJVf4+riSjFhv+Yy9kWkLVXyccuTb/J4w=;
        b=Cpw6KSVWbdlNYZ5J/Vm8BIvLk3jCkvt9rUiShAJmpn0mExi6geVDIGD2bavhZ+06+g
         OAX8MTZ1ELGunVwRZS6PgXF2t93RpcboP+PP4buBF+PHuhC3nMV2q91/fxITtEArKJlZ
         x23YnlEMHdgF4wO6404TFAnNJ9LGgMZTEvLEG9GOqPPbWWHs0a/nlVRb2AKBsZDHoiWt
         0hQcLtjZgvbXfQYyOj8IWG/9YPCc8dao/lGqpj15muIi9yndD7kwfMFAd1NPnAV7Z2NJ
         blW3m+rsxatCRJf3l8bJ9mEIVGPow+16aa2WIPWaNk9Zt7fb0Y0EJWfPFzXSFdVW8l9K
         KnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VL75488tZHUJVf4+riSjFhv+Yy9kWkLVXyccuTb/J4w=;
        b=dWBZd+Rq1A9pC3oMNyz+Tn/YJbNhX1XjB6O47HquZg9UBsNDJFUxqtWthPBYWfIBc0
         ab/tbqpBTyeAQ6ZUSyPRFB4mwKTiz9i+e3ckPwyqm9BNjrY1u8RO95qkP++RzXFNmhFA
         yt6nKgkt9YXFFnBxMzV8LWoYw+ojpldzXSm+WFJjpxeBdg+Tj+FOG9hIZj9Sc1Fw+r6H
         Eux7OPz5LrkPSYM95b5wna/J+qZmAQiiMDrF1Ti82wcI15XYnEQ8jv4WA0m+RpbaDpsk
         yT3mIYz+SelXeOgr0N/Pi/Zg7HLjmhULIxf/Qqv84NzZ6u2cK8Rg/C6HNLD0ZAyV/wj4
         4L/A==
X-Gm-Message-State: APjAAAXFHFYt6Q75nWtEd2Jjh8wtiYAOxYzPxOnAUU+/Y5PaK1+DTQPw
        /9Qqv49dIOx/6TpOlJX5VOm4wjjM08b3IxxbcIo=
X-Google-Smtp-Source: APXvYqyMuP0289tkouSgvOSPpM/nEzvlwzo37tMvdntQX/rzItbRBGBv3gI22qWQhSTVtSCpaQckGAe33vXuDHlszhY=
X-Received: by 2002:a50:eac4:: with SMTP id u4mr13860385edp.238.1552927061690;
 Mon, 18 Mar 2019 09:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <CACsJy8DtoMMSu5Vm4+ZkeUqCOo7stM4HObLkiSc-nQQV4G=GvA@mail.gmail.com>
In-Reply-To: <CACsJy8DtoMMSu5Vm4+ZkeUqCOo7stM4HObLkiSc-nQQV4G=GvA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 18 Mar 2019 17:37:28 +0100
Message-ID: <CAP8UFD2uBqq9M7SB4KPzM2Am9G6dLOUjBs4sx3U69hK-bzonrQ@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 1:52 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Feb 4, 2019 at 4:17 PM Christian Couder
> <christian.couder@gmail.com> wrote:

> > Anyway feel free to comment and suggest improvements on those pages,
> > especially the micro-projects and ideas one. Pull requests on
> > https://github.com/git/git.github.io/ are very much appreciated.
>
> I'm not opening a pull request because I'm not sure if it's worthy of
> GSoC (probably 2020, not 2019) but anyway the get_config_* discussion
> elsewhere reminds me of this.

I think it would be nice to have a section with potential ideas along
with a big warning saying that the ideas there aren't  developed
enough as is and need much more work/thinking to be considered proper
ideas, but we are still putting them there to not forget about them
and in case someone would be interested to develop/research them
further.

> Currently we have two ways of parsing config files, by a callback that
> gives you everything and you do whatever you want, and with configset
> where you can just call "get me this config", "get me that one". The
> idea is moving most callback-based sites to get_config_ one.
> Preferably in a declarative style, like 'struct option[]'.

Thanks, I like this idea! Maybe it could be even considered for
microprojects, as I think it could be done in many small steps. It
would perhaps need to point to en existing commit doing already that
to make it clearer and easier though.
