Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF62C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 20:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3242121734
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 20:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="L8zu0+a2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAUU47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:56:59 -0500
Received: from mout.web.de ([212.227.17.12]:33565 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728741AbgAUU46 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 15:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1579640216;
        bh=3t0kPkKUevLabMeEGgrcz8si0vbcmrFLnWpNjB0DfTo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=L8zu0+a2IhxqlWrmEW2mh/K5nC9FmXqmFewMgOEqjmaSDsTjQE2jF9x6OvWHoVH8N
         nQrvCsb5tzKSnvvy/rbGs/kZTY25F9+NvAPS4Qw76nNWWNmR7Kxar5JaZI27BMFT99
         oUNs6f88F+LqbQqmGlYupP5Tl+LyyY6xuj77n1m4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lpw2l-1jVpdP1umV-00fkrT; Tue, 21
 Jan 2020 21:56:56 +0100
Date:   Tue, 21 Jan 2020 21:56:54 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Ravi Patel <r_patel445@mail.harpercollege.edu>
Cc:     git@vger.kernel.org
Subject: Re: Issue with installed Git OSX
Message-ID: <20200121205654.tkifeb4vlu5uymcv@tb-raspi4>
References: <2F620D91-F038-4512-A4CD-E706E6163A19@mail.harpercollege.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2F620D91-F038-4512-A4CD-E706E6163A19@mail.harpercollege.edu>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:KRpAaZ0UcO4LGit+snF4BfZxuOILEX1irSA4xmBKOb8uQqQ4a2Y
 0h4CpJq7FbEFTwAm2rshDYnP4VqNDeNRzPcWowBCGZIDSqHVpGvL/5LAcmgOR6QNFxTufOj
 /K0upT2bde0UNqwOTJZkZM9h+rx5TOBFrOgqOTuPB7JkO0cIEv9pJyfHjDUDeAHEXFxEONM
 r5GEAXj602nktbyscnxLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K6ej8qAdLag=:bOyaBMrps9aSMnBApzhbcc
 z7lFftyJDwY6qzQsuTnUTmvU05q0VCr/CTecPxNdq/dav9lmHgH+D2kL+/G9BCVu95NQCOR7N
 10UB2Z7DaT0eCVpobq5KF+ShVS3g0nl6HVy9p+3piNsnHbAN74A5LXTOlXFjK7NCWDnhX2RdE
 SWRVx7GNEwHKsriDO4wpiaH//tmrUtBpJ2y42Bsyl61z65gXGblljSgQyyNUmufEXuDxfaCYJ
 C+mcvmV8nY6dU1lHeAwf3lw24oEQ4ZrVR1TiX+oMyQoSv+1n07Y+USutoKrUjvXPlft9ysrVC
 vwlAYwvohVmc+9HIQPkqgDQfGCfxUI2bVbB0pjx2EkvL6kpdSdrKgctyc7dRGJnDz4l8RXZox
 wBstgO/BA1DZUJ/v/oNg3EklMEtr1lTXbFf20vq8+ImltkWp+3K/HC8rAn3yexjBCWEEb914w
 6Tle7T9zFwctTlRZl1P81xnbT5wrKyk4hFQlAkzsPKBNKnIEV4poSinSO927mOo4oCAY3Yfef
 H3ilA0j3NZ8OFdHo37CJRSExjQE7ijI+k+Lao+wPMFzNDCUOr8LXnKZAeEnQ0Sv9hq5L9I7Ba
 uvO6xA5fC+M752Qa+mjK5osmqzf0XOSgzgVKPPlcLqYx4PmkTw8ztlLqS9XTgSlHyCDoqq+vH
 LzBoeqs2sBT9BjupjpTdR9ThvLtBskNIQyZpJmTFhSY4b0TT1wNJ1/ULgegamrehMypRowb4R
 bnFFsUqfytELJEMPbbpLi/aGE5e3htVsqPyOKGvT0YYbB3fjtZu4UzQF+84VelDdwdas6SOIJ
 YkfozQWnKP42DsErqD5Q932LFQrGLhsie0QPLznCgkQ0a5iTKe1p7CgKYZntNAVCf9PKnpu4r
 Z9LHVpn3NwJJ+3LFdEcFWd4Y8m9JRoyc7y+At8PxLysZW/5f1Ea8kaweaqEjyz+5x+59HoCQl
 t3s++IMBNL3nW4SxyyrInFjWpa/lhDJwokesCLUSjyjMo6mBzZSidpgXKckXeE6JS26lxdDHR
 qHe4XRR/hHvIJbFyb2yMtrdEGyWRUxii0JtCT+J08wOpzcub5eoQGGz9WtLErfgIS0tN7FVm6
 PhPHhKXauqDXG9Ec+tvmLTWSV+MJcUNoQgFI9Qgc50x/LgyL06k3QXIVSPI+O2ASH0uxo/T7J
 KXnI6pTqo/Z2OqIgFwH96jBbu1i6Z7z8iUW3NdCaMQJfmMSrz+kZSkwlRvbjkOWI7wfCx/lPa
 +d9S0XJRsM/IzCCchKn4PtI9QwphqP4C8bW2PEw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 21, 2020 at 12:02:29PM -0600, Ravi Patel wrote:
> Hey,
>  I recently downloaded and installed Git on my Mac. I do not know but af=
ter installing I am not able to get Git Bash.

Git Bash is under Windows only, right ?
You have the same functionality under a terminal window - unless I miss so=
mething.

> I can see in terminal command line the version is downloaded as 2.23.0.
Good.

> But I am not able to connected it with any new projects or the existing =
projects.
I am unsure what "connect with new projects" mean.
You can open a terminal window and use Git from command line.
git init
git clone

and all other Git commands.

> So can someone please direct me as to how to get this working properly.
Which kind of project are you asking about ?
Which language, IDE, tools are you using?


> Thank You,
> Ravi Patel
