Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F77220966
	for <e@80x24.org>; Tue,  4 Apr 2017 08:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbdDDISP (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 04:18:15 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36855 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbdDDISN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 04:18:13 -0400
Received: by mail-io0-f193.google.com with SMTP id 68so14435466ioh.3
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 01:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HLAAgMNFX4c5+g0Kico8CXkBPTZeb6fqyq7iDUHZFp8=;
        b=EOKSB7rhIAO6ZeouZEBMpwVYW1YRefXDC0Y8qWUP5JQ7Tp3NJMS6SesxIUTa4J/UlP
         AxnlPLhSIGSfJqNTeU6Kq42Wx15Lw1k+yH6SYdwp6FRTE25NAgUsXZNmKS6zuGkBYj0w
         auXYQwFTCaiSz3SPBgJlZnYF0linkIoLW0Yy9iZT//r/jQKX2ENPisz8P6blEI6pryz0
         UZzCQKIbsV+OgVvCTvaCtLuuXL5jhH08LF6BZmfBhzL2pH6OEw82+SvjuBJ3ueXpanIn
         nKq7XQMT2bDHlJ73lf37sIJL5OX3rSHVAq/VkghhbqnatVGxm7V17bdEmmNVY6Hcay6+
         kLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HLAAgMNFX4c5+g0Kico8CXkBPTZeb6fqyq7iDUHZFp8=;
        b=hWQ8tiVAdC2JIKx/CSda57HCOn1IhQHhTvCvvEcTAf92pwoZsjX34pzyTtOmbaNwM0
         SyvQjsvOdaf2Ji3AYMT75k+T2xu/8d7BQ8aHbBRK+gEDE+HDJDyLL3QBk+mATe0W0h25
         V9QzCM84CA0J8dYJPcXYDSVipVPhlAjAZYWtDEVMSiwRdCmtlVae+b5GP0GfOnjrOS9a
         m62WtwAB/oqhiReCC+91uf50cdVp3UFVptmSXCVtZsZE+ArTnu/ATmwV7b4cv6WEFxJa
         He5ClDooYmqbhjvoUugCZCRAvWJFIZicAolLzJT7ShWzFh9rRvX6VNOcquhgWu3ePppZ
         nm7w==
X-Gm-Message-State: AFeK/H23f6RkFyrXQ1kfYdT3uwJvXZ1aGwMaBMXmtMrmNVEWmtbl9BlNFYcEMmkqPuUy9vVYUzZWDbtzdLxOgw==
X-Received: by 10.107.32.199 with SMTP id g190mr22591948iog.117.1491293892335;
 Tue, 04 Apr 2017 01:18:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 4 Apr 2017 01:17:51 -0700 (PDT)
In-Reply-To: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 4 Apr 2017 10:17:51 +0200
Message-ID: <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2017 at 4:54 AM, Jeff King <peff@peff.net> wrote:
> My feeling is that this is old enough to stop caring about. Which means
> we can drop some of the #ifdefs that clutter the HTTP code (and there's
> a patch at the end of this mail dropping support for everything older
> than 7.11.1). But that made wonder: how old is too old? I think it's
> nice that we don't force people to upgrade to the latest version of
> curl. But at some point, if you are running a 13-year-old version of
> libcurl, how likely are you to run a brand new version of Git? :)
>
> If we declared 7.16.0 as a cutoff, we could unconditionally define
> USE_CURL_MULTI, which gets rid of quite a few messy ifdefs.

I don't object to this patch, but just as a general comment, in
enterprise-y environments using an old OS (e.g. CentOS 5/6) & then
compiling some selected packages like git based on OS libraries is
quite common.

E.g. at work we're running git 2.12.0 compiled against CentOS 6
libraries, which has curl 7.20.1, released on
Apr 14 2010. Not so long ago we were still running CentOS 5 which
comes with 7.15.5 released in Aug 7 2006 which would break with your
patch.

Whether we support that is another question, I think it's reasonable
to say that if you're compiling git on such an old system you also
need to compile a libcurl instead of using the OS version. I just
wanted to point out that this *does* happen, someone is going to be
compiling new git releases on CentOS 5 & will be hit by this.
