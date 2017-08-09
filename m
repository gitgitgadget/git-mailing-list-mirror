Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA30208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 22:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbdHIWxV (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 18:53:21 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34280 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752244AbdHIWxU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 18:53:20 -0400
Received: by mail-lf0-f42.google.com with SMTP id g25so34087304lfh.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 15:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6FHVmNsZpQ8B3CZVBU4WqZt81ar0C8sgWHMcO4D0SAI=;
        b=btq8vVH4gkUYLod2DqhTbAzWDAeaLNDol7dO7ip/oim35g9OSU3nHRnytvvwfBahVp
         8LmkS32Y+1TAtfgTi5EaZdiADTJiuSjJNe4e/XSe/lCBdErLtxXMVaJTLf+kodeGrbpO
         lrZeFkOtM3LWcvG7cSFn6A0LzKPac163tn+geb8oURr11vvFo9CRKe2n2V4mTGbEDAVD
         HjwNt/ZMcPnv/K9sZmb7QqPaFR7AjbWzG2SHvZqq1hnSw5u0pWzwaScaJr4UiIReNzQo
         1WhNcvcJLushJgx7JVKJJRPKhnvSoi7VfmozH9o0Pi4Zkyc0Vx6Ye6FMo2L2tPRaZCDI
         9o5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6FHVmNsZpQ8B3CZVBU4WqZt81ar0C8sgWHMcO4D0SAI=;
        b=oHcoNMmUap8/EeycAfyaojKarg/teqtCrT1m32q9imuPR8eQbBBU7umVHfedJj3Jhh
         PmeMeshWaWC+hUJOa8gzHehqCY8i2V0idT0U3DuW3H+igVtqLklQ6CsoU1gglQmS3GEJ
         rCh9bPj54rUyU47n+71MDuwGAXKX5w77cY95gTmQ9c2dSxnHRDTPTxU6YZiPRRw/Y6z0
         f0bZ5+YdHT86z9U47rM9e/K52wFA+ClPnXsVL+f34YlMDX3nr9CcfPKB+ZGH4xxYiK9p
         lzsgMiWUXYj3Ki5BYM243Dx0c0hy5hwf42yriqdmJQ3R7HlOxfMqsiZdQQB9qZ+qgEXh
         H5BQ==
X-Gm-Message-State: AHYfb5htt0HTXtPeuVORWBelsWTu414wDN+Q0w/yx/ozwZfzhD02yHkd
        krBNWop4VuqK+ahMmiFaSpScUBfyNUBL
X-Received: by 10.46.32.41 with SMTP id g41mr2990391ljg.96.1502319198620; Wed,
 09 Aug 2017 15:53:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Wed, 9 Aug 2017 15:53:17 -0700 (PDT)
In-Reply-To: <87y3qsg7ni.fsf@gmail.com>
References: <20170808012554.186051-1-bmwill@google.com> <20170809130127.ekd4tvyp2rrb7ftk@sigill.intra.peff.net>
 <87y3qsg7ni.fsf@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Aug 2017 15:53:17 -0700
Message-ID: <CAGZ79kYEyebHxFO++u5RkPBj16xx5nMcahBPxra4xWUfMrXydA@mail.gmail.com>
Subject: Re: [RFC] clang-format: outline the git project's coding style
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 9, 2017 at 7:03 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Aug 09 2017, Jeff King jotted:
>
>> On Mon, Aug 07, 2017 at 06:25:54PM -0700, Brandon Williams wrote:
>>
>>> I'm sure this sort of thing comes up every so often on the list but bac=
k at
>>> git-merge I mentioned how it would be nice to not have to worry about s=
tyle
>>> when reviewing patches as that is something mechanical and best left to=
 a
>>> machine (for the most part).  I saw that 'clang-format' was brought up =
on the
>>> list once before a couple years ago
>>> (https://public-inbox.org/git/20150121220903.GA10267@peff.net/) but not=
hing
>>> really came of it.  I spent a little bit of time combing through the va=
rious
>>> options and came up with this config based on the general style of our =
code
>>> base.  The big issue though is that our code base isn't consistent so t=
ry as
>>> you might you wont be able to come up with a config which matches every=
thing we
>>> do (mostly due to the inconsistencies in our code base).
>>
>> Right, the reason I stopped pursuing it was that I couldn't find a way
>> to have it make suggestions for new code without nagging about existing
>> code. If we were to aggressively reformat to match the tool for existing
>> code, that would help. But I'm a bit worried that there would always be
>> suggestions from the tool that we don't agree with (i.e., where the
>> guiding principle is "do what is readable").

We may have different opinions on what is readable/beautiful code.
If we were to follow a mutual agreed style that is produced by a tool,
we could use clean/smudge filters with different settings each.

But I think we'd rather want to find the closest approximation to our
current style first.

>> I dunno. I guess "go fmt" people decided to just treat the tool's output
>> as the One True Way. I haven't written enough Go to have an opinion
>> myself, but it seems to at least work for them.
>
> (I have no opinion either way on whether this clang formatting this is a
> good idea or not)

I think it is actually beneficial as it is one less thing to worry about
as a contributor.  Maybe compare it to programming language that
has garbage collection built in, which is also a feature to allow the
contributor to focus on "what is important". (style is not, all it can do
is hold back progress by too much nitpicking IMHO)

>> What does the tooling look like these days for just adjusting lines
>> touched by a given patch?

$ clang-format --help

USAGE: clang-format [options] [<file> ...]
..
  -i                        - Inplace edit <file>s, if specified..
  -lines=3D<string>           - <start line>:<end line> - format a range of
                              lines (both 1-based).
                              Multiple ranges can be formatted by specifyin=
g
                              several -lines arguments.
                              Can't be used with -offset and -length.
                              Can only be used with one input file.
..

I would think based on these options, a pre commit hook can be
written that formats precisely the touched lines of code of each file.

>
> Presumably even if it sucked we could easily write a "./git-fmt-check.sh
> <file>" script to do it which would do the following:
>
>  1. Check out the master branch
>  2. Apply code formatting to entire project (or just the files you
>     changed)
>  3. Commit that on a throwaway branch
>  4. Switch back to your WIP branch
>  5. See if it would merge cleanly with the throwaway code formatting
>     branch (I forget the actual 'not a real merge but check' command to
>     do this, but it exists).
>
> If there were any reported conflicts presumably the new code you're
> adding is violating the coding standards laid out in this file. If not
> you're good.

This approach certainly works, but it *adds* one more step to what
a contributor may need to do before sending a patch. I think the intention
with a codified style is to *remove* a step (as a machine will do it for yo=
u).
