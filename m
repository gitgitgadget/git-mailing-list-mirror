Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25321F424
	for <e@80x24.org>; Sat, 23 Dec 2017 08:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750800AbdLWIJQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 03:09:16 -0500
Received: from mout.web.de ([212.227.15.3]:52653 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750747AbdLWIJP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 03:09:15 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXYjm-1eVWQj3dOY-00WZJP; Sat, 23
 Dec 2017 09:08:55 +0100
Date:   Sat, 23 Dec 2017 09:08:54 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, patrick@luehne.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
Message-ID: <20171223080854.GA30360@tor.lan>
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
 <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org>
 <20171218101334.GA20685@tor.lan>
 <20171218131249.GB4665@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171218131249.GB4665@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:zldqms+BC+kQp2qkDwsB//iQkoeLOXPDgPs0Bo9+hL+PXHYGW4s
 HZ31oNnckiYMq7JHl/lqEtpDPB8bCnpGgkwbpSLS4+ek+LNeynk+P/wSqAi18kAEcSOor1m
 TErZ6FC3ZBQ4VqUNxlWeVTfG/ZlSgz6GxPicylxYnoU71UfPIC+8LTQcj7O3NuC+URe7ZTq
 wW+2tNdc/evBQqVW2pxTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YuPyCPEaMoU=:2wSY1jKoMusZlwIv9LBCEh
 CYp9BziWi7zXKynWS0XaCwV+dy9XE2SYTjva/sLJwJHE9l7b9dvSRRrXBvr40qArMpBPzUAxd
 oZEwFFex9QCAoyD9lXEoK/B9dYgLWyUEr6EpHHswBChx5IL7Txv6dfmRm8mvQAnmVOsEfKR7L
 RAsPvHeMQfflDyTtgCxHI1NOd7yuF/K3NCqDhxQfgi+O3PDIsBjUZ5FBBjQibrxV8TL/Qjd0p
 TWvc4qgMz9P+/FVl2SpBXohWFKNWgk5RCrRocmup1opnCfPPuBZFhjMjuW4rN5fZTvS83N913
 9KTQMR6D1Q0apt97V9egC9BqHfYrVIZr1WpkA+xW8zelxUefQ9Q1TjjS/ycHJ30NwT2C1EVi+
 TPsWSZFGoNVW8B2UkN6lrwWNuyoIDkoDwOp81FUbKQ96MJY8yOWUnQNnz44BKpjzqBVhLQkyK
 NYV5pMYkKHe/mZ3KnqvqKrDZqeyguNXx7VVq6xQdHp4sjO2G9iMKNLESug4kMBOLCoRt7amzc
 owepEMhFBG1BBt9O9PJy2ImbFudKJFKrzelnyFEPxyYQx4j2aE/tSbhauP75y9xK0VhwzvIwa
 1mhIi2YpFUMf/wRq8iptFrmGVFXGYiMWiLGRYuvk2HM32CVpq9h486u+7ig03/s8oZ2e03+Fa
 PN1lEEVRgcxYZZLlxt5miHMIHsIRfQ0F07JSPyUWEfhKwrucZzmlVtZGDQkkqGzUKAYcbXfTQ
 GS0TBfVrOsd2RSmfYACx5sspy/EZda2mlPlBV+GM8bCJDudgqknVJzh2Ek3d5gr/l2L9poqrx
 yVSER94TMzkfZDLgd8wGs/rpgtTPrqqSseUSERob/+9PSsKoQU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 18, 2017 at 08:12:49AM -0500, Jeff King wrote:
> On Mon, Dec 18, 2017 at 11:13:34AM +0100, Torsten Bögershausen wrote:
> 
> > Just to confirm my missing knowledge here:
> > Does this mean, that git-gui and gitk can decode/reencode
> > the content of a file/blob, when the .gitattributes say so ?
> 
> That's my impression, yes.
> 
> > If yes, would it make sense to enhance the "git diff" instead ?
> > "git diff --encoding" will pick up the commited encoding from
> > .attributes, convert it into UTF-8, and run the diff ?
> 
> You can do something like this already:
> 
>   git config diff.utf16.textconv 'iconv -f utf16 -t utf8'
>   echo file diff=utf16 >.gitattributes
> 
> I have no objection to teaching it that "encoding" means roughly the
> same thing, which would have two advantages:
> 
>  - we could do it in-process, which would be much faster
> 
>  - we could skip the extra config step, which is a blocker for
>    server-side diffs on sites like GitHub
> 
> I don't think you'd really need "--encoding". This could just be
> triggered by the normal "--textconv" rules (i.e., just treat this "as
> if" the textconv above was configured when we see an encoding
> attribute).

I can probably come up with a patch the next weeks or so.

> 
> > We actually could enhance the "git diff" output with a single
> > line saying
> > "Git index-encoding=cp1251"
> > or so, which can be picked up by "git apply".
> 
> That extends it beyond what textconv can do (we assume that textconv
> patches are _just_ for human consumption, and can't be applied). And it
> would mean you'd potentially want to trigger it in more places. On the
> other hand, I don't know that we're guaranteed that a round-trip
> between encodings will produce a byte-wise identical result. The nice
> thing about piggy-backing on textconv is that it's already dealt with
> that problem.
> 
> -Peff
