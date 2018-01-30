Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E610A1F576
	for <e@80x24.org>; Tue, 30 Jan 2018 11:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeA3LH1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 06:07:27 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54178 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeA3LH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 06:07:26 -0500
Received: by mail-wm0-f66.google.com with SMTP id t74so275998wme.3
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 03:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9ABgFpVoH7ej5lJarK9MB04ZU+sEnxvX4VaU0GBxCxA=;
        b=F35NW5/6PoPaKuPujnuLhBQ62Kdn8NslorwPvQDPT4Fb2NLABOXJ5M9xUpIGcCdLdl
         P5cmw6zTLYKf6pU5tidSkBjqToCPRBSfTn+n7Tk/Fvb2lI3JFK9V4bWor39UzQoHmX8t
         +sCOBMXypcw5P8cOcc1quSQ6Epm8Ud6m+Y3qrYcpg++DXWFULhpVxT3Lqe4Zr3yI2k5k
         a6eAJ171uXsho0bS/WKUeMfZ1LC426hWcdMLnYLDEatugpaKc6R1Vg9nq1hvr0XLTi8Y
         ojBAbseGQEK+ViIfialMGYtqfVwHZamRVZ/Da1wwI2Jt5jCNtx01Eayw+xUaPYWWJr/k
         I/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9ABgFpVoH7ej5lJarK9MB04ZU+sEnxvX4VaU0GBxCxA=;
        b=K2pGrOpGKWRyyl/w8q+SxkVn43ZAjjrmfszYeJbZ0aYMZ7NedUHX+hlMUtDh66rqwq
         Y8uT48DphtkJ30M06VdpiYooYayi+BEiEFiubGCyjjsf5qpP+gxJ48KvcK1ajzYMEae1
         RQ2hjXEF/NYKUAoksai6wE+MyZslR5JA1oCoRTKmqBB9oUUPxUP7ls0t/pzZUftlOpVC
         TGq9OkdtG1sg7Mdhatfy4/xI9IixlYePuZvMb/uoHo4xrzgq87QVuTVn07lLFIF/GBhT
         vwwgJdiiVncKDIYgHTiDS0mOQkbJTJe3W4E00VgyLzdZB86znTtYLCznNLOIKEZsfrYe
         9/bQ==
X-Gm-Message-State: AKwxytekqkaPOMIMKYb07zWwTDOppWsr3NzYZmwtLv660kHsvMN8C+v7
        7R7bQgrFa2lMQuGgDUMbvwg=
X-Google-Smtp-Source: AH8x226BuYJhQT2/9HZ7U6OdfJj2NbivsRQH4dK3gD9oxn16JFiw05S6LvvkBaeuEpWQdz/oMd0piw==
X-Received: by 10.28.192.24 with SMTP id q24mr21588127wmf.96.1517310444772;
        Tue, 30 Jan 2018 03:07:24 -0800 (PST)
Received: from evledraar (a83-163-48-134.adsl.xs4all.nl. [83.163.48.134])
        by smtp.gmail.com with ESMTPSA id m11sm4895619wrf.75.2018.01.30.03.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 03:07:23 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Jack F' <jack@bytes.nz>, git@vger.kernel.org
Subject: Re: Missing ? wildcard character in gitignore documentation
References: <903a193c-0360-59bc-4d86-6470ac8dc1a8@bytes.nz> <000f01d39918$70009eb0$5001dc10$@nexbridge.com> <20180130101351.GA761@ash>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180130101351.GA761@ash>
Date:   Tue, 30 Jan 2018 12:07:20 +0100
Message-ID: <871si7ob9z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 30 2018, Duy Nguyen jotted:

> On Mon, Jan 29, 2018 at 10:47:10AM -0500, Randall S. Becker wrote:
>> The implication of support for ? is there through the following paragraph from the gitignore documentation:
>>
>>     "Otherwise, Git treats the pattern as a shell glob suitable for
>>     consumption by fnmatch(3) with the FNM_PATHNAME flag: wildcards
>>     in the pattern will not match a / in the pathname. For example,
>>     "Documentation/*.html" matches "Documentation/git.html" but not
>>     "Documentation/ppc/ppc.html" or
>>     "tools/perf/Documentation/perf.html"."
>>
>> Of course you have to go read fnmatch(3), so it might be good for
>> expand on this here :).
>
> I agree. How about something like this?
>
> -- 8< --
> Subject: [PATCH] gitignore.txt: elaborate shell glob syntax
>
> `fnmatch(3)` is a great mention if the intended audience is
> programmers. For normal users it's probably better to spell out what
> a shell glob is.
>
> This paragraph is updated to roughly tell (or remind) what the main
> wildcards are supposed to do. All the details are still hidden away
> behind the `fnmatch(3)` wall because bringing the whole specification
> here may be too much.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/gitignore.txt | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 63260f0056..0f4b1360bd 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -102,12 +102,11 @@ PATTERN FORMAT
>     (relative to the toplevel of the work tree if not from a
>     `.gitignore` file).
>
> - - Otherwise, Git treats the pattern as a shell glob suitable
> -   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
> -   wildcards in the pattern will not match a / in the pathname.
> -   For example, "Documentation/{asterisk}.html" matches
> -   "Documentation/git.html" but not "Documentation/ppc/ppc.html"
> -   or "tools/perf/Documentation/perf.html".
> + - Otherwise, Git treats the pattern as a shell glob: '{asterisk}'
> +   matches anything except '/', '?' matches any one character except
> +   '/' and '[]' matches one character in a selected range. See
> +   fnmatch(3) and the FNM_PATHNAME flag for a more accurate
> +   description.
>
>   - A leading slash matches the beginning of the pathname.
>     For example, "/{asterisk}.c" matches "cat-file.c" but not

When reading the docs the other day I was thinking that we should
entirely git rid of these references to fnmatch(3) and write a
gitwildmatch man page.

One of the reasons for why fnmatch() was removed as a supported backend
was because it couldn't be relied on as a backend, so it doesn't make
sense to be referring to that OS-level documentation, wildmatch also has
other features.
