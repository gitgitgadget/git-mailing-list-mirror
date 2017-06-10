Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9FDB1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 10:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbdFJKNL (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 06:13:11 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33549 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdFJKNK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 06:13:10 -0400
Received: by mail-io0-f173.google.com with SMTP id t87so20739409ioe.0
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=19EWwoBvuD7Tn+cP9v5UkAbDrRJ7h3IeJFUi2LUpEvo=;
        b=LaOPV31MwN/+445Nhtbdkezkdla9wgO0JVMqABJRp4/IbOmml6rdzddePoGTAgGZyR
         GYz6p+tjDn0hA42+DrNyW+bnCMxAGRubbi3IYZnHEv5ubeAUoT2H8P5UpP8/uZM9eDjK
         aP0ftPaUASckahCz+SX8m/14uReJvBFHB4hr1hSC+cm9eoVuYv9FFYbBwEihFYNQtTAY
         INTk7CMJamTm8PoYiYITSUhRYW0TTrUNRS3Vsg3bibR+IZEWhy20c+P/vr06rjB2viN+
         mCGnJKZCzeo+lAUUPBHxlevrcSo7Td/ltkSukCTw5c5w5NROdXsOirGqqDNV3NZelT7z
         oGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=19EWwoBvuD7Tn+cP9v5UkAbDrRJ7h3IeJFUi2LUpEvo=;
        b=tNqu41xl5sKZ54jL0uyq6smWJxwAZfYGI2DgEkhNL9QyVuv88zXSDfTBRcU3u8RTrG
         /OnNW2zBIKEbvCZ1KH9YZ1NQcbopOcQyGV8efpoTLVrD2amVYxIAjHMruoFkPQHXVCAH
         skkB3+JpZbQ3pkCXxaneTfFdPAuB00CkrVyc4M1STTJAIkTRv6vPTRhdBvNep6aSpgOi
         BIoYzhHEJSxuUYkx/WfZMILDpj56yw7CAdjhQRZg12xR//Xkmmllv0IMUVkQ6xwhG/XP
         5ikJ3htoYdTyGyKUM439iPibyFlWlxRFAMtzZb1qZlfTx+H306Poqb5QN0WYWXBdZ5At
         DJkg==
X-Gm-Message-State: AODbwcBAdQMSP761ziT3bSEj9Zl6nIrEx2ZwdfySrzg/7+Ux9LuVXaFE
        6So30cO+/LKi3Z7jcpiqIDceXHsOFw==
X-Received: by 10.107.181.73 with SMTP id e70mr13995065iof.85.1497089589118;
 Sat, 10 Jun 2017 03:13:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.72.66 with HTTP; Sat, 10 Jun 2017 03:12:28 -0700 (PDT)
In-Reply-To: <20170610082534.6437ifexzly4oqg6@sigill.intra.peff.net>
References: <CA+B9myHRahTd+FDgzK5AhXW+hq_Y_czMX9X6MXYBcr9WSPeiDw@mail.gmail.com>
 <20170610082534.6437ifexzly4oqg6@sigill.intra.peff.net>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Sat, 10 Jun 2017 06:12:28 -0400
Message-ID: <CAJZjrdXCHVKQOxR=+z5cOkieKzE-iSMta--kHVjSYXuansb34Q@mail.gmail.com>
Subject: Re: Feature Request: Show status of the stash in git status command
To:     Jeff King <peff@peff.net>
Cc:     Houston Fortney <houstonfortney@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2017 at 4:25 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Jun 07, 2017 at 06:46:18PM -0400, Houston Fortney wrote:
>
>> I sometimes forget about something that I stashed. It would be nice if
>> the git status command would just say "There are x entries in the
>> stash." It can say nothing if there is nothing stashed so it is
>> usually not adding clutter.
>
> I think the clutter issue would depend on your workflow around stash.
>
> Some people carry tidbits in their stash for days or weeks. E.g., I
> sometimes start on an idea and decide it's not worth pursuing (or more
> likely, I post a snippet of a patch as a "how about this" to the mailing
> list but don't plan on taking it further). Rather than run "git reset
> --hard", I usually "git stash" the result. That means if I really do
> decide I want it back, I can prowl through the stash list and find it.
>
> All of which is to say that if we had such a feature, it should probably
> be optional. For some people it would be very useful, and for others it
> would be a nuisance.

Perhaps there should be a flag for this if it is implemented, say
status.showStash?

> Do you want to try a patch? I think you'd need to find the right spot in
> wt-status.c to show the output, and then call for_each_reflog_ent() on
> "refs/stash" and count the number of entries you see.
>
> -Peff
