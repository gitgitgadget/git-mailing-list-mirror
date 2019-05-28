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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3540C1F462
	for <e@80x24.org>; Tue, 28 May 2019 11:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfE1LSK (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 07:18:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:46161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfE1LSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 07:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559042278;
        bh=H1cUuo59c+Xkk5F6xXVGTiHRmYiI7MwoduIX6SfgzBg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Kdqp3KjOzc1KAaNB04ZsQRSazddC5TOc65gRdh5zFc4OzWHvGVePtxKoCcMwpPs9c
         blUpIX8grIrZrSuqYPzFJcDgJ2gNmwe9w30GqpL7A2gXlYjTpdsQY2dsfbi1P15+N+
         trvXKeRJkFF1L34u/e72FvTdTMW5+v/CeCMsWvBk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1gXa8Y3lp1-018NcA; Tue, 28
 May 2019 13:17:57 +0200
Date:   Tue, 28 May 2019 13:17:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] bundle verify: error out if called without an object
 database
In-Reply-To: <20190528015133.GA29724@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1905281309490.44@tvgsbejvaqbjf.bet>
References: <pull.226.git.gitgitgadget@gmail.com> <f0545e872344dd25e11db7fe095cde1578b26748.1558987152.git.gitgitgadget@gmail.com> <20190528015133.GA29724@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1544196965-1559042277=:44"
X-Provags-ID: V03:K1:2/o8fSF/UZTY+9ab7AabO527vMDhRMHovPGdH8MFZMORhOg56Y8
 XQ7tjFfYuL3sNj3UvESu96f/hrFcYwurq75nk395qjD+2kNyn/28yBQLzXz8E2Keo4U9675
 JpxpwnLnWX3VKYdlGR3NpwIdtNy6LaqluC8Hsp2YAKPLPwZRyt0y7fKlq3hAu8KVIU3xxB1
 bmsnM149GW30nate+Lerw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PZJwAsoOxFo=:3hTcT7vH0u8t/rmVw0vGMi
 OTyGmZI46dtzy5phHDOlIvskrTusVdFw/onVW18BLGmj8bHyB2U02RT8gnY+cjl1dRLawxOg7
 OW3Tqdc0iHc4Uauu9fFKHeXmCyd/228MwyQugDs7G8O96h7/d6dRXH9wpFqPr/Ah2zQn1hUeQ
 yn9Aj1sOs/frV6GzV1mms34xIWR3u62OmXSckvTVWR6/8x852QDkIMvh8kYlb2oQUZeiMCo7G
 UQfEV01BNXP0NaESORW74vEMSrSMfDLbSqE1N41VE3dyEsGAJk5OSV3d3B2ROChlTcLiOPYYt
 7gwzo1a4QJH3y9ouoqlLz04nO82xm1He3YwwLrmsa4y0VRjmI4+ja2ValGMtWy/LMlj3p9xWR
 kZDYQgOpYSWw3tox4iokpRzn5W3WNoYbihDt5ziz/sACDzwWkCquHdjA/KKuvFIKiFEoQBr6M
 TNL3rBwvYLWcVzA8tKEPBVOax1hf9/eAJmUVwSQGWv6B6kbAqkwPMnbj5AXhCWaCCl15qoNfF
 fl8EMEQrmZcW7cE1Gdvouou3EWq9PgZQ1CEvgKXzch3IJ7C2E/OOn3GecLBX/VFbIIsWdcTRI
 kz/NN6a4xW7VNyXJVvIEWl120E9jT4wAc2oq9LKotj+3cExvUvA+dfTIM2FpjtOR1HHvCvlna
 VPVtW8ecttb+r7a1pyJQ1fmnrk9APOHc4WEOM0svmE/Edb8KdFXqtELcT53vAj/GfrWhuE96s
 pNd0a0EybOWTInCrfWj1LJ7yr5qn4JbIDb0p4rWSdnu/18yyQQTxuhfYUnWSpX0Nqi5wasq68
 vCsISOaEworWhjre2IwdRPIn6APUH8N6WpnMCiMcwO7nIMcrf1Qgmy0poCyy9chr9OX2e78+u
 gTT2FEuDG6rDWTecPFokzOf/PMDPyRJB6v7KMne0EwN0rse1qGNZl2sUnq+yZeT5qWjVquBLk
 1ntth0sz94JYczC0n7CO2HU4EADbdVz3oowKhM87AMSUWsibk6Hm+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1544196965-1559042277=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Mon, 27 May 2019, Jeff King wrote:

> On Mon, May 27, 2019 at 12:59:14PM -0700, Johannes Schindelin via
> GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The deal with bundles is: they really are thin packs, with very little
> > sugar on top. So we really need a repository (or more appropriately, a=
n
> > object database) to work with, when asked to verify a bundle.
> >
> > Let's error out with a useful error message if `git bundle verify` is
> > called without such an object database to work with.
>
> I think this is going in the right direction, but I think there are a
> few subtle bits worth thinking about.
>
> As G=C3=A1bor noted in the earlier thread, if the bundle doesn't have an=
y
> prerequisites, this _used_ to work before b1ef400eec (setup_git_env:
> avoid blind fall-back to ".git", 2016-10-20). I don't know if anybody
> cares about that case or not, but we could do something like:
>
>   if (p->nr)
> 	verify_prerequisites();
>
>   /* otherwise, fall through to the printing portions */
>
> and then just check for a repository in verify_prerequisites(), which is
> the only part that needs to look at the repository object at all.

I am not so sure that I feel comfortable with optimizing for the no-op
case. Because that's essentially what this boils down to: if there are no
prerequisites, there is not a whole lot to do.

And I'd rather have the command be consistent about its demands, to abide
by the Law of Least Surprise.

> If we _are_ OK just forbidding the operation entirely outside of a
> repository, then should we be doing this check in cmd_bundle() instead?
> We already have checks there for "create" and "unbundle".

Hmm. If you really want to ;-)

> Likewise:
>
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
>
> Those other checks are done with startup_info->have_repository. I don't
> think that makes sense here (we were passed in a repository object to
> operate on, so the global might or might not match). Doing it at that
> higher level means that other callers of verify_bundle() are not
> protected, but I think may be OK. The top-level commands are generally
> responsible for setting up the repository and bailing if the requested
> operation does not make sense without one.
>
> If we do want to leave the check at this level, I'm a little
> uncomfortable with how intimate this check is with the parts of "struct
> repository". For instance, who sets of r->objects and r->objects->odb,
> and is it possible for us to have a working repo struct that has those
> as NULL (i.e., where they could be lazily filled in)? Even if it works
> now, it seems like a subtle thing that could easily be broken during
> later refactoring.
>
> Instead, could we have cmd_bundle() pass in NULL when instead of
> the_repository when there's no repo? That seems like a much easier
> pattern in general for low-level code to decide when it has no repo
> available (though I suspect many code paths would have to be adjusted to
> handle a NULL repository argument).

That's more complication than I want to introduce. Let's just go with the
`builtin/bundle.c` patch instead, as you suggested.

Thanks,
Dscho

--8323328-1544196965-1559042277=:44--
