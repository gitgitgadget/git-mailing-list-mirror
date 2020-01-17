Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BE8C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC34C206B7
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ft8c8bQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgAQNgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:36:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:42553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAQNgC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 08:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579268158;
        bh=uAfbjE74icLcQUQIJNYHfoKTzrOdbfSzNU4+ns4ceBw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ft8c8bQ920H9O4Piz67V9c2gUSO9Z8ojlYz34tyYP/fhKGlLVZjjIhRtU07+St8CN
         7A1tcI6XlYTil488YbseN6RJztIf7Mrn0Ko+0ERL+aepibpAUZgf80iCO1XQswGNab
         2FaafOiwMZwPSumG0a/0md9BVwfELuF4iNLG4cUM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3siA-1jaLGP3e1Q-00znza; Fri, 17
 Jan 2020 14:35:57 +0100
Date:   Fri, 17 Jan 2020 14:35:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Nirmal Khedkar <nirmalhk7@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: Facing error in git-imap-send while compiling Git
In-Reply-To: <CAFFaXsz9LEdegzxL8MhS+VfTs-wmWu+CGDjxjB4Xgj8+7nSHNQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001171433180.46@tvgsbejvaqbjf.bet>
References: <CAFFaXsyVy-fU5c7teDbVCTdUXFTK0GQ=Fse5wSi2vMifyZxS9A@mail.gmail.com> <xmqqk15rf21d.fsf@gitster-ct.c.googlers.com> <CAFFaXsz9LEdegzxL8MhS+VfTs-wmWu+CGDjxjB4Xgj8+7nSHNQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SsBRsvnmNajCnIXFwUrPGHmWcNJFfSO8sMrE1LR+3wjHhUVodp3
 is/wKJepxmE7F98HeCYvA1+zH06yXAnPo+/xQIV9VEs0eYTGsIhDva3XbRRRUHGybA/LQgI
 iArE23/CfhkCRLjWVMSUlFpMv4OPu+yJJL/yCeVe5HI0oZJTK/X5Berv/h5X3nKRBNKU4X5
 hegRD8wvica3VwAPQX1LA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Y3y0GG/E5I=:zC66Nb3bCJQ1n7tMeVGUNr
 vR3/qGmSzIqbxFgqX4Znm4jlIi1mcw7KDcfg1Qur//M5e5YHstR4uZt/Wrp2uJHxIHHgqNCab
 Bubz3Q5+nt+fB/Olhgfm5h1FHU1ozcGGkui4SP6HeT+ozJWgNn8+vkBDzVg6QskkpUjCIEcFn
 b3izhOgdSSCogKRWSQ/BbVfA+wM8sH0AETiyp9Nxxt7DIrOpS6pHacpq7KtFS6F6aaQ4wENya
 63Mim5MtM2M713EGdY1x4OGv2IjjPAI11cwMaP8BdtWmx1dfHxRGkgz7NuIuJm6CTEWEU7E+l
 LrCgPJWOC5Yq7D4ccRNkWNsIV/+BY9VvWQyTfS5d3ijsNgtd+WkVgQ62+aehySYzpNgLTDhjP
 zUeBcQ7FBMatuLZa42ia3lAsmTLWrMVDG2jvkcu4+0X34InNAl5SosHvDcW6Ug3zvbL5JldRD
 Dn56YetNLxSzx+AWzVin5OFQwUNr1hqx3ViydNNX8pFNj3U5gvNHRDJn23fpmNn9Wte94ZLok
 XEdkEtrzX7L35XP27NMtzahfRkZlz2BhgnJJr/ioucXVfjSGThkFqtMW6sLEL6b8mYv9HF53U
 m6+RY3eVyQi2kaJYL9wJB934ESNungdgseJrSNshkpGBirp2SP0Sl4B/LpEWYejYPEicqYfB3
 rJeuJoEmh+XABoxk5L/hAfJJRYs/skUAAUkTT6FSMDrG5L+nKVFpaQpnlSjUXl7vI1RfEwXNg
 rvOyzznppg3zmPbZal+4kLvU67oLmjbOI47fc7rt0lSh6h6WeGRL6s5qQZcagezJ7sTQHEgGS
 w6NOXvMqfW1fwZBoaAdgYRpVKdMXsejtJ7pz6vCXMfPKDIMU4aN0RjSoesoasiLtExwK8sra6
 N5xsXzcV06dh/pHc6fuaBH33+R6JBM5AuE7hBuIaYlPXl1JBFPhVFHdP0DoXhxChN/2GEEsUN
 Grg5U5c2I0d9M38gGPgtL46CtB4RBL0lFMsezOdy4091x4/MlpnIB7ahBmRd5IIN866h9NeXe
 0SXHp0x2fbaof2DluZ3e6hf43+5kLxe+k6NpV0pDI9n9LIad9os3lAylfFDiVW3UCPx35+B7B
 PxlozZVrJnVvB2bFsNX/nJj4ttlcv6rZ8kMVrw0asYYJwWPL18EixEmUln9+jneJj0qdshO7N
 n2OwiVQYb89JWTzaXGGfCR6WWr0Vkmhs4qjxL1l/h1JoxRHS/0GWycYkxNDOqn0hGNmnSEaLu
 PJsFQvD1GFrpEQ2EM6aC811DkUBidssBmdAzo3RrrDXwaZMchuTEX0g4gA4k=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nirmal,

On Fri, 17 Jan 2020, Nirmal Khedkar wrote:

> On Fri, Jan 17, 2020 at 4:21 AM Junio C Hamano <gitster@pobox.com> wrote=
:
> >
> > Nirmal Khedkar <nirmalhk7@gmail.com> writes:
> >
> > > Hey!
> > > I've been facing this error everytime I run the Makefile:
> > > -----
> > > LINK git-imap-send
> > > imap-send.o: In function `verify_hostname':
> > > /git/imap-send.c:252: undefined reference to `sk_num'
> >
> > Perhaps the thread
> >
> >   https://lore.kernel.org/git/xmqqpnfv3tq4.fsf@gitster-ct.c.googlers.c=
om
> >
> > may help?
>
> It did, to the extent that I now know why I'm facing these errors out
> of the blue.
>
> I'm  not quite sure as to what am I supposed to do right now, should I
> wait for Liam's patch to be merged,  or should I implement his fixes
> locally or should I just downgrade my openssl?
>
> Liam's PR (#516 on GitGitGadget [1]) haven't yet passed all build
> checks and I guess its still a work in progress. Nevertheless I've
> tried implementing his fixes to imap-send.c, and the make still fails.
> Am I missing something here?

Speaking for myself, I am still waiting for
https://public-inbox.org/git/xmqqpnfv3tq4.fsf@gitster-ct.c.googlers.com/
to be addressed adequately. I think this is the main blocker.

You could be that person who addresses this, as already 10 days went past
without even so much as an acknowledgement of Junio's suggestion. Maybe
you can make it work, and submit a fixed patch (You could take authorship
and add a footer "Original-patch-by: Liam Huang <liamhuang0205@gmail.com>"
because it is most likely a total rewrite of Liam's patch).

Ciao,
Johannes
