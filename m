Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77C7E201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 20:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbdBSUjG (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 15:39:06 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33935 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdBSUjF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 15:39:05 -0500
Received: by mail-lf0-f43.google.com with SMTP id o140so27226327lff.1
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 12:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fzxaWpqg5Q9ED77WKB2UlbyFY8EzXl/lRC0qV62zP5U=;
        b=ENBUDu79mmnv+Ngo1yuKAK/Md6qTOpe0+n+B/2xptJrJmJiQSIpzhDTze2h37BbtU9
         CUSzlwRSp6HPDsEn5SyQlnckvFU6CvXY30sO7JMJtyS2++OmGDvEAWYAf3lwJZSTtFLu
         vPXwDZoLnk6S9ztAUWlJ/Hlgrlivl+ZGHPI9GaxAgJr7wHxA19KriGnzDeeqNSW6Uhy0
         cUU3xAiYKCHEwLDs1+K+kYlb5c8YQhkO4atT7lEZqA23QHpMhi94P0VWgGB67txR7iAM
         eb28e82Ri3wRQZ6EwcqsD+ys1zyDX9iOxRv2UMskXZpOoBbEw1O52SbQDFkBS+NQH3nM
         Bd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fzxaWpqg5Q9ED77WKB2UlbyFY8EzXl/lRC0qV62zP5U=;
        b=UUI+F0FU6DJK4wN7XkZsoQhlsr1vDpUiGtu3Hrj+q8djdZT4S1LbnkUVHyW/ZfVoQA
         EFNAVRdXt/cPSyv5cCy0Or7SOYJgSPj1pCsumQRc3F51O2ip/3aUOp9XAPfRmTaRWEYS
         6QKOBYfrDgDl2YQgBVSZe5taxdF1uedLYqU0HuDYiwQpylxLwrhX8vVgQ3s/CW1NT70/
         gJXB/lnrVCKnyJCy06UTleDl7P9g3NTsT8poPUw63mw0EpaPROW/h7XSnpS6dFmDkpS5
         YyQri4m7/YfKq7IsykfduE5TVvrqeNZ0WgIWR2gkW4gZmjusAhzAzPtF8MTyFAZ9AL9e
         5nIw==
X-Gm-Message-State: AMke39mB2+l31f5rIVoUoyPCUSkQXalgipDBgNTQo/tO/dG8ZE35AoxcNsRTCfbH/T6/1bYW0ySm7jw+ZPoIyQ==
X-Received: by 10.46.20.66 with SMTP id 2mr4538584lju.87.1487536665725; Sun,
 19 Feb 2017 12:37:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.204 with HTTP; Sun, 19 Feb 2017 12:37:45 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 19 Feb 2017 21:37:45 +0100
Message-ID: <CAP8UFD1NvR-djxpyY_85345DjHyj570rrXY-wt_GtWYSDLRwaQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 24
To:     git <git@vger.kernel.org>
Cc:     Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jacob Vosmaer <jacob@gitlab.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Erik van Zijst <erik.van.zijst@gmail.com>,
        Brendan Forster <brendan@github.com>,
        Stefan Saasen <ssaasen@atlassian.com>,
        David Turner <novalis@novalis.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        "Shawn O. Pierce" <spearce@spearce.org>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Charles Bailey <charles@hashpling.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-24.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/221

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Thomas, Jakub, Markus and myself plan to publish this edition on
Wednesday February 22.

Thanks,
Christian.
