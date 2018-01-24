Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0213F1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 18:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964983AbeAXSLm (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 13:11:42 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:46982 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964953AbeAXSLl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 13:11:41 -0500
Received: by mail-wm0-f49.google.com with SMTP id 143so10087750wma.5
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 10:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j3MWGZdcMSBmunsSXcvOHDQ4AQ2m1ewmKwmpHuRupkc=;
        b=cXPcFZXvuO72OfSl/6c0++36RHVty3U6IoF6PfFdf7prhIpCiPk/kPLDDw6Pug86Gy
         q6j+fx8/L4Y/fW0k1WbgOH/9fL78UzO9YFiFjXbAKLhPMsWBaPd6N65rhGAP5QXVQbRu
         skZBNZTUa0sytuvwcCNprR5Eieysb88Nih6zkYi49FqQGgslEWpD9qaO+BiAfxky6aKr
         L8/4QwM5io5SJZPWTq1vBwSJdRXD5M4hLqErqIiM4CDE8rM+0y/HmdnAWzxp6x+sJnne
         h84I4mdwo1vIcBJ1d8LwAVDVvgmPafSmHqvGjbtPWyzd5+3hUiOEWUCmnciZ34v07885
         n/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j3MWGZdcMSBmunsSXcvOHDQ4AQ2m1ewmKwmpHuRupkc=;
        b=FhagH/eik0lF0j26Ij0XjO5cd57W26ohhhErYduTXs/TKEjiFjVfy4JoffeqQaNfUC
         HTPWj7BDjlAK2dr4u3OUtuJJcGSf3zQoByDo5vz8Ls9EQm3Va1o5493L+I/nlZEOS/Tc
         0lAWty5MEO+oyv5iunNAYLIV6bfExQnavUOzGv9U556eiLHCarMU3epVl/LUshthmd2J
         UMbtBcJobZYfGXsPVG4FQProRmxD+Nllwce7u98f93kuymB4QqZBVYpHVDun/WWNqLHv
         /Dxa6+BTWdJGJio4cAscGPBXgat2wpjNQR3pKSZzJUCFCObULmqkrk/DJz7Fa0xKTq08
         tPWA==
X-Gm-Message-State: AKwxytchAO3eH+UVSi4ZkYNbELJhu5n8LkxV17PiP5a9aniGi2r3vwVr
        pbmw9vjxIzfedeIM3x6Zzs89aVQbM/to/28byEE=
X-Google-Smtp-Source: AH8x227z7a5PuqRVN6gKOh3hKSSIXnSxGqEWbL1Hg8QfTDuIrtKdvy9Fs4APZXhb5qF1pehwUijiuov7qYuWTJl09GY=
X-Received: by 10.80.211.7 with SMTP id g7mr26282741edh.76.1516817500173; Wed,
 24 Jan 2018 10:11:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.177.180 with HTTP; Wed, 24 Jan 2018 10:11:19 -0800 (PST)
In-Reply-To: <CAG6xkCZn6m2n0rDvpN6MmZcOr2hJBRCfhrppC37f-DUj3_JZsw@mail.gmail.com>
References: <20180123001648.24260-1-isaachier@gmail.com> <CAG6xkCZn6m2n0rDvpN6MmZcOr2hJBRCfhrppC37f-DUj3_JZsw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 24 Jan 2018 10:11:19 -0800
Message-ID: <CA+P7+xq2eucumKT1VRymvnwv0KoauiYsmko-s=UAChoQ3X3w1g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Implement CMake build
To:     Isaac Hier <isaachier@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 5:45 AM, Isaac Hier <isaachier@gmail.com> wrote:
> I realize this is a huge patch, but does anyone have feedback for the
> general idea?
>

I don't know anything about CMake so I can't comment on the patch
itself. Having additional build systems does not bother me, but it
does mean that someone has to maintain the build system and try to
keep it in sync with changes that occur to the main one in use. That
can be problematic.

Personally, if we added a new build system, I think I'd prefer
something like meson with ninja, but that's only because of the
examples I've seen where build times were improved significantly. I
have no idea what advantages CMake would give on this front.

Thanks,
Jake
