Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 106A01F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 08:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbeJJP2t (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 11:28:49 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:33076 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJP2t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 11:28:49 -0400
Received: by mail-wm1-f52.google.com with SMTP id y140-v6so12784785wmd.0
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=R+KWpaSuhD2nUKJNKNBecBs7mNncDwEgVL5oJ739+RE=;
        b=RZ/aLCowj8U4+LlYCRI+vwyHOJ1PLI4VXrFn2ZcKiUlrnDduuMR9kcJ5yBi9ZrCHSQ
         Z7VRLbVvzzLzQm4aXv6uszfy4sLBxZZGvjiViOXZ81F9wjciBdpwAMdEvUEVp6fgj3sf
         jOBZ3K1uNw2JHaIvT22ApAnFnYSu4Fn9uBbDx8yXnu5Tk2h6o/280YUF0nXGZrMMLMCE
         1XwKZJROMVvyxJIh2gdmOth/ui9+dxi1aDq7LiHW64C9vWYgHdssjgj+Xk+82pbfnrIV
         cqOKEQU6HzN1yurD72sQH+MJ1Lqv0gvCrl4nFjwizAuO5EQvQr+dKoU9sQvTzPR6IRGR
         g+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=R+KWpaSuhD2nUKJNKNBecBs7mNncDwEgVL5oJ739+RE=;
        b=bsvARnqSrLi+1Q9/Qr13UUvEhSSryS6u13FItcwJ+d2LkNTbWQ9V9PKr0N0hq0RQzl
         iC5mslWlMW86e12gb+NJ/j8UCRitvae4rUZe5+tm2pQ2SgyATfJfOyAPrJMHSR9Byy3j
         Bmb4ENbXT0+4RTEmzA7cRZ691Dkc1W+6DrjRcuBlCQUCaM/+eFFNVQiM62viikP1nql8
         eyqjdz3QuA+lAfSwrxr2Kqm6Ie8vh4LG/6Gg86ZvZVIyoNn2ts1TSwHTvewO9ZxD4jJA
         O0Hgm/eXvISgGfeKILqOA8w30RnVxbO8yS3iZKjB1wTr8LrY3xdTegj2OzEL0M5X4NXB
         OT1w==
X-Gm-Message-State: ABuFfohaxoqj2d534A1LFpjSoVLNrBfbYk3BjdUB7k9Vy9lDQJACklea
        CkNcsv847KtDixWlfY9mFkyRDeBb
X-Google-Smtp-Source: ACcGV62XjDewJlM/aZqrRkeYs1h7w8TKW+eL3F0knBtuw8HqLus/iLLZlKNv9qdpW260wV0l2pUVuQ==
X-Received: by 2002:a1c:14d1:: with SMTP id 200-v6mr4762963wmu.106.1539158867263;
        Wed, 10 Oct 2018 01:07:47 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id a18sm16964577wrx.55.2018.10.10.01.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 01:07:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thiago Saife <tsaiferodrigues@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Translation to Portuguese
References: <CAOO0rQKZ6rgH136oOhQ+LCgptv-RfKXMpTTrC86EUExABgg-Lg@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAOO0rQKZ6rgH136oOhQ+LCgptv-RfKXMpTTrC86EUExABgg-Lg@mail.gmail.com>
Date:   Wed, 10 Oct 2018 10:07:45 +0200
Message-ID: <87bm82fcmm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 08 2018, Thiago Saife wrote:

> Hello Git Team.
>
> I would like to help to continue the books' translation to Brazilian
> Portuguese and I don't know how to proceed. Thanks in advance for your
> help.

That would be great. Have you seen
https://github.com/git/git/blob/master/po/README ? It describes how to
create a new language. Also CC-ing the l10n coordinator, Jiang.
