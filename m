Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CFD21F609
	for <e@80x24.org>; Mon, 27 May 2019 20:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfE0UU2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 16:20:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:58793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfE0UU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 16:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558988416;
        bh=breGvCc6vFwwVj+yVg2d0K6AX+m3SGUD9MkQDc8sl2w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LNTbP8ZJAK3UPKADdZaMizQV5z51sBqO581piNLEor7TR5NpLPZPYx9yhxJmrRWIP
         6/X9WvZILQ5/6sl6D/HOiWgXsT2tN3Vtkngmjz7o+kVRcerELdy35Ml05vfZ1cLX29
         qpEFED2Abku0CD5kZ7TeNn0kvpxrIFIq40SolE7c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5a9E-1ggqxE04eO-00xZKy; Mon, 27
 May 2019 22:20:16 +0200
Date:   Mon, 27 May 2019 22:20:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] bundle verify: error out if called without an object
 database
In-Reply-To: <20190527200838.GF8616@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1905272219000.28524@tvgsbejvaqbjf.bet>
References: <pull.226.git.gitgitgadget@gmail.com> <f0545e872344dd25e11db7fe095cde1578b26748.1558987152.git.gitgitgadget@gmail.com> <20190527200838.GF8616@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1084637661-1558988416=:28524"
X-Provags-ID: V03:K1:vJMwx4ESY2cL6qjMdTSUPQp/0KNMWK36cRXUDH7zyDfAzpncZdk
 MtUIh2UfGSHOF5rRNHoo6KrZh+qc5nv8vaq7uvptvTJ5i/y+XVt6rabInbEEWhj71EiiLvf
 i7Qb/+ODIJmdoiTzi2ehSAXRZ2BuRPHvMTh0VGEVp0nF3174/p4M4dtinZSYJS2ckD9Q6hs
 7bOJg44kBMTdcXpLQNL0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zk9KYdv4eOU=:bI1a0IR8h/nPDXCH9Tw563
 Z97462/6VF69hA1S46XOgCxAmuyLi8W1wCqSdordnXIHlAk7F3p+NxG9eCZH/bxlunZo3lQdy
 mdllXxw4Htwhv6J/ShbVC28vILD8u3atPClgZtkkKS4Mc49oA7aOTkpRJ4m7IoYXtY9etEsWg
 Z0yKN+4slbB1XkeHCU1MCu/riB6pkOJ7zR2xbJlkUkhHLjJxgRHxvsLqv62k8mTGvEUz/UbJY
 IidkABpnC3GvsWsZYvpnc/Tm9PHfGIaIWVEm96ZJnxguy2yVU9NtgdwDiG+LMvPujyXjGBOc1
 aizBr2ZOMUzKnSJV3S2xfkunhIKkoep6XpQhiqyFVv5V6BGWF3QFuiyuOCLTIb79cj+LZM37w
 IYUSF8z7ng1ZCBYPtoe1YcqfSN6mBQQcw2ifGG78PaKuZZixJga1k1y/Kga+KoHiY2TGTi5Bk
 fwCHpY4W7HIslsMhk8UBItYKU4B8Ys79r2XO6M55Je8NgY30jHMpyUiD8UPSo5pJ7b20mpAuw
 32PscywHcOW2yyLNJ6/h/qPUPOS81osbqQSARMXjpjC87AUoKHFV1z1oMViozqo+hRhq6aH9u
 UbWfPlfc87VkbmZgs7oPXe9fypxNTJH7cQMh0OucnTB3CejlHvunOGs3J0gbAYTQLcl4HJte1
 KBqKnGwOpJp6PWTvXy/rPTlJ82iaf35LmHoGoY20NMyo6pVY+TEqQebZtS1N6wyLaOrIGm0W9
 +y5oQUvhV8miEjDwmo1zMTG1S4GReaZtn5gDWBndUTTDKYgb34+D1XtrR8tgLfsQzD4N6bg//
 b+MCMADrXWpaShUA7M0tYXtLk6Dn9Px7sA+Rv5GKcsY/4N9jcnST7W0yuSsAIBYAC9uAKEAbd
 blGBaM/BsM5KBzrDR+ghmwEfjU4WkWg7qVibYnBuuhfPQPmQqEA7Hkxsl9cALKDNdmGy6oHWR
 d77l124Vp6HJ/1t3mRb8+DDqhSxOblBOI8ER1Vkkg2iXlrxVYVgI6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1084637661-1558988416=:28524
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi brian,

On Mon, 27 May 2019, brian m. carlson wrote:

> On 2019-05-27 at 19:59:14, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The deal with bundles is: they really are thin packs, with very little
>
> Generally a colon can only follow what could be a complete sentence, so
> maybe we want to say something like "The deal with bundles is that they
> really are=E2=80=A6" or "The deal with bundles is this: they really are=
=E2=80=A6".

Thanks for educating me.

> > sugar on top. So we really need a repository (or more appropriately, a=
n
> > object database) to work with, when asked to verify a bundle.
> >
> > Let's error out with a useful error message if `git bundle verify` is
> > called without such an object database to work with.
> >
> > Reported by Konstantin Ryabitsev.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  bundle.c                | 3 +++
> >  t/t5607-clone-bundle.sh | 6 ++++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/bundle.c b/bundle.c
> > index b45666c49b..b5d21cd80f 100644
> > --- a/bundle.c
> > +++ b/bundle.c
> > @@ -142,6 +142,9 @@ int verify_bundle(struct repository *r,
> >  	int i, ret =3D 0, req_nr;
> >  	const char *message =3D _("Repository lacks these prerequisite commi=
ts:");
> >
> > +	if (!r || !r->objects || !r->objects->odb)
> > +		return error(_("need a repository to verify a bundle"));
> > +
> >  	repo_init_revisions(r, &revs, NULL);
> >  	for (i =3D 0; i < p->nr; i++) {
> >  		struct ref_list_entry *e =3D p->list + i;
> > diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
> > index cf39e9e243..2a0fb15cf1 100755
> > --- a/t/t5607-clone-bundle.sh
> > +++ b/t/t5607-clone-bundle.sh
> > @@ -14,6 +14,12 @@ test_expect_success 'setup' '
> >  	git tag -d third
> >  '
> >
> > +test_expect_success '"verify" needs a worktree' '
>
> Did you want to say "needs a repository"? Or do we really need a
> worktree?

Right, that was a place I meant to change after making up my mind what is
actually required, but forgot.

> Other than that, this looks fine to me. This is a much better experience
> than a BUG and a nice improvement overall.

Thank you! v2 incoming.

Ciao,
Dscho

--8323328-1084637661-1558988416=:28524--
