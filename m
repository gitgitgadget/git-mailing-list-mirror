Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D58B71F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 16:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfJEQTP (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 12:19:15 -0400
Received: from mout.web.de ([212.227.15.14]:48619 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbfJEQTO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 12:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570292348;
        bh=l/jsOMvHk9Wt/AL2dd6UPzWjx9EM9M5NsrgiXEZcXs0=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=sD1pjt4U/W/1IeTv21geXegKdcA2r4Sdd/E+TzrOnP4gEAJ09tkpbkLCN/P2RPMgh
         xd9BdRyGz90P74F/bHGj8o5ZtNKBiwPOs87Gyr8mwXgVFQUQwKRkKKjNyPS+SaOjYf
         mUJmauDOA3AzDq5ec1nNGdeLIWvC/zfuyTH3B9IU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M5fhI-1hsPI33ooC-00xcSp; Sat, 05
 Oct 2019 18:19:07 +0200
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: PATCH] remove duplicate #include directives
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <1133ae3b-81e8-4ec1-c2d7-d071e7e65ec1@web.de>
 <xmqqh84pa0ah.fsf@gitster-ct.c.googlers.com>
Message-ID: <59f7fafc-818e-1996-4e1a-5697bd4880e0@web.de>
Date:   Sat, 5 Oct 2019 18:18:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqh84pa0ah.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZFlEfSvU7zfJJrXmendWR89ab+x/X8PIIKBbN8TC+PANBH61j1w
 DjcJSLWDcKRh3tX1KcMkRidTj6LzqTJM3sZ77QPNi8E6r9wyiHDBAzglYrFxahx1mz/0tq3
 6fWu1rEPdZy2Ow0u36S+aotW0KlsbECwDWfVEL6P7B5A05olWj6r2pfjkNXnTmxKpmNLXZr
 WYyC6mC19Cm6ZPNXsyFhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k10/G2F4o18=:eDuyFBim7NTduF3tR1zGwD
 iXvOVSCjVgJ07QVrkh1ydxEj3yrTzOjBj0J0B49l1Z2pC+VgNMQI/1+qbSN9OwkU+WvFnFXIK
 1TlMmsqAjfeTGAV5o8yzsy0Yvf9RYa9ieeX1CVsdVBGZp+rfZ1g3gVMbJuInCdEQoRg8i8wxP
 7ARQFJkwFSiNb7Ykn3Lyzc9utH8VTpmvAJT4Mud239hwW/ZYQhp4us142Gqi1syGdUQqoucQ0
 sqfIDf/4jqonBR0gZp+oSDr7nXmfGQX1UjvlKiWdTqRPA/cNMYz9LXVCjMfyKLnxGxRSIrGGD
 AwMm5XDJigG92zT9QCPbMlANG6Yck5CH3HSSfzop5vMf3FNnOzIgsDbx68wIh/SXxxL4JmWPo
 3yBo4o0mUxR0CP/4Ki+7+MwqaLWyujWP/QRT+bxAcc6LrtZql5ZgEzyCRPJozqoKF7o8Ozfq+
 NQdttDnxMptxTRAPg0TEUXExidyvoLlIGZS6N+Cu2Op/Pr/DIpTL5S8MB5qZmCiDkxJNo3PJw
 YIZZM6hyouSsfPceJOtowJCIl6hGS/PVugurrrMdC8GubcX6AhRzFddj8y55olfsbFINOrJwq
 50WN2nuApOmRbQJWXFPktiMZgwEABGwOHRQM/d7GPlsqfWt06ag3bW5i1TtFWY6LTfSp99KPa
 hG8bZWfo2eGrdReV73d5yexvgK4WaiuLXhdOUmiQnYjTl8rd7bS3NSQa9y4yV6z5gcbvwjsm9
 cA36fZTeR3jVDpRS1R4y6EPTeOBobwOCvofOLcw68AsbFKKo7oN6vmgwbXZnMCn5oSKoz8yQz
 scBxQ2ia9E8cdUkrrhngmK6Ftj9SCOAhX/jPDUrQeIE25Ly6/fLCTK+KHGLWOOVJGoyxewmEl
 8MJE3+PnRRzXzTbB2Dpa7pPRjCbGiLgyth8+A3KFgSfylXg8mB2B78IQrgjRr8oplcjnzE3qF
 AVKfawIIH50U8wvTTxczu1XL7B6/7AihNgyz1pB8ZFmOIw00ptLAcNZXi3S1f4WTFMlJTehEE
 Bi/zMZ4bU7nzE8RMWohI1S5UH7dqHRL5ltZ+a1drjYfGspmh8H/RxlkhrcmwK6teo6S6nCwsK
 KeSOSCMlnnSpV71zZrfpmsO0tJWuvj9gd3/DOjTkTW5pEAXKJxopuj1HeAZQRFp++8ifK0XHl
 eue2qdw1M5VwAZoUU1pSZD2Wcuj4bEa02q12hPP35FoQ+Yh/ucQYczsXnp3a9iL3vwtLwawvt
 hkzYTemN6O7u6WKZXdiz3zboI0MJYYX9WjAT5AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.10.19 um 01:15 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Found with "git grep '^#include ' '*.c' | sort | uniq -d".
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> Patch formatted with --function-context for easier review.
>
> I have a mixed feelings about that.
>
> The only audience benefitted by --function-context patch are those
> who read the patch only in MUA without looking at anything outside
> and declare they are done with reviewing the patch.  For something
> tricky, wider context does help to see what is going on, but then
> I'd feel uncomfortable to hear "looks good to me" from those who did
> not even apply the patch to their trees and looked at the changes
> after "reviewing" tricky stuff that requires wider context to
> properly review.

Shallow reviews can happen with any form of patch.

The intent of --function-context is to provide meaningful context along
with the patch, as the basis for a discussion on the mailing list.

It works best for changes whose effects are constrained to within the
affected functions, but have crucial information located outside the
three default lines of context.  An example would be a change at the end
of a function for which a reviewer might need to know the type of some
variables declared at the top.

The price for that is that patches get longer, which eats up more
precious reviewer bandwidth.  That shouldn't affect those who apply the
patch before review, though -- they can ignore any extra lines and have
git am deal with them.

> If there were topics in flight that touch any of these include
> blocks, the patch would not apply and a reviewer who is interested
> in these fixes ends up needing to wiggle them in somehow.

Instructing git am or apply to ignore extra context lines using -C3
or similar would help in such a case.

> Having said all that, for _this_ particular case, I do not see a
> reason why a review needs to look at anywhere outside the context
> presented in this patch, so I'd say it is a narrow case that -W is
> an appropriate thing to use.

Right, sometimes the context in a patch is sufficient to understand
the contained change completely.

This one here requires one more piece of information, though, namely our
convention of wrapping header files in guard defines to make repeated
includes of them no-ops.  We do that for those removed by the patch, but
we have a few exceptions to that rule in our repo (at least
command-list.h, kwset.h, sha1dc_git.h, tar.h, unicode-width.h).  So in
that sense it's not such a good example of a self-sufficient patch. :)

> I just do not want to see contributors
> less experienced than you (hence cannot make good judgement on when
> to and not to use the option) get in the habit of using -W all the
> time.

Providing full context (all the code, all dependencies) is impractical.
Three-line context is an arbitrary amount that happens to work well
surprisingly often.  No context (as in the original diff format) can
suffice sometimes, e.g. for typo fixes.   Function context is a
different point on the spectrum that has its own use cases.

Patches of long functions would become tedious with -W, not sure if I'd
be ready for that.  A MUA with syntax highlighting for diffs would help
a bit, I guess.

Ren=C3=A9
