Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D5D1F407
	for <e@80x24.org>; Sun, 10 Dec 2017 20:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbdLJUdY (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 15:33:24 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:40769 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbdLJUdX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 15:33:23 -0500
Received: by mail-it0-f65.google.com with SMTP id f190so11292326ita.5
        for <git@vger.kernel.org>; Sun, 10 Dec 2017 12:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WXollm6AGz9HNO8DvEOAQDWRiIVv1zERkyVveApMlaI=;
        b=TMViZIn2PiVij0t+zzO8KB69icbC8UO/VCC19g+ucoKk3IfI/4iKHVMcGO4QaaXsps
         BBBueZ8o7vgkZIyGZ45/DVCBq3cKscQeti3ZY5kgFCHGakdinA+nx7SjyUq2QnGWc8ae
         sOZlL6PyLRc0i2zhFK5jT7wch39j3ZH2cG1hPpAfuYxiOIaRl5PWv2HugV9RoT6MpxAS
         A1fue6349blnh2Ddt4oiE7m4WlLprQDAGZh0W8/idFqH19nLMuAW6d+xz7JXsBU3kDQT
         E5C/frdXioaWb0Ijb6IAkEHNQbgQJ7Ht+rSn74ZWPmBxZeFrWPtGHiayrDzYM5oKdn08
         9VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WXollm6AGz9HNO8DvEOAQDWRiIVv1zERkyVveApMlaI=;
        b=kECOcI2e5k0hO2tEuBwPRkpKfUUIB1pb4YS/nfz79J61hJVNBHic/KFYltcimZcqxl
         Yncob3RkpEjqoUv91yJ9ryguoUX7FaL3Qt2OeLhezThva8pPEX1OUa8ysGOBx/+jVkYV
         2dfZHi+LGDg6t47sbeF2nZnVjFy0Vv+I/YpZYBqw/CSjwo/mc9JxTf4Sr/ZJfWgBpHir
         OyYKSWHwUpaDLNX+0G7LdT5OAQrzGMJENxSJcUSAld2DKsgzWUmMxFSHW9IMI949+JjL
         wvnAqOo9jiaDLtPBLCKQ2q/v54d5ikxz9msd0jaOCE+YK+eUfUXnZEnY0tJdOljecOjo
         OYtA==
X-Gm-Message-State: AJaThX4hJZt6DjM+UrpQYClTAYlYRfIKRYWF0CiyNyRVgYHxAGb1ROY2
        aJ3qDDqhurDDtIpUHQtwJMfTDw18I+LwewcY3cE=
X-Google-Smtp-Source: AGs4zMZN0sR9DqZwAnadQDcbZ1WCg8vb81V1AOBiPLPlB1x60h41IHPThuRLZja5yStcdWTjHiIkQSwLTg7FhvEw5nU=
X-Received: by 10.107.107.23 with SMTP id g23mr53972900ioc.283.1512938002565;
 Sun, 10 Dec 2017 12:33:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.19.167 with HTTP; Sun, 10 Dec 2017 12:33:01 -0800 (PST)
In-Reply-To: <42367c9f-debb-8ea2-e1ea-1ca513853ded@ramsayjones.plus.com>
References: <42367c9f-debb-8ea2-e1ea-1ca513853ded@ramsayjones.plus.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 10 Dec 2017 21:33:01 +0100
Message-ID: <CACBZZX7+tTCNrLQzjh2dP-bnty3BegpaO+xrUqJQ7_Nh22JyDw@mail.gmail.com>
Subject: Re: t9001 failures on 32-bit Linux?
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 10, 2017 at 8:58 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> I noticed the revert of the 'ab/simplify-perl-makefile' branch on
> top of 'pu'. So, I fired up my 32-bit Linux and attempted to see
> if I could debug this t9001 test failure.
>
> Unfortunately, I could not get it to fail. :(
>
> Both of the 'pu' (@77e921d77d) and 'pu~1' (@cfef1ebefd) builds pass
> the full test-suite and, likewise, running t9001 in a loop for a
> count of 100 (about 45 minutes run-time each).
>
> [If it makes any difference, I don't have sendmail installed (no
> /usr/sbin/sendmail or /usr/lib/sendmail), or any sendmail in my
> $PATH.]
>
> Sorry I couldn't help with this! :(

It's a bug in my patch, I'll follow-up with a patch once I figure out
what it is, but for now I wanted to say it's my bad.

That this is failing has nothing to do with 32bit per say, but that
system doesn't have Error.pm installed, so we fall back on our own
copy, there's some bug in the new Error.pm fallback logic I
introduced.
