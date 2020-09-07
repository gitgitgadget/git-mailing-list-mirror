Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC8BC433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 18:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D551C2067C
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 18:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gVlpLcEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgIGS4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:56:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:45447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbgIGSz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 14:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599504950;
        bh=oXGzwL4bnro0aLRBO6MWjQgTddoXvR0IPBjBBrjQYWE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gVlpLcEuepb+dxz+EgP5QPJD1/cF5dWJhZj8DlfivTdRdg8aaE5EflJuzfhuaHQnk
         5OFhdl+3iBNVLdrI7pVKHTptTn914QboaKSE1shXOXqJ3eZK/MeNq/3DbjofTtWoqr
         R1cDRHAHpgR4rR5A/vl4Wg+gP/ffRN/eghQu0uQE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.215.223]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UZ6-1kEo4d3b2A-000eZL; Mon, 07
 Sep 2020 20:55:49 +0200
Date:   Mon, 7 Sep 2020 20:55:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Git in Outreachy?
In-Reply-To: <441bd08b-ca7d-5977-a455-c4c2a4bd4bc9@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009072051470.56@tvgsbejvaqbjf.bet>
References: <20200828065609.GA2105118@coredump.intra.peff.net> <441bd08b-ca7d-5977-a455-c4c2a4bd4bc9@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jX+uAsQetdE1bw/+XovaMOzwYqrJN7yYRzdXcDaTQRNQEURjU1G
 VeT2sAMG9CPpfbyvxlfi7poRhovgnWKy+HYF0HZjy26Nf/qkEics+394VzztPK87+YpqzDU
 jvdKbegevJMfTwh5t/6lvs0EjOZXM8L2A1zreE/L2J5rI10ivKl2fcJwgQu/Q009kE9Okvu
 Ja69ZJUgYHG4A2qJpJpIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k0jx/oEoiBs=:zL0g5Hf2qUvEeSh36rVAJW
 wSd/9mERTwenItrM5vXzx/EI+18giWcPwlmC811/FfxxIm8zV99CvE4QM5jjUL+ZJ/52pwlhK
 cL05ZQg4frs1DJmfpRvdJEPm7+fvfnf+lZehcYuEuMU08IOFbtYRn0VSMv/LH/l8qGQc6QzRD
 t7M5Rf4EG6tWVnes7mDK/nHu+nfXJWlwvl4uENZrbm6aJOCwZl/8+/yQ0T0UPXYWurVfXnQMG
 5gSj9wPFsSUlXY1UOrfPr28gwktVnLXznAUIkCk0z/uO5SyMmWEwYXLDxCba4KharBKjIejNt
 eDs04sZ7in+GJEMNSOCOgmRlIaH0TqsoVNbPb9RXbFxL3qM6RY7Rnj+xfqUhNXdkg8hTY9ylR
 FSdVQPt3ieK4yRtCGGlPBtIhi3ISuYUdeQxc2mlDtmtXF/MNk3UY1q8INmFABkoEpWOmvWVir
 709UHFfQoyMyyBfQlVHEpu7NoIs5EIdB1ufZKk8a6hQspOk33PmPJ10+i5Go0XAKncZjk+RNw
 F+VNurD0Ij63hIvbZev95qHsBza/43ClG46oWwJVoBvKJu+jnU8LV++7kCjAJJA+S9klJKUE1
 DMGctdaxfYlU4B5pN55sG0o0f907AfLcHWfity1lvH3OJdrQPdEa055I/YxGAB3uyQMev+kwk
 9foK7aFZOc+EhM1RfNc4xUtuKnHLCQ6SHczUWfI6lXm/FC+6T3ro9oIT9w8e8tjhsk43Ep9Qw
 9b+iBbvn3cRX3volJlhJAjA9v+r1iSRNLEmHSkGkHaAmVlIwi7EaqtOHuBeZowO7oIT2fvD3r
 LyNIgk5djVGho6BR36vS6/A8Zm2E5oOkNuqhpWDlkuRPw+oxPoXz0Q8InHohKXfpMMWehH54w
 a5qNnFf/hINUYB+7pbPi56fuHo9B+jkJiLvY0WTssJVz6m+WcIrXfhHZTt/3UbM5vddJomk4w
 yeUWpT+oCIlk9s3LQ3Lrchfrg0kv4GFG+y8q/IwMTfmfdUrM1ZdIJ1Cl1I3wyyw45+wDH7ixJ
 sx6CNrXMhNm7uQW6Ti/sCJZ4if42oUqvbeRjF/36hgX+jDW06/0Nn21hg6TvxLKq2YKI5Y+Ok
 jL3M9IoSjGJP+vrYN3UvKItqxsCcY34dpFjyn4a4wfjIb2K4Mf287r0zMDuHp6gfO6QsbmhTr
 yQNHbOWWvxiklamTeTfwgdrWXH/F5T0AQe7/qT+nzYaD2BbaRMHlr2c3NWfulbMhAn7jnpK4a
 7fZy07RHmSTA7Z02Efy8XdHRc7wlOp3Tw4KInvQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaartic,

On Mon, 7 Sep 2020, Kaartic Sivaraam wrote:

> On 28-08-2020 12:26, Jeff King wrote:
> > Are we interested in participating in the December 2020 round of
> > Outreachy? The community application period is now open.
> >
> > I can look into lining up funding, but we'd also need:
> >
> >   - volunteers to act as mentors
> >
>
> I'm willing to co-mentor a project for this term. I don't have any
> particular preference of projects, though.
>
> > I would appreciate help to find project ideas though. Are there still
> > scripts that are worth converting to C (excluding git-bisect.sh and
> > git-submodule.sh that are still worked on)?
>
> I think Dscho's e-mail linked below gives a nice overview of the various
> scripts and their likely status as of Jan2020:
>
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001301154170.46@tvgsbejva=
qbjf.bet/
>
> I'm guessing only the status of submodule has changed as it's being
> worked on now.

No, not quite. The `git-merge-*.sh` ones I called "trivial" are already
being worked on by Alban Gruin:
https://lore.kernel.org/git/20200901105705.6059-1-alban.gruin@gmail.com/

And `git-legacy-stash.sh` is no more, as of v2.27.0~180^2.

But yes, other than that, my summary still holds.

Ciao,
Dscho
