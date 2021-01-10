Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31DAC433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 12:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83BC20735
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 12:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbhAJMXQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 07:23:16 -0500
Received: from mout.gmx.net ([212.227.15.18]:45691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbhAJMXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 07:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610281300;
        bh=0ubWnYHmaUvoBweNPumPZpV0TB1TFiRrBytQe5/u80k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=V93dcKpKJ9J7jKUGmodDf0O9VIPVsvrxroeaGqMz2M6rvThSbjMLxOuJqgsdcVCZt
         5OjCOCF9jG0nFrZadRzGOFVK1bi0lXpwoESzWMTTOW0pOImEPyZldqfx+N0LZfbq+g
         SfcLub0IDIQ9znFE/dNMibHtFg7bIhAUf5xfk2iw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.250.66] ([213.196.212.28]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdefD-1kPVxK3TXd-00ZcKc; Sun, 10
 Jan 2021 13:21:39 +0100
Date:   Sun, 10 Jan 2021 13:21:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: Cc'ing the Git maintainer on GitGitGadget contributions, was
 Re: [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
In-Reply-To: <X/i7zvgMJHfOmyZG@nand.local>
Message-ID: <nycvar.QRO.7.76.6.2101101306310.56@tvgsbejvaqbjf.bet>
References: <pull.475.git.1574539001.gitgitgadget@gmail.com> <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet> <xmqqpnhfwibn.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2101071517260.2213@tvgsbejvaqbjf.bet> <87wnwordzh.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.2101071718470.2213@tvgsbejvaqbjf.bet> <xmqqft3cl9rw.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2101081534380.2213@tvgsbejvaqbjf.bet>
 <X/i7zvgMJHfOmyZG@nand.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:B8nIobjjob4+mJTsuGhkZnfOXPBGcI8LzDgvALHoB+onXyZQHba
 VedoL8lfVZV9w3/G/213YHxOSAPLezWIV7QaGuT85EsQ+TMFM27bAgHXkCsmcgHB4pSRZwD
 g4C/Y0YxVZ930RLMT5XqYXs4DG9LtxKLOR+SPqmg3gz1Ruz27KG8bGia6FqCOjZqPBxC+1+
 pgIy+7blyXMMd95bJamxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vunPn26ZufM=:dj4Cl1eLC8vubbDEyJFlnB
 BGK+dLcvuaJHZK6xdmYazUkndbHo9iKG7FJFbxOCDgyCM6HpAcjP0aZBtVyaEWKwCRmD8c8Ys
 8c/WZIfkkLT9CbDV0sStLXiMwBZWAOFUy7KB8tJ9fZgHicgjZw5Pw+p3HqN0ctmkNcS7KVOYO
 VHgd5lAXcazvDx2qQoz8aVjnrv956TGuP3iwn64S6JDZghrrcXdxO8Ts31t1LeqLfVxl3eOzh
 B4F02GDiQPjzzrgTYz71oy3nSt+YLsVhUxC/aWXJE25+1sidVuXoIvGB6j0egJ3og8eXqCKY8
 IuLLDffWktRG4mTUYU8RW2MLkY1tZA/f8eAPOc7FLqnDr7Z8VcTGp1fWyrIe4JZgKFM3Vb2Wq
 MybzRIpNUAq3NcfBOLyI2kLOoD/WSf5/Fji7ttxRv1aGDYaPMDrnlLUyJEni7jpT+8tlZ+nrh
 tvm8PWFxXBlJDdEC71AzTmrneBlTznGLE6jxul3bOfoEHslfUJ/AvrfqGgCqitamv85Agg7ZD
 1uRbOlpEMM7d1bwkG43fZONiqzJw4cFXXohzs7o5pQ6eBCeli+At7+u0TwwUPzuhs1H3plLwO
 0ZcbndW3UnYTm4Z8UQ+K6cFvgd9Rv2ueGq6FqhjAlbRW4DpLtQXLVFsegUEebadkFYM61q4n7
 opXthBSiIF8+n5qbFEdt0kPbg6wZXm+p8DFiIdhR6w3mCO+EnL3EhNoPp5acR9YRxSGomeKAM
 1csM0LUvx3dCfEu+Lnm6TMXG4fAk40YSD8ou42j1LCEQYS0vS0SPYi2j6g+cZ3Q3RbncPE+Kf
 cwngo7q6I8c36TZ23IZuxARl9gXWroexK87ZPEau/NI+szTOYIjzGO5gctPAdrVVkYMv2Sl0i
 0qTAqlfwM6SZRWlJFh3sbbJdaiuFxUzSZiiXrt0jY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Fri, 8 Jan 2021, Taylor Blau wrote:

> On Fri, Jan 08, 2021 at 03:56:20PM +0100, Johannes Schindelin wrote:
> >
> > On Thu, 7 Jan 2021, Junio C Hamano wrote:
> >
> > > We may not be able to automate the thinking part to decide when
> > > submitter may want to get help, but an automation can help by giving
> > > the submitter cues and clues when to ask for help and from whom.
> >
> > I fear that we're striking the balance on the side of expecting too mu=
ch
> > knowledge about project-specific lore from contributors.
>
> I think that this could be reasonably addressed. When someone opens a PR
> (but before the hit /submit), GGG could say:
>
>     Your change touches these files, and so suggested reviewers include
>     X, Y, Z. When you believe your submission is in its last round,
>     please also include the maintainer, M.

That is an option.

Is it the best option to reach the goal where competent software engineers
can focus on improving Git's source code?

Maybe it is not possible do automate what I wish for.

> > We already have a ticket suggesting to add reviewers:
> > https://github.com/gitgitgadget/gitgitgadget/issues/219
> >
> > With this suggestion, too, we could go and extend that wall of text ev=
en
> > further and expect contributors to just know what they are supposed to=
 do.
> > But I don't see how that would make this process more inviting to new
> > contributors.
>
> Yeah, I agree that adding this as a separate step does not make sense,
> since it's hard to discover such things (especially by individuals who
> merely want to send a single contribution to the project). Having this
> happen automatically upon creating a PR would make more sense to me.

Right.

I always have this contribution in mind: Improve the readability of `log
=2D-graph` output (https://github.com/gitgitgadget/git/pull/383)

This was an excellent contribution. I doubt that we would have received it
without GitGitGadget, as the contributor could really focus on the code
change instead of the contribution logistics.

We did not exactly make it easy, and I fear that we are losing a lot of
potential contributions because of that.

For example, Git is often ridiculed for being hard to use, and I can
understand. There has been research into ways to improve that, but little
of that research resulted in contributions on the Git mailing list. I
would not at all be surprised if that was because of the review process we
put up.

Usability is only one area where I think we would benefit from attracting
talent. Accessibility is another one. Or UI improvements (consistency,
self-explanatory navigation, etc). Or...

Ciao,
Dscho
