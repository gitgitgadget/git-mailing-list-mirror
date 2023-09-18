Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CD4C46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 21:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjIRVAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 17:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIRVAT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 17:00:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0413B112
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695070808; x=1695675608; i=johannes.schindelin@gmx.de;
 bh=LiqyOAZLY2XWyVObCE2y73Ds2Qocr2wNbUd3FLYBRws=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=laGlDa2Pno//dfxXG30VujkFtILuSeNtHxZ3mwzFpPCezz1QtYMbhvRmcPoo8jszCx8Q8c6Iv5f
 Hwn7kXYdjg/ax9fxxc9n9/gGAFIM4Lb2V3ud5XhQf2NTudOT+V0AShU61XTK01tXtPyTca4mQC6lE
 H93BkNzYvqpBK8NITU8xmFtVBXAZrfJpgLqJ4ZsGGpnt6u3OLI0ilrw9oedwtCuaAQoSeANooDWQV
 hOSVKowMVcv+48PhSsPQDYBOpgTvgW4ypq3C9fKhrUxuwmAM/zXFeWThVM7XalOzOUNSYIlcSVwaf
 78tc+2+TCYY90HcTYIwHxHN7N9FAFtL22QJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.206]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QFB-1qjivd2lcb-001Uju; Mon, 18
 Sep 2023 23:00:08 +0200
Date:   Mon, 18 Sep 2023 23:00:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/4] unit-tests: do show relative file paths
In-Reply-To: <69f6f263-06e1-4fef-abd9-d6c03ae0c148@gmail.com>
Message-ID: <b14a99f8-46c2-b54d-e24b-919f3ac8f2e0@gmx.de>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com> <2b4e36c05c9e01b1e489100531fd01515b0786ab.1693462532.git.gitgitgadget@gmail.com> <69f6f263-06e1-4fef-abd9-d6c03ae0c148@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:T2pyRV+DeBkJ7EPAi9lgcVNmpx4OJ729DMVPCu5rP2XXKKDQu0j
 J8ISZRqfob2LyhZhHvy2ojdbbjTDskVW5zTyXvYDPplI+py9C3vi9i+9hRN1pBkq0Z3ters
 nCXYwQQNfReuAznq+3NiKE3I3YGWe2aCSFQgfhQjGCkgbkgCgHSv4auVDBgq+iQC9Pm+kYr
 sx9QGebIUpP09ia0TPS0A==
UI-OutboundReport: notjunk:1;M01:P0:vt7I5bOfIns=;259eVlHeDLU94YrPCUmW1B25o27
 am8W9P5EgP/py8qK2/i+a+XdVcqqY1z+wh0lukNVUH8Z+rfntK64Q2Szn2HXcxWF1JI0NnsX0
 +msbKkCw66EcCcl7XDrhlTLOQVC8ylRzV86J1g9jdSTZmTRI34FOO212iCKeBD5o4Dj4CYaE9
 KT1tap06uoD1VTDS/0h1+7DmwcMDKbc1RuSF3WVqMC6NTlAAc6ro0rEnUZXHyzMrHBpCZVWam
 +YTwFuNEE73o9GY8d8iroZJ/gLB0bSGCHGf/TIZWvpb0F0YfC3qUxbfvB6cydaWkTrBc2CuC1
 1OW5XYVIGe619Vw3EOAT8Jub1NOwbwuf3h6CCLFYSOsWgDbzYXBabns7DbJ/WOMlZE7Rfye9f
 PHht5K7uwrfafnXdSkQemn+x6aBABkZHO43rwGfm+PyWU5M1dEqnYH/kbP8kqk3s5NyGc8mHA
 ld9W9a3OPzjoSe+WXjoDBYmHUyT512m2qdkNrwhw1cL3dKJYIKS4o7AE70aHz90XU9Xx/rblh
 gxi0azouGJ4ZDQeuF5tB042hxiY6Fa4QypmYuubUvcaQzNL6lIduosVhQ3x2Kli6xRqeVEMgg
 Fx7PRAYLxAruF4S1otGkajPSTSSf0Z50mGVkY40Mj7brV6Wu+TE49yWQRaGjXFMMKmyAIgD9d
 X9jMviIpL3p691BL1b9AdsUugE56up7l6P5ksGaqKtWr5XQURzIkNe/rSlnfQHJBtcPDE+Yct
 5KpOnBNlHoUI9bG0JtDWbQVxG64ka4adJr7E+SFEVU6vJJxV1/+1mcoqqCPV8etoh1AVdnfBO
 WS23ebLjniTZk/3CO3Gw1F7lPXq+/y08JshO1aYa4a0T5+jUzxFsKrT42b5Ik+XlzXA+by4VJ
 Mn3X0KVf13Q21ccWecuw0x6d0Nk54iNeki2AUCL7RCSO+Q9W6V5bULcjBGkFLcTYLqxb2VmT2
 dfLIsw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 11 Sep 2023, Phillip Wood wrote:

> On 31/08/2023 07:15, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Visual C interpolates `__FILE__` with the absolute _Windows_ path of
> > the source file. GCC interpolates it with the relative path, and the
> > tests even verify that.
>
> Oh, that's a pain
>
> > So let's make sure that the unit tests only emit such paths.
>
> Makes sense
>
> > +#ifndef _MSC_VER
> > +#define make_relative(location) location
> > +#else
> > +/*
> > + * Visual C interpolates the absolute Windows path for `__FILE__`,
> > + * but we want to see relative paths, as verified by t0080.
> > + */
> > +#include "strbuf.h"
> > +#include "dir.h"
> > +
> > +static const char *make_relative(const char *location)
> > +{
> > +	static const char *prefix;
> > +	static size_t prefix_len;
> > +	static struct strbuf buf =3D STRBUF_INIT;
>
> So far test-lib.c avoids using things like struct strbuf that it will be=
 used
> to test. In this instance we're only using it on one particular compiler=
 so it
> may not matter so much. We could avoid it but I'm not sure it is worth t=
he
> extra complexity. One thing I noted in this patch is that prefix is leak=
ed but
> I'm not sure if you run any leak checkers on the msvc build.

I changed the code not to use a strbuf, and I'm now working exclusively on
static buffers instead of `malloc()`ing anything.

Thank you,
Johannes
