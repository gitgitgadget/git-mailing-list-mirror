Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7211A1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 18:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbcLESgx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 13:36:53 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34846 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbcLESgw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 13:36:52 -0500
Received: by mail-oi0-f68.google.com with SMTP id v84so37704852oie.2
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 10:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=83z7SY1f6dWLDj65OJxY+2An6PDN4TruYMoa/UL/I38=;
        b=op7tmwlo17r3x3XMfSQZTn0PdT0+1i2ZcBZ52XpzJaIX+eCgI1zlcgwh+X+Ve0ElM9
         LtHD4DTOjBujCZdma/tKt6cynuvgrIZpBmhlQXtbDLmxx/oMo0Uk/OC4SkhalZxnCN4r
         Grdmws7sUyRDx5zs93em21RZQK97cEqvy0VZT+odWjr9y0rDxFexvuYmvzs/0hsZVUFr
         Okx3yQzzbz/7c58wfHywtFWXpJPPJuzq7JCgkfX+uSLs51zGJVumUwNShPDDRbsVB6/w
         uOpBlM4qkEye/efh4l9/lxFg30KfMtO7D5ougSAmO9S1MCj8nLpN3sSc6kxOzSwKOQ4t
         /vUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=83z7SY1f6dWLDj65OJxY+2An6PDN4TruYMoa/UL/I38=;
        b=Jx/18kWPvZQg1KyETQa0abZnfSehkBRqi7VMa75/JH62UhIsDSw7rihxOQX0XojBVY
         ufdZIhmSLzathgSn4pp9jtEh713aQuxbVHzgb++ZBtlrFsno6bBGXOGbof/lVt8agf3z
         74T0EO57rBh1h4TShhGGYGQG5+8WXABuOaMqDOekziYjCSG6DTAGDzcrzAQSDOyggmQY
         CqYNNfujx7znj8DuVcKqizVkmeaXgr43riVlMux3AVYPuzROyZnHvBy6yHGdjbHvYr2b
         MIPCqIut1SYhDDAbxqSP0O0MhIE0ps9q5jHog2yyL9nQqf+Wj9XCJ06k2MLI9rj6GArb
         5dnw==
X-Gm-Message-State: AKaTC02r3+lchLirWNKjsLmC8/RUszTpMFVnIYJSyfsjuzDy+0esJKnv9y2zzvuX/QYX5FOKqMOaVOTmVQwZdg==
X-Received: by 10.202.84.209 with SMTP id i200mr28854363oib.50.1480963011339;
 Mon, 05 Dec 2016 10:36:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.202.52.135 with HTTP; Mon, 5 Dec 2016 10:36:50 -0800 (PST)
In-Reply-To: <20161204204057.32dnkjx6ixv3swez@gmail.com>
References: <CANtxn9J9O+PADxpWa0JCcgwwk_tC5DuJGUruULN2fGP3knZ-Sw@mail.gmail.com>
 <20161204204057.32dnkjx6ixv3swez@gmail.com>
From:   Timon <timon37@gmail.com>
Date:   Mon, 5 Dec 2016 19:36:50 +0100
Message-ID: <CANtxn9K9tzmbea1Dx9Z37GNfA9QfCX0gm-XHjJxieJN6bc6D-A@mail.gmail.com>
Subject: Re: [BUG] git gui can't commit multiple files
To:     David Aguilar <davvid@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/4/16, David Aguilar <davvid@gmail.com> wrote:
> On Sun, Dec 04, 2016 at 05:36:46PM +0100, Timon wrote:
>> This is a regression in git 2.11.0 (version 2.10.2 is fine).
>>
>> In git-gui I select multiple files in the Unstaged Changes (using
>> shift+click) and press ctrl+t to stage them. Then only one files gets
>> staged instead of all of the selected files.
>> The same happens when unstaging files.
>>
>> Git-cola also exhibits the same behavior. Although there I could stage
>> multiple files if I used a popup menu instead of the keyboard shortcut
>> (I'm guessing it goes through a different code path?).
>
> Can you elaborate a bit?
>
> I just tested git-cola with Git 2.11 and it worked fine for me.
> I selected several files and used the Ctrl+s hotkey to stage the
> selected files.  They all got staged.
>
> If you have a test repo, or reproduction recipe, I'd be curious
> to try it out.
> --
> David
>

Can you try with git gui?
Though I guess it's probably specific to my distro or configuration.
I'm running 64bit gentoo with:
linux 4.8.12
gcc 5.4.0
glibc 2.23-r3
tk 8.6.6
gettext 0.19.8.1
openssl 1.0.2j
Not sure if that's helpful though.
