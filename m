Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2A98201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 17:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750952AbdKLRcO (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 12:32:14 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:44400 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbdKLRcN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 12:32:13 -0500
Received: by mail-io0-f194.google.com with SMTP id q101so896169ioi.1
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 09:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J68oeWpRKc45YtYHl4E5pWqUw0MmfScYK4XuiB+ZdC4=;
        b=Eh8W6S4+i9jdJJkAOrvbFgdzKvaPaA6c8YkCbUVIlwzMhWNdqOynuIsDWeGJsdWjTe
         gS8tGa/ejrpmEaYpMs4N3veYiJ9mZ8opga24pUEUjCFzCCyVMMcBP9fSLPxPp2mu2f+P
         S/uovHqUqmqjsNBQGwFnpJyFH65lRBBYMlozFtKp/wWuxYuURG6OabNlOoWY3dYXzzmK
         rG+YV9L/UWPeo+AejZ21uvQeLh16AWI23GN9sEpj4lOsqu16yF1Nbe894k1JqK0ndDT3
         0W5HWf1yC2ENYzQwRnToWYsRWJeeHm2O9MWOu4grekOrn83AAnCzWh+qSn9lVdWnOncb
         /O5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J68oeWpRKc45YtYHl4E5pWqUw0MmfScYK4XuiB+ZdC4=;
        b=CiEqyQJfn7r2CL34IN26YmongJ/QXUpGYHgnQJDxuzLxRX0+PJxxGENHWP36tGtAjV
         cHIp/9oumGaehCzAilQYLWwsUMkPUmHpKRX8IGPEqhJLeKJrJRGktbRguGMurn+elqKX
         4eijvYCtW7Z24/hRPZ22g4dg/CZbtve6y2vDA79OuObjV+BJ5nyjLmmqCSgj0E6eo5Rq
         UPX8qR+Xvkrpdvby54gpBlmvjzx1i6eEkFey24pr0Xrw0FE1J/YG/oK0ni9oyHLjLAtw
         wCI+Q3Jk6RRnZ5ULzdlpuggS7WHxBcdhHSKgTm21GrQ/pDgz7fEQLYLjTpjB+RjwENXL
         jfMw==
X-Gm-Message-State: AJaThX4vxgpJEPiP5jSfZPGRSoI/sHITmCKkdbria9YrIdJTyE9Jdks5
        xDqAo+z3lgnpxygTmdDPCEKLRhFllX4RYTkqkI8=
X-Google-Smtp-Source: AGs4zMZ7VBEz+iOVgZLrhpnK6LM/ZEum1Bl8fEV7yfNl+CrmNEW44rVgHx13poqkPyIl11T30mYwGYR8XAcNFqpDU1s=
X-Received: by 10.107.39.206 with SMTP id n197mr6912932ion.180.1510507932189;
 Sun, 12 Nov 2017 09:32:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sun, 12 Nov 2017 09:32:11 -0800 (PST)
In-Reply-To: <20171112115725.c2pjhpwpcjeh4xbr@sigill.intra.peff.net>
References: <b6b12040-100f-5965-6dfd-344c84dddf96@teddy.ch>
 <20170813045813.i42mgwn3dmm6u52o@sigill.intra.peff.net> <20171112115725.c2pjhpwpcjeh4xbr@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 12 Nov 2017 18:32:11 +0100
Message-ID: <CAP8UFD2gKTourXUdB_9_FZ3AEECTDc1Fx1NFKzeaTZDWHC3jxA@mail.gmail.com>
Subject: Re: NO_MSGFMT
To:     Jeff King <peff@peff.net>
Cc:     "Dominik Mahrer (Teddy)" <teddy@teddy.ch>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 12:57 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Aug 13, 2017 at 12:58:13AM -0400, Jeff King wrote:
>
>> On Sat, Aug 12, 2017 at 03:44:17PM +0200, Dominik Mahrer (Teddy) wrote:
>>
>> > Hi all
>> >
>> > I'm compiling git from source code on a mashine without msgfmt. This leads
>> > to compile errors. To be able to compile git I created a patch that at least
>> > works for me:
>>
>> Try:
>>
>>   make NO_MSGFMT=Nope NO_GETTEXT=Nope
>>
>> This also works:
>>
>>   make NO_GETTEXT=Nope NO_TCLTK=Nope
>>
>> The flags to avoid gettext/msgfmt are sadly different between git itself
>> and git-gui/gitk, which we include as a subproject. It would be a useful
>> patch to harmonize though (probably by accepting both in all places for
>> compatibility).
>
> I saw somebody else today run into problems about gettext, so I thought
> I'd revisit this and write that patch. It turns out the situation is
> slightly different than I thought. So no patch, but I wanted to report
> here what I found.
>
> It's true that the option is called NO_GETTEXT in git.git, but NO_MSGFMT
> in the tcl programs we pull in. So I figured to start with a patch that
> turns on NO_MSGFMT automatically when NO_GETTEXT is set. But it's
> not necessary.
>
> The gitk and git-gui tests actually check that msgfmt is available.
> If it isn't, they automatically fall back to using a pure-tcl
> implementation. So there's generally no need to set NO_MSGFMT at
> all.
>
> But that fallback is implemented using tcl. So if you _also_ don't have
> tcl installed (and I don't), you get quite a confusing output from make:
>
>   $ make -j1
>     SUBDIR git-gui
>     MSGFMT po/pt_pt.msg Makefile:252: recipe for target 'po/pt_pt.msg' failed
> make[1]: *** [po/pt_pt.msg] Error 127
>
> If you run with V=1, you can see that it's not running msgfmt at all,
> but:
>
>   tclsh po/po2msg.sh --statistics --tcl -l pt_pt -d po/ po/pt_pt.po
>
> So my takeaways are:
>
>   1. You should never need to set NO_MSGFMT; it falls back
>      automatically.
>
>   2. If you don't have gettext, you should set NO_GETTEXT to tell the
>      rest of git not to use it.
>
>   3. If you see msgfmt errors even after NO_GETTEXT, try NO_TCLTK.

I wonder if something like following patch could help, as anyway the
build will fail if Tcl/Tk is not installed and people often prefer
builds failing at the beginning rather than towards the end.

diff --git a/Makefile b/Makefile
index ee9d5eb11e..9789027739 100644
--- a/Makefile
+++ b/Makefile
@@ -1636,6 +1636,13 @@ ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif

+ifndef NO_TCLTK
+       has_tcltk := $(shell type $(TCLTK_PATH) 2>/dev/null)
+       ifndef has_tcltk
+$(error "Tcl/Tk is not installed ('$(TCLTK_PATH)' not found).
Consider setting NO_TCLTK or installing it")
+       endif
+endif
+
 ifeq ($(PERL_PATH),)
 NO_PERL = NoThanks
 endif
