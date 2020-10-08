Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0168C433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D6F21531
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 08:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jrKBAY1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgJHINj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 04:13:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:36243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbgJHINi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 04:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602144810;
        bh=ND3QC8T6DzlkM1MXwumYq/WoXUhrvJlzK9kmXJvXBpI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jrKBAY1lY6yh9wuWat9o3k+9BWDRl/Sob0W7uxI9sZs7dzMlXVdV0A5WCvHq/nJ6i
         On5Sk8iQqpgl5QdN8iGLLwhhs5qlK9SjdSaapcIiSla7cLSqK3PpLzk+j8Hye/y9mQ
         wc9MfJRCnGqFe6RFGglqB1R+eiJWIixrFMjCH2qY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9o1v-1kLEWl2EWj-005m42; Thu, 08
 Oct 2020 10:13:30 +0200
Date:   Thu, 8 Oct 2020 10:13:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org, tytso@mit.edu,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] core.fsyncObjectFiles: make the docs less
 flippant
In-Reply-To: <xmqqv9gcs91k.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010081012490.50@tvgsbejvaqbjf.bet>
References: <87sgbghdbp.fsf@evledraar.gmail.com>        <20200917112830.26606-3-avarab@gmail.com> <xmqqv9gcs91k.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-860472456-1602144811=:50"
X-Provags-ID: V03:K1:JUptP6/9Eo2dkPlDKE0uRIK1JkYJVCoP/B8SN+A697YcrwVGYKE
 IzWhOWHYAHqujVDBzL27EqfuJKiYf+i3tKFWuXp0VrxBhboE4oHmEvAUrfcy44t6FhcAtGR
 ALCfyfG2EIXb2WZy3u4hGVT0Q1E2rCrSPdy8Wp6ZGzzJ4aJyFA+RXKthrlGP4zYA336iHrO
 bPE6TLjvw0nZl25XrMIBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+esBftxN4Qg=:b+TiawBwXn3Pzbuddu9CB7
 XEOGXNehCbaFxMwcTPTA66cWKajrbBhondBIGlfsm6BqEsnHj8V0teYyi5DHTIL3Ogzz5cs23
 94LtHMR17l7ft9C3a2P3zLUFdikF70SNE3MrepQn5Ah3SBthatvOmBnhgd2j/E95+BdOZfgjG
 umsRA3TdkwwQ4i7V8uua6a2QcBDFGX6BztQ89J12ZAm0+VTif7ny7aSUMGouG8UfzGgY4cKvJ
 sD2CZSwJUOKS2/p3HBqLYPJd5euB0yjLZgyOM14wVaaSU5T4FxmqLH3nhm27YMcscu0TA3ahp
 oAzDG7cZolNC4cifCDKofnkh+obTQSsO3KeA1e8JVy99PNLXFpvxeIaUk1n34p6AQjF5A2gcc
 +f5WHNKIMcYnRsXQl9V15aAaIKwIQuzSzqFq8UDTHdRVQdHHRMt6b1kXFvCyCNkQIyfwKp/+F
 vFiWFEwIduMzbmv88o4hsLtXuZfem+e1kbb5AiVhcGPA/k1oiFQzNDn4YgxSi2ba9IHPysv+S
 ZCj3Eg6HWwyVVbdTS/wWl/Dk0fTcfjdv+fcrDIvGyGLr5ufw2UMNjxc+PRz7EpCCWJMb2jjXJ
 CQxcQ1a44osPvxa83fzWGz1s5pMsXBSUwV935A8B51lKR7uEr6rFin6zuAPdaMN12/eeF/NZI
 N8hOrNqfaef8Jf+j1uuCkCqSLnkxKRvPkbjMyoVnotXJXLp2O1GN5ngBDImHqUWXWvxnJeqyX
 tL2EiyQsYfpqYyyT+YibegP6BP7AQBw3a1YS2slm+1GHvWwFIL0QTs2mJuzfqpGaP38q13ViF
 +X6MOjw39KZddp8B5/vl2XUPIPhjgUVJ+8K04j1XCv9JPg3K8PkWAoAb+iT4sxF9ppl10IrwG
 063XJAlJPdSZHVrpt3I8DIj75c+7NuKLqQes/0vsHFVFXVv/AYWiyjzML38HgBcWCTms0mEe4
 jxQMf1FQcXcnWozeieLGcOmYeDcc5kKxhmX3a2VjFoR7ITD0bN0kjlT6bXfhoFOnOb38keWA7
 UZWlpvPdT9QDwFImHMkaLTf2zepWiITjh+MwlDa+k9Q8ITTbuR2FTbazwWzaGhY22md8GSltU
 1+KMzWG6tJkrjfWBWhn8Z/Ijv123G4mL6dUun4FLqpvIpHIVj0Bm+yW3cBbc3b0i40teHLAKR
 K8eYPDi6djzQPKalQ2xcGcQRHrjGGG9x4m7yQyDcGutxVKbv496JHeyHf+0TKxVimCmK9oSXr
 0SJ557NPF00vssTWVR72L5o0Tu4YZab2xG28OaQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-860472456-1602144811=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio and =C3=86var,

On Thu, 17 Sep 2020, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
> > As amusing as Linus's original prose[1] is here it doesn't really expl=
ain
> > in any detail to the uninitiated why you would or wouldn't enable
> > this, and the counter-intuitive reason for why git wouldn't fsync your
> > precious data.
> >
> > So elaborate (a lot) on why this may or may not be needed. This is my
> > best-effort attempt to summarize the various points raised in the last
> > ML[2] discussion about this.
> >
> > 1.  aafe9fbaf4 ("Add config option to enable 'fsync()' of object
> >     files", 2008-06-18)
> > 2. https://lore.kernel.org/git/20180117184828.31816-1-hch@lst.de/
> >
> > Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
> > ---
> >  Documentation/config/core.txt | 42 ++++++++++++++++++++++++++++++----=
-
> >  1 file changed, 36 insertions(+), 6 deletions(-)
>
> When I saw the subject in my mailbox, I expected to see that you
> would resurrect Christoph's updated text in [*1*], but you wrote a
> whole lot more ;-) And they are quite informative to help readers to
> understand what the option does.  I am not sure if the understanding
> directly help readers to decide if it is appropriate for their own
> repositories, though X-<.

I agree that it is an improvement, and am therefore in favor of applying
the patch.

Ciao,
Dscho

--8323328-860472456-1602144811=:50--
