Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 893C420A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 14:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbeLKOr1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 09:47:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36756 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKOr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 09:47:27 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so16647550qtn.3
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 06:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JEkMDcV8lkS4fy2LaafKmfVrBap0cyHc9KFbYBES5SA=;
        b=l+Z3DrMCoQHPhNI1mA7w839EWt7JY7SSM1ocHqQFYg8IBWfYipjUtN4MIU7TxrKfAH
         1D6IqPdVdK+WDhbkdA3LyQACQTad5a5cgh4N8xhnPt3H+v5mFlSGme3v43zrYqTVNh5A
         y9s2P3ElpWTOr6Abi27RNxy1PnMEqfNzqhWcLjcERwv+c7H+0E5PnX67PKcPuOuk8wzQ
         GouTbv6Bo8dNVfgmGpwzJwp5VB4HphjxdWjuDAEkE/wsvvlJykUEAWE1HBHi7ih3SSer
         z8iChWVQP88Z7wCVSxUMemsmC7nbOaTMiZIawTdakpVzoXaNZ0Nvl6vot8EMRostXIGf
         neMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JEkMDcV8lkS4fy2LaafKmfVrBap0cyHc9KFbYBES5SA=;
        b=eSik016qQbZiIYFkwZlQxT2nx6WcODZKZnn6vC/o8G5KTGizgJKjWOXmIME1r0xnh9
         c9bpdJlbEjf2mrnq81hbh8/s6GEqYYGWjX8XPcaF95T1YZZ08jVpE+ZYCDuHUOca2480
         bl2aB/yutsm0e40hIg1PXk/S8WRU8GirXiG8gX32pGnfF4lpVBimt2zp9tUsIqacRoRh
         BNRSzkQjwzFJDSZ5U3WD4ienK4syI3mt+iblpLdOfbW/3R95IWVORA3Tn5tzh4iDugxR
         LaURwRDU5nlEteXwikz7TtWYKw307RlL2pP+oQtiXeOYHN0dgpSIsYB90iD+liJKabMZ
         PWkQ==
X-Gm-Message-State: AA+aEWYw6TseHl6f4mB79t8dd9ntfKQDpzWBxLs9z+1S721Gtck0OqAy
        A4AXJZLsGROR0T9vyAjL8P0=
X-Google-Smtp-Source: AFSGD/Uo/VzussCojaZZBPsOKrB8ZgURoX6k8BhmvcaweDLrQHIdVj1OuFLxCxlMhgtiRUdjK/S9lg==
X-Received: by 2002:ac8:5509:: with SMTP id j9mr15479328qtq.287.1544539645463;
        Tue, 11 Dec 2018 06:47:25 -0800 (PST)
Received: from alaska.lan (cpe-67-243-158-110.nyc.res.rr.com. [67.243.158.110])
        by smtp.gmail.com with ESMTPSA id 86sm10373528qky.92.2018.12.11.06.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 06:47:24 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Difficulty with parsing colorized diff output
From:   George King <george.w.king@gmail.com>
In-Reply-To: <20181211101742.GE31588@sigill.intra.peff.net>
Date:   Tue, 11 Dec 2018 09:47:17 -0500
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <492187CE-2AC0-49CE-A09D-ABD4A51BE4C6@gmail.com>
References: <799879BD-A2F0-487C-AA05-8054AC62C5BD@gmail.com>
 <20181208071634.GA18272@sigill.intra.peff.net>
 <CAGZ79kbd=2_eHdbVYwmNoAYupwnP3YDn6nT0m=v1CL0AkWXk=Q@mail.gmail.com>
 <20181211101742.GE31588@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peff & Stefan, thank you for the feedback. For my purposes, I am content =
to rely on gitconfig to reduce the colors to something that I can parse =
without losing information. Since my first email I have found that =
`wsErrorHighlight =3D none` gets rid of the problematic extra green =
highlights in the `+` lines.

I still think that a config to differentiate log coloring from diff =
coloring would be worthwhile, as it would guarantee that highlighters =
are getting unadulterated lines from git.

I also think that bracketing every colored line with a color code before =
the space/plus/minus and a reset just before the newline would be smart, =
because then a parser can just parse line by line: if there is an SGR =
sequence before the space/plus/minus, then it would know to strip off =
the final reset. This is in contrast to how it stands now, where a =
context line (with no leading color) is ambiguous by itself; I have to =
remember from previous lines in the hunk that we have been seeing colors =
in order to know wether I should strip off the reset.

I agree that a machine-readable format would be nice, but regardless it =
would be useful to make the regular output more parser-friendly.


> On 2018-12-11, at 5:17 AM, Jeff King <peff@peff.net> wrote:
>=20
> On Mon, Dec 10, 2018 at 07:26:46PM -0800, Stefan Beller wrote:
>=20
>>> Context lines do have both. It's just that the default color for =
context
>>> lines is empty. ;)
>>=20
>> The content itself can contain color codes.
>>=20
>> Instead of unconditionally resetting each line, we could parse each
>> content line to determine if we actually have to reset the colors.
>=20
> Good point. I don't recall that being the motivation back when this
> behavior started, but it's a nice side effect (and the more recent =
line
> you mentioned in emit_line_0 certainly is doing it intentionally).
>=20
> That doesn't cover _other_ terminal codes, which could also make for
> confusing output, but I do think color codes are somewhat special. We
> generally send patches through "less -R", which will pass through the
> colors but show escaped versions of other codes.
>=20
>> Another idea would be to allow Git to output its output
>> as if it was run through test_decode_color, slightly related:
>> =
https://public-inbox.org/git/20180804015317.182683-8-sbeller@google.com/
>> i.e. we'd markup the output instead of coloring it.
>=20
> Yeah, I think in the most general form, the problem is that colorizing
> (including whitespace highlighting) loses information within a single
> line. It would be nice to have a machine-readable format that =
represents
> all the various annotations (like whitespace and coloring moved bits)
> that Git computes.
>=20
> -Peff

