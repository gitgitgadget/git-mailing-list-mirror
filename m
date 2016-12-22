Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190231FF76
	for <e@80x24.org>; Thu, 22 Dec 2016 09:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755476AbcLVJtU (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 04:49:20 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:35998 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbcLVJtT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 04:49:19 -0500
Received: by mail-it0-f54.google.com with SMTP id 75so96732024ite.1
        for <git@vger.kernel.org>; Thu, 22 Dec 2016 01:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bqAglfC+a6gjAWFoQmnpCZaFsG8OHMk+y3jwyHNaBfY=;
        b=fD+8rXwc8GIFfGZkdotqPoKMyizAPzW9Zf9z9nbOAvCaq/W1hMS0ncUFZ/d0OYf2pV
         VSRypQpUlP+B7bEc9PY4Wb1LKX0fHiktzDGz5GzBesMt3UnAPvHhHH+Bjdwx+K4tD+y5
         m4YSTXv6O+HlcfcXmjxifJJinXhNEazi2a+B9n3pvsPzUTHh3ukuKMtafZpyVASmVITn
         rgDRNA+KS00zXv4c+ZYwnSJOgEuFKCKM5qW8CHl8yd7QjWoEorUAQKT3HociGIgZptRb
         UmEVVR4rufIpAaWebJM8IPjzRmSqfCiRPMQYTNvLZeu6Cj7b/S6JzdeHcvNBoHiLpuDe
         wbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bqAglfC+a6gjAWFoQmnpCZaFsG8OHMk+y3jwyHNaBfY=;
        b=eX7N1Zh6ZoDUNPmwnB1zszqSp+LFZws+YKOI9dN8klCbKDSRNiNLsrgE93WG4cu7kB
         jJoKZUVp3Rx6zQjRAESANuqbAi312K1+42eF7oLKI4Eev3ibJMeLWtBmX1THS+EGpmMi
         0LqloIMPRWd4bbaDX7fmesKS03LkH8yRbUhF4DvINZ5p/xbcQF6Mjq0/87YBWCsWMlgz
         Uyy0sM/7GaYG63J5FE+meFeAqNXmjW1nsi3PQRvPEWoUgoiuDLNWf1LHYKUfOjqgl7/q
         o4kQSEoGtB0aWXFIU88/ktwU/EiPKMOL2ZZgYHyCwUQWjeBFq8fKnewDtgS/Ox/I5rOT
         Zpcg==
X-Gm-Message-State: AIkVDXIUoAi+PzH9xyv1SZP3pk++uAfwTImp7U2LP26Lxh2FS5xDQmJJZO6Eyy2IeDcZq5spgLJbZxg5knwMog==
X-Received: by 10.36.66.76 with SMTP id i73mr9272964itb.50.1482400158591; Thu,
 22 Dec 2016 01:49:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 22 Dec 2016 01:48:48 -0800 (PST)
In-Reply-To: <20161220165754.hkmnsxiwbcgn6uin@sigill.intra.peff.net>
References: <20161220123929.15329-1-pclouds@gmail.com> <20161220165754.hkmnsxiwbcgn6uin@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 22 Dec 2016 16:48:48 +0700
Message-ID: <CACsJy8CnS1=_vA5xhbZ94Qyh7ySC5FvaALu1vhQwt_YJya4wHA@mail.gmail.com>
Subject: Re: [PATCH] log: support 256 colors with --graph=256colors
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2016 at 11:57 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 20, 2016 at 07:39:29PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  I got mad after tracing two consecutive red history lines in `git log
>>  --graph --oneline` back to their merge points, far far away. Yeah
>>  probably should fire up tig, or gitk or something.
>>
>>  This may sound like a good thing to add, but I don't know how good it
>>  is compared to the good old 16 color palette, yet as I haven't tried it
>>  for long since it's just written.
>
> Hmm. At some point the colors become too close together to be easily
> distinguishable. In your code you have:
>
>> +     if (arg && !strcmp(arg, "256colors")) {
>> +             int i, start =3D 17, stop =3D 232;
>> +             column_colors_max =3D stop - start;
>> +             column_colors =3D
>> +                     xmalloc((column_colors_max + 1) * sizeof(*column_c=
olors));
>> +             for (i =3D start; i < stop; i++) {
>> +                     struct strbuf sb =3D STRBUF_INIT;
>> +                     strbuf_addf(&sb, "\033[38;5;%dm", i);
>> +                     column_colors[i - start] =3D strbuf_detach(&sb, NU=
LL);
>> +             }
>> +             column_colors[column_colors_max] =3D xstrdup(GIT_COLOR_RES=
ET);
>> +             /* ignore the closet 16 colors on either side for the next=
 line */
>> +             column_colors_step =3D 16;
>> +     }
>
> So you step by 16, over a set of 215 colors. That seems to give only 13
> colors, versus the original 16. :)
>
> I know that is a simplification. If you wrap around, then you get your
> 13 colors, and then another 13 colors that aren't _quite_ the same, and
> so on, until you've used all 256. I'm just not sure if the 1st and 14th
> color would be visually different enough for it to matter (I admit I
> didn't do any experiments, though).

Yep. If the jump sequence is a random one, we're less likely to run
into this. But I think Junio's "run git-log in 2 terminals with the
same coloring" convinces me randomization here is not the best thing.

The best solution would be select colors per text line, so we can pick
different colors. But I think that's a lot of computation (and
probably an NP problem too). The second best option is have a good,
predefined color palette. We don't need a red of all shades, we need
something that look distinct enough from the rest. I googled for this
first and failed. But I think I could approach it a different way:
collect colors that have names. That reduces the number of colors so
we can go back to "step 1 at a time" and still don't run into two
similar colors often.

>> ---graph::
>> +--graph[=3D<options>]::
>>       Draw a text-based graphical representation of the commit history
>>       on the left hand side of the output.  This may cause extra lines
>>       to be printed in between commits, in order for the graph history
>
> I wonder if we would ever want another use for "--graph=3Dfoo"

I do. See the screenshot in [1] from the original mail. I have to
stare at --graph so often lately that it might get my attention before
other things.

> I guess any such thing could fall under the name of "graph options", and =
we'd
> end up with "--graph=3D256colors,unicode" or something like that.

Exactly.

> I do suspect people would want a config option for this, though. I.e.,
> you'd want to enable it all the time if you have a terminal which can
> handle 256 colors, not just for a particular invocation.

Yeah. That also means we need the ability to override/negate config
options, perhaps something like --graph=3D-256colors.
--=20
Duy
