Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42A761FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 22:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbcLFWaL (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 17:30:11 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36780 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbcLFWaK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 17:30:10 -0500
Received: by mail-qt0-f178.google.com with SMTP id w33so360824907qtc.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 14:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U1wF3/kgNsQq3I/989wEd5eWtmB7PcAtIFl2i1E+9XQ=;
        b=LVS2uR5Z0kYAIapln7270K+kDB9cM0OzrVz8+TGuj/U4z0D2YCjuYtESqOlhyFmLn9
         oqEup7bp/cr/Ki6yYMmwKV2yUfqW7An2NAC/T0Ja3mNSVPuZCwJz9mBzdnDyW50+xZ43
         0rpBbivYWWBX4BBrvDIVCFyxeULGdZlXA+GPcdiXGxVx+pBJ2MKKetxuPvEdCG0M1+6+
         TT22TsQWWbHRPuu87wCkxjD0wAD2yCZVpxMRlExHH4DiFI5I5uiRe9dBrkHblAtaKfBk
         kyKR93Ka9b60Kt2JxHM5/Z9x2rgGn0qmtpuarSOd92RaxyKg8FvJp/BJqsMRVlgb/T6W
         XcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U1wF3/kgNsQq3I/989wEd5eWtmB7PcAtIFl2i1E+9XQ=;
        b=i6hsvpq5q3iZ9Kyd2X0IiGhD8No1pxg1PWm8biSC0Fc4ijPV/urIdnBlClmNgFaSF+
         2Kn4xGeO0Fh+F44CdXsTDWbbDmRtDQOVF93HK3cb1nFTEVy6+Dc3OzOGR3tzFRW3s1/U
         BnfwurwjA913SvipvCdx+Ci892dNsLYxk40bFk9TtIbJtC+PU7a9EXIEkskY5J7JrN7K
         +7fP5Z6XvCXxghwu1YTJPMN0GgH/0emwf0d6U0gLLtx/IXYj9I1qjyled34ar/WipziQ
         b+/QCv4R9wYEXJj5XaNkUCyvoJqpDrR9LBGtmI8P9f8/AvHZoE1R4OaoxFTweF60xPZF
         iTyg==
X-Gm-Message-State: AKaTC02XzUPu+nChhUkYjXj9Y7FAaRE+wDnCUpTGHBQWN6EM0r4bExzt0vDpPd1VoTZlHGbun0z5CUO7TICwXecb
X-Received: by 10.200.49.235 with SMTP id i40mr64172304qte.170.1481063409584;
 Tue, 06 Dec 2016 14:30:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 6 Dec 2016 14:30:09 -0800 (PST)
In-Reply-To: <1481061106-117775-17-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com> <1481061106-117775-17-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Dec 2016 14:30:09 -0800
Message-ID: <CAGZ79kaQNQPYudRLEz8-7NoggsM+um2mmhX+9CZQohdUfmp2tQ@mail.gmail.com>
Subject: Re: [PATCH 16/17] pathspec: small readability changes
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 6, 2016 at 1:51 PM, Brandon Williams <bmwill@google.com> wrote:
> A few small changes to improve readability.  This is done by grouping related
> assignments, adding blank lines, ensuring lines are <80 characters, etc.

The 'etc' sounds a bit sloppy in the commit message.
Maybe s/etc/and adding proper comments/ ?

Code looks good.
