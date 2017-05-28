Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB1920D0A
	for <e@80x24.org>; Sun, 28 May 2017 10:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbdE1K3o (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 06:29:44 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:33854 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdE1K3n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 06:29:43 -0400
Received: by mail-io0-f181.google.com with SMTP id k91so28815851ioi.1
        for <git@vger.kernel.org>; Sun, 28 May 2017 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zn6FqlHEKAF5bVHFOdPOjkkhLLZqYwTWh895dvcXQ4M=;
        b=e1nVM68ahCeqF/XsGZIDtiItd6Urexi3S07wmXdB37EGOUYlwT+irTAKWbrlorrEND
         ptoqkp86eKZqvsUtsfo7tfqkBCq44NT1gew+QguTPt0NVwfS/T1rUN9LWSRY+gXEBRpJ
         r7J7YLDEJSFs9SgQuMOL7DZH9Z5rP0jAifVf72gkcW1BAQFN5bkFs8klGyhBIFOUCCGM
         NSpRVK5bK1PeiHtzVMtlqcftHFMe8CWxA6hyy/OQfvzWWQekE2fumsPvQ4Zo2rIJAbAm
         i+8Oau8MXzt3wpOiUf71ud/iuAywK22SVjwvvvYTWHGAyQGZNBo1hmXnK1lGoPHNvCNK
         fHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zn6FqlHEKAF5bVHFOdPOjkkhLLZqYwTWh895dvcXQ4M=;
        b=Ipc3Asl55px5n/7aUcwuROfrirANWhYRgJxfQrUk1vUTMpnvob7N/BB1OpJVdmD3hR
         kO5QWLQg1Pspxkf3wK2e3NZ7U0E0DLhDi1UfKlNlUdwA/ivTwyryuLClN103ydyG/5Tc
         l4vY887r9TOA0pUgmqMpoZlsmpUtDU3A+08Nb+GsElJEdO6vT3mDlN6Wp5GEs89ZY4At
         b6B4dM4CWjdKHb08F3QhNZoY/wmxOpXgf3uL/kSS6KSrwUotaPHX5Z0rlrA6a+jvL2Xy
         gh27x5tVSzDBe3qOlIzmrkQeePF7rz6EwRcAyH78Nv7QOgKpIRpLg4s+FE1nP8UOAQnU
         cfdA==
X-Gm-Message-State: AODbwcCfeZhfWDIGro9lOaJ5FXIym1LVH3PNwPsxFMJsxqxzVEa3qFAI
        lZkiKLadJWQIoGSRpZi97tObTULqPg==
X-Received: by 10.107.201.131 with SMTP id z125mr8274839iof.160.1495967382992;
 Sun, 28 May 2017 03:29:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sun, 28 May 2017 03:29:22 -0700 (PDT)
In-Reply-To: <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
References: <22824.29946.305300.380299@a1i15.kph.uni-mainz.de>
 <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com> <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 28 May 2017 12:29:22 +0200
Message-ID: <CACBZZX6zG0z90coXz_Xzqvdp+9LpJ4RE2dAJggfLL-nd0nkWVQ@mail.gmail.com>
Subject: Re: git-2.13.0: log --date=format:%z not working
To:     Jeff King <peff@peff.net>
Cc:     Ulrich Mueller <ulm@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 27, 2017 at 11:46 PM, Jeff King <peff@peff.net> wrote:
> On Sat, May 27, 2017 at 06:57:08PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> There's another test which breaks if we just s/gmtime/localtime/g. As
>> far as I can tell to make the non-local case work we'd need to do a
>> whole dance where we set the TZ variable to e.g. UTC$offset, then call
>> strftime(), then call it again. Maybe there's some way to just specify
>> the tz offset, but I didn't find any in a quick skimming of time.h.
>
> There isn't. At least on _some_ platforms, the zone information is
> embedded in "struct tm" and stored by gmtime() and localtime(), but the
> fields aren't publicly accessible. Which is why your patch worked for
> format-local (it swaps out gmtime() for localtime() which sets those
> fields behind the scenes). But:
>
>   - I'm not sure that's guaranteed by the standard; strftime() might get
>     its zone information elsewhere (if it needs to reliably distinguish
>     between gmtime() and localtime() results it has to at least set a
>     bit in the "struct tm", but that bit may not be the full zone info).
>
>   - Even if it does work, you're stuck with only the local timezone. In
>     theory you could temporarily tweak the process's timezone, call
>     localtime(), and then tweak it back. I was never able to get that to
>     work (links below).
>
> On glibc, at least, you can access the zone fields in "struct tm" by
> compiling with _DEFAULT_SOURCE.
>
> So I think the best we could do is probably to have a feature macro like
> TM_HAS_GMTOFF, and set tm->tm_gmtoff and tm->tm_zone on platforms that
> support it. I'm not sure what we'd put in the latter, though; we don't
> actually have the timezone name at all (we just have "+0200" or whatever
> we parsed from the git object, but that would be better than nothing).
>
> That leaves other platforms still broken, but like I said, I don't think
> there's a portable solution.
>
> Here are some links to past explorations:
>
>   http://public-inbox.org/git/20160208152858.GA17226@sigill.intra.peff.ne=
t/
>
>   http://public-inbox.org/git/87vb2d37ea.fsf@web.de/

There's a third and possibly least shitty option that isn't covered in
those threads; We could just make a pass over the strftime format
ourselves and replace %z and %Z with the timezone (as done for
DATE_ISO8601_STRICT in date.c), then hand the rest off to strftime().

I'm not going to pursue it though, Ulrich, are you maybe interested in
hacking on that?
