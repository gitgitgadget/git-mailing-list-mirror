Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42373C43381
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 15:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14BA023101
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 15:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392779AbhAZPYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 10:24:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:37055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392744AbhAZPXy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 10:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611674541;
        bh=D0N/0vZdEsWwpk71arIErB2X5HpjCwk3mKdJmtIqv3w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CJ31lJfaVANvSeqdmLy9ZHvPfhrKBHRfa+wqDSWAaiaNniO1bGE0CmusbtTt0dq0K
         mwHaCX8b56Ummga/TZxEg3KM6fZoQfzFfNteGKxpxvVnS26iANCA9Mc+lel9GUnntl
         bxzMmrU2DGpN9iyrUZ5ID/B/2SopfuRcbZT0eUj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.88.23] ([89.1.213.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK4f-1lvhJU0lX7-00rF1q; Tue, 26
 Jan 2021 16:22:21 +0100
Date:   Tue, 26 Jan 2021 16:22:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] range-diff(docs): explain how to specify commit
 ranges
In-Reply-To: <20210122182050.xyzkvlctb4kiin7a@pengutronix.de>
Message-ID: <nycvar.QRO.7.76.6.2101261619570.57@tvgsbejvaqbjf.bet>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com> <041456b6e73b3a88097d0cc06056eb43d35d42c6.1611267638.git.gitgitgadget@gmail.com> <20210122182050.xyzkvlctb4kiin7a@pengutronix.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2120483012-1611674542=:57"
X-Provags-ID: V03:K1:POI4jkmi4ypLouZ7j6FlEX2iH28J6PumgYUKkZ0YeUIckHTbIIe
 HcQY0+/+M687hEmIq6fOmLYWlk1nqDsl4hrfvkAT8sQWTgjTme6hd/KQcJL2PhAqjMYh0rY
 bXmT8rKV2JgjOTw2KvHDRhNclvlo38jyTd5Z6Mk4qEvxx8dy32+usqPCO1sWi2rKt/nqdVz
 XolyPoC6HX5RrYN8qJZYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P3Gmngsf4IY=:1khFLCvZENXAPQvFDyqrsw
 K/MtvjJHPK4LQsoCFJTnzw10WAr1OLGrHl8gbMgagq8Q/8o/EAdCl5w0CaNYke0rcd8fkIufT
 VL/GD9necleHenV9UdkHvFG+cnFS4OLXISnOLOBNLG7CEcGjOInQ+eJnZfdoyAJNUna5Hm7bc
 fslvVs5S3DYpES+xJp9ROh9ZU7S0dr4zxzuWTXoxDEwfoW8Xpo+1hY8ZquCQoMB7n7FpANKSD
 ZxLvnrR8YuzuGdZZd6JtPGvrgzoszXj7eVb76V4EdQ3/JtNwofXkZhg+6VoKoMkvQgSINHkCC
 2pMa7VJ9zETA+6nZUxYxNS5+ftCSBeLaqi/ynWtl9q75CxUauoL3b66uh/QPLFcpvXJn7A13k
 n1Wx8k4otl0qsEhzoBEIsn70j2FioQStXJdAympq3xlSlBQdlzon4pBsyBS1nV09LottTaCJw
 ETrNSPIDw3cQlVLaFu8904Z6dEArEBtaRmVGnTYIzwawMtMbSM19mqT77uaep1GLVVn/ki82p
 JwE3pJ9ShxsofTFWlQ7OppyPOCOU7210JNHeZmb7j9dA4kcPDP+kr1/c+DwnCh6mH3/hvo49O
 Hy/ovdOs0dCwJKl3bqA5+0vULDVgM/9gahWAmv3U6qjfsO+Sz7JfzOsquych9I4jERTghJmay
 Y7RrSuiVUoLpWs5Bn+hA5au0aaXBNaTpSzXzUl8xFjfsRmtwleHveLCvBw4MVoy/eWLY5WfoF
 Pjt8lR2wSShkBg335bUO8q5/Jip6KgxIfNoO7ab0K/Npqpfg6HhNy2A2cko+ATqA3yPK0Dcwc
 rbOaRBZGctpv3zssmk1niNY63tuIiGExz326gxxrVZu46HNfn7Y9aMQZQr8mMZixPJwLx3+oQ
 R5bFwKImGsFt4410y+XpaH+OcOeqKIhUowv8yIi+s=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2120483012-1611674542=:57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Fri, 22 Jan 2021, Uwe Kleine-K=C3=B6nig wrote:

> On Thu, Jan 21, 2021 at 10:20:38PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > There are three forms, depending whether the user specifies one, two o=
r
> > three non-option arguments. We've never actually explained how this
> > works in the manual, so let's explain it.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Documentation/git-range-diff.txt | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/Documentation/git-range-diff.txt b/Documentation/git-rang=
e-diff.txt
> > index 9701c1e5fdd..76359baf26d 100644
> > --- a/Documentation/git-range-diff.txt
> > +++ b/Documentation/git-range-diff.txt
> > @@ -28,6 +28,19 @@ Finally, the list of matching commits is shown in t=
he order of the
> >  second commit range, with unmatched commits being inserted just after
> >  all of their ancestors have been shown.
> >
> > +There are three ways to specify the commit ranges:
> > +
> > +- `<range1> <range2>`: Either commit range can be of the form
> > +  `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See `SPECIFYING RANGES`
> > +  in linkgit:gitrevisions[7] for more details.
> > +
> > +- `<rev1>...<rev2>`. This resembles the symmetric ranges mentioned in
> > +  the `SPECIFYING RANGES` section of linkgit:gitrevisions[7], and is
> > +  equivalent to `<base>..<rev1> <base>..<rev2>` where `<base>` is the
> > +  merge base as obtained via `git merge-base <rev1> <rev2>`.
> > +
> > +- `<base> <rev1> <rev2>`: This is equivalent to `<base>..<rev1>
> > +  <base>..<rev2>`.
>
> git-log takes a range, too. There you can specify a single rev (with the
> semantic to list all commits from this rev up (or down?) to the root).
> So <rev> means implicitly <rev>^=E2=88=9E..<rev> for git-log.
>
> Does it make sense to implement this here, too? Maybe this even allows
> sharing some more code?

I don't think that it makes sense to support open-ended ranges. `git
range-diff` is expensive, its runtime is proportional to the number of
patches in the first range times the number of patches in the second
range. Allowing open-ended ranges will simply allow users to be stuck with
a long runtime by mistake, and I do not see any valid use case in return
for that risk.

Ciao,
Johannes

--8323328-2120483012-1611674542=:57--
