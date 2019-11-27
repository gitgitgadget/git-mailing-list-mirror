Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9D7C43215
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A04206E0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="I9ChtnNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfK0TdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:33:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:37225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfK0TdI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574883186;
        bh=G06JqozBRZWzV1DFwlx9aIu8fycviW3mj1wkZhb9plA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=I9ChtnNfz52QDNAqZj8I3DPzaMVqV8nOLONpV4QusyHUoYogQMwfquJh0ntk2E5cg
         lxjV/yRZPpDaYEQu8kLnKN0G7IVLOiojTtjj5xvtyBZP23rw0jTVDzupcpHqyadOq0
         njhrIKi6m0+7RpHjkvWkbS2f0U39hQUKKlIOaEag=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KUT-1hlYvT1HeD-016gOs; Wed, 27
 Nov 2019 20:33:06 +0100
Date:   Wed, 27 Nov 2019 20:32:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Nov 25)
In-Reply-To: <59ae5223-6dd8-00cd-4c39-b307f8364457@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911272029050.31080@tvgsbejvaqbjf.bet>
References: <1cb7ddbf-020e-d63a-85b6-5a9267c0a5a3@gmail.com> <nycvar.QRO.7.76.6.1911262116100.31080@tvgsbejvaqbjf.bet> <59ae5223-6dd8-00cd-4c39-b307f8364457@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:61b9HyAYmhol+UyAbvELGnL78RlXI8JgWCiNtl++0HhwjDdaJNQ
 YjrGoBuMW3suYy2VUygpt7xoFqASuDRupqbVB0ScXvqCX8UrPEIoKxuTf5izzepRYR4weO7
 ExJN/9M1o3pg9zf1zfKRBYbEW2NElixix93uL8VPQSPoaoXCm8o4EiM2/Nt3XIdxKoi8SaB
 1Ou8FhwLQcIXMINAXTniw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hdm97AD9aTw=:HtZdg8b/u0ZDW1lP9spkVd
 AVzoFH/FzxpxXQL4Ft+gcoYwAxHuVFbs0S9/5GVahyg7q+x1ymlZGEQDNHLXVDDLytmJdDK89
 HEFl9dRN22rbcHqO5EWRwyWCstwe1MpqdDaiEi4h+2NlO7z3adwGsnPfEIQDAeBTPdyg9sc1u
 u5wpcLrzmmoke4xhZLOm55WojceUHCX84UUHnwHiFbAh6/Au56KxBkZ8bu9c9IR+yP/59LCEA
 0Vp0fBlxs14X2Zdk+aLSUUeAIZ8FVhNb/6Id6itJFc5OA0nTjmP0lKbT3dHhAlNZkNCwPEDNu
 6fnHhcnLpAelY2jJ9MwEsc6QcfqwkccwEorz91/sJMLoHEQ+RG8Vl/Q3bUVP3FMNWoWt8PYF7
 JU11onNe0UdnNgpEh31vdzMxUzi+usKyoAr5bXnZDREHH/XbQ+bTNxKGrmY8fADj2f03m1kzl
 SfG0vbyrTmcVX4coqd7oBpHILlL5ZYjR4cgLVeBM/Qt7JWw9pNaH6B9ArOcBKOzz4GVLMwNRu
 scH3vqMAdoE67KW0lSMX7rUdo++MQbtSUG32vZ813Glao7/M8UKzY+U2BixKWjXfueJbH2KG5
 RIc8RIFm65S8c4N2Sy3QSbmvdB64WofAadiLdIC06bzp7eOiOBO1Tvyydy6DSjIYUQF3YTP7F
 J5K7awpunB6IP+8vN5tdhjU+KfXUBe6hSwYhGc9lP9x595vafR4+x7n/DZMibAwohdWE769Gc
 CfgU7YjiLaHYaH1aOi/Nm1SyBJTonRT+Gi4laOgZ7FZWk9ErQegw9Pl1KjfGaNvT478MaWSyB
 7M5SkGR9i3XGwwILdQ6Lgj3v/HVlI9KYQufnYzcZT8tsBkxg03V/1Nvod8vPXWfxr/HMBKsjG
 m08tT5N5NCusJ8xAn4jV0metG/7/6tNg6TioPavobZJcdNt3T6TTjkAGqBp06zJs3HPewC7fW
 T/Nbi6b8RNB6cQmfXxC9daU3jLt8UWzOwNpKG2Q62jUOEqXAVuIW9lz7zxaIig4cqQd+g1YNT
 C6oRk+5xjlTSJd00iLsEC5qnIOHxCvjDCj01QgYuoX1oqCt5fOEzUWFG+bRTU+E+PHtx0iO2I
 H8daQaY1t3MBNYBpYNDVAuZFC0zmU6AaYX+5nkm2ushHjNH8Y/DsM8B/nXEDt9Nw98VPPCZsS
 WMNxx8EX+zMrHFSV9A3D+qZpE+eM7mYlX5wVh1/OYDkzEM++gN2ehJVtCJm3b9M9wf3giIEXm
 wiptsYb3QZP5G2BZH/LIfEiD7lOZoy+rJlqvMZeOuxiLWDngAdG5IX9+9Ja8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Wed, 27 Nov 2019, Derrick Stolee wrote:

> On 11/26/2019 3:46 PM, Johannes Schindelin wrote:
>
> > [...] the Windows build.
>
> Sorry that I have not set up a Windows build, but the Linux test-coverag=
e
> build already takes a long time so adding Windows would be complicated.
> (Not to mention that merging the uncovered lines across two platforms wo=
uld
> be a huge challenge.)
>
> If anyone wants to consider such an effort, I'm willing to play along.

I fear it is even worse: once upon a time, I tried to set up a gcov run
with mingw-w64-gcc, and it failed miserably (there was simply no output at
all).

So I, for one, am completely comfortable with keeping the status quo for
the time being.

> >> Johannes Schindelin	116d1fa6 vreportf(): avoid relying on stdio buffe=
ring
> >> usage.c
> >> 116d1fa6 16) fprintf(stderr, "BUG!!! too long a prefix '%s'\n", prefi=
x);
> >> 116d1fa6 17) abort();
> >> 116d1fa6 22) *p =3D '\0'; /* vsnprintf() failed, clip at prefix */
> >
> > Those are defensive programming, so this is expected not to be covered=
.
>
> I wonder why we are not using BUG() here (for the fprintf and abort).

It's because `BUG()` calls `vreportf()`, and even if the _current_ version
would bail out at some point, I would be uncomfortable calling `BUG()`
from `vreportf()` and risk a (future-only) recursion ad infinitum.

Thanks!
Dscho
