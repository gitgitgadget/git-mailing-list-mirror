Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49A5C433DB
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FEDE22AAF
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbhAPRet (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:34:49 -0500
Received: from mout.web.de ([212.227.17.11]:35311 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbhAPRet (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 12:34:49 -0500
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Jan 2021 12:34:48 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1610818378;
        bh=liBBvUzTV8rwHste793gloB5+aqo9InnR5M7s1Y5VCg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=opcc19bCWHF0g0c/ORwzM0SW3VY0xKt61kEwycZvIiEOE2PBAbWNTM8NE07o6jBlc
         jwPC3/oPsfIbjRX8t18qlCNGCAHRvctcZzuPLnrI7ptpJC3ylPvuZNWb4JuPTTAd5c
         dzEhdl9v3wuWQRuFQWQc+M4I/+oFTwByu0i5FSUc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgiXO-1lhtNM3EIW-00gzFC; Sat, 16
 Jan 2021 18:24:48 +0100
Date:   Sat, 16 Jan 2021 18:24:48 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Daniel Troger <random_n0body@icloud.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git-bugreport-2021-01-06-1209.txt (git can't deal with special
 characters)
Message-ID: <20210116172447.uroh2m5r3uvlbmih@tb-raspi4>
References: <20210109172301.qkxxeeqnyrr6nyc5@tb-raspi4>
 <653FE799-B0D6-471A-8801-834C6CA409E3@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <653FE799-B0D6-471A-8801-834C6CA409E3@icloud.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:6P+jSmg8LCpLdRdGg8+VwqT4UUNl3wmhAyxXEiG056qJSXz5VLX
 04pSUckkgcz/cSGqMVOBn9ltk6p0lioHWtHWd+oPRmaDR4gO2Tg9ZHwCGZKqfMP1f/+8Viy
 Y9k0aEuL5lFLL1iyYiOBHZOt6nLM99fHxuCdXzqPIoZzeIwdB54DwAumo9iv2rQtMDBgB12
 xAEamwxhrnE2F7Obgs7oA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZOxbm1V8MSw=:UXvAVXu7IGZ90V3qQQ3q1v
 wuYrTQxlPnFPJYByDflJ+2L4sBhUDQVX4rjvqQCnzA+sGU1KSlBjlJ7xT+YSrAT74fQfQ+CPE
 z/ZdFfYvbbUJRIeX68NmKWlGHmKeN6SlciaxIjzKC7P5618tIpBU5bA3aKqhENTEuLTLyVxMX
 n89TdewmfPtCnivSnZnK55DFz+WRBBA/Qsdf9WxE+r1S/re08N6M5iNTtKs7D54fSVIgynR3q
 gy7FnMmXwXSKd8zg8SflOfvgpVOJQe8lx5Uxo7iFwiN9yZs8UvcjzR7aMo6Aq4X0Ef6eqAXaU
 LNku5lQCBicc2R2j7DXoq5VPaS5dkk3tsQYPbizjiOAWZ6PkEqE3Dc6vzhfBhOC1jCDM+MFJ9
 Omt00BXDMq+bHumtYAiGVCdQUb79PpRKN/53qfmkvCMOKgzx19HpbuVFQ/u5a+FAinVQG/4bP
 vRV5ISQ6sfTiv6GNdOtMYR6Bl1G9jyRFNyLV1KgJteKZ2WmpERMXwtu4jjLNIZoxjDYQ9QCyM
 p+RS9nyDgjREw9894acbMkDctjYmn5lg+Yp7w8c2hVCv3CLeSHhb739O1eqapMr6UN3rZqKqF
 M0TSe2Wj/tz/jSs4s7h6Cn60Tqp7vYgE7R64GGGx3CnlHr82bwPbBQFwfmYUPdYttcfm421I4
 B/dE9DMy5FLKZBPIBPMwkE9r+si3xQRU10Z6jOW74Y7a7zOwKljJzrB/5fO+XZPJvMF4SXsQl
 Nfwjp9C3uLfUzChHl7nTsyD9UXTliBpDbbHQmOwQeZEHCpvc/cwSmBoyrJAekc/YVqpq3e9Zp
 kNaAUGlkcUHHWzNbLI5VDj5puOC6JzLIIAhS3lE7Ibt85FMpgnJX5Oh32HhMOCIrcWigtg2HN
 OHdbOl+FNfdv7I7DLjmA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 03:57:03PM +0100, Daniel Troger wrote:
> Hej Torsten,
>
> > To clean up the repo, you can do like this, explained in a dummy repo:
>
> your commands to remove one of the versions worked perfectly, thanks!
>
> > And I still womder, how did you mange to create the "decomposed versio=
n of =E5" ?
>
> I created the directory with finder or atom I suppose, I did not find an=
 mkdir command for that directory in my 290MB of bash history.
>
> > I digged some hours into the stuff, add lots of debug traces, patches =
and stuff
>
> If I understand correctly, you already came up with a patch? That's grea=
t news! It's fine if it takes time as long as it gets fixed eventually.

That is a more tricky thing than I thought.
When Git starts, it runs getcwd() to find out where you started.
Inside that whole path there is the Git repo to be found, and the whole
path split into to parts:
The part pointing out the repo and
the part inside the repo.

This is done in setup.c, and it seems as if we need to precompose the whol=
e
path, to work correctly.

However, the configuration saying "core.precomposeunicode" has not been re=
ad yet.

And setup.c doesn't know, where to find it, that is my understanding.

When I patch the getcwd() function to try to read the configuration,
it doesn't find it (yet).

It can find the global (or system) config.
Technically speaking, that can be used, but will probably cause other prob=
lems,
since sometimes the (repo) local configuration is different, sometimes not=
.

As far as I understand today, the best thing we can do is to check,
if getcwd() may need a precomposition: precompose and see if
the result is different.

Then error out, telling the user that you can not run Git inside
this directory.

I don't know, if this is worth the effort.

But: If somebody comes up with a patch, I am happy to review it
and/or get it into shape.
