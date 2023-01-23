Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E46C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 11:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjAWLEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 06:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAWLEd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 06:04:33 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628D117CC2
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 03:04:33 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id jl3so11000940plb.8
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 03:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip1t8y6DWIMkEiLUjD5452E0+X9BVgATV/95ZrJMjgQ=;
        b=WukRDLwxIZ0EVrImA/mv2cIvqVkHDULbYli0Gc4hJ9/VpXV/YO5Jc0Gs6WUYJ61n1v
         TUp4TbngLgRXhE/jn/yNoOQgFPTxb+J1vbx8snGCJvqfIyfp/7SEzFOBC7enhvonefeh
         85tCzWDGpKtcKfufGKkS8zjGX+FOFydG5han/XW6XRumpJXu7kMOepwjgFIn3Qsxqdme
         ZMuX/iR0ib7shKXJOUhY2tCx95YgrNqd2esEo2fmqmx34ovT6kWgKoeNiJPiIKvo9jM+
         x+GB3047sB0gZU+myNrVBJRm39JFcVxjLtlu1D2LqkbyhJ5MKFfJuvz8X433sWOatvIr
         9AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ip1t8y6DWIMkEiLUjD5452E0+X9BVgATV/95ZrJMjgQ=;
        b=kirJbYrA3e7d13F/90n3+iWyVuddWH0WbSXUoRrq6F2zAGdG61mPFs/p9g12DBQWEo
         lFMWHO0JlsSbLz6X5QvAb9eItnjAV1fjCMw9gM95KkO2ky1xN0JyHQaPMKY3wjffwzqa
         6vwS5wfKcbjE8Donxo+TX6/j+AtJG/Qs9G23+MpBxnTLPwsDqhR9qKbPgYUgmbTbwP29
         LVj+NyXbIOGkO+tmwt3ueYHaaawfGpJvAWe+JFdNKWe451Nb9LHuEL/LDuefBnEcnACB
         zLXRFXtcpp283carZRTJfr3RSIAwHW8kbwb1P9/X31djhTFr59wrQOR9HedImQLUtomn
         d4Ag==
X-Gm-Message-State: AFqh2krg2ifIqtoBBoPyrflQQXoVFHoKQTjSqi8Cpw7Nkrp1MHJmrNcU
        Mu62/cSIFbYoJ9LbEtE3nZjHX8l1HodHJBfIi2c=
X-Google-Smtp-Source: AMrXdXvWdiOyjkBpXcbLhgbRk1ttgShmd0J+2ZBMViZExXwsY67CjHiTu10IoujK6M7xsh9QdhTUqN4ZGTVVyg0ggSQ=
X-Received: by 2002:a17:90a:4dcd:b0:21a:1a66:cd91 with SMTP id
 r13-20020a17090a4dcd00b0021a1a66cd91mr2539010pjl.190.1674471872955; Mon, 23
 Jan 2023 03:04:32 -0800 (PST)
MIME-Version: 1.0
References: <20230122165628.1601062-1-rybak.a.v@gmail.com> <20230123090114.429844-1-rybak.a.v@gmail.com>
In-Reply-To: <20230123090114.429844-1-rybak.a.v@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 23 Jan 2023 12:04:21 +0100
Message-ID: <CAN0heSogz0cdhVJdiZhCc2_fcHzJggPjbS0wCAQkRh1uZMxLig@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: render dash correctly
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 23 Jan 2023 at 10:01, Andrei Rybak <rybak.a.v@gmail.com> wrote:

>  highlighted with a `$` sign; if you are trying to recreate these
> -example by hand, do not cut and paste them---they are there
> +example by hand, do not cut and paste them--they are there
>  primarily to highlight extra whitespace at the end of some lines.

OK, so this is one of the new ones compared to v1. I can see the
argument for adding some spaces around the "--" for consistency and to
make this a bit easier to read in the resulting manpage (which can of
course be very subjective), but then I can also see that kind of change
being left out as orthogonal to this patch.

This v2 patch looks good to me.

Martin
