Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D41820248
	for <e@80x24.org>; Fri, 12 Apr 2019 14:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfDLOZh (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 10:25:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:35369 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLOZh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 10:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555079124;
        bh=uvPYYE2Iu/oXFiZ0o6yhLF3t/ClD8DvfSwfT82LxYko=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hikU/LMKl7Q4Xt/Mj5nYJTYlEuQwmLFedwt+rveiENlB/JPkLDP+Ja74vWGFvymKq
         FZJYEEwIDgcO836PfWqYGZN8zCVDTMJzO91yiPXCTcobr78vOA1AGYfejo0tj0LHth
         3pYcqED/JOW6v9gvsGgKwUEZ5E2jqBUJe9xTTLog=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MD9J6-1h53d20pA4-00Gcxx; Fri, 12
 Apr 2019 16:25:24 +0200
Date:   Fri, 12 Apr 2019 16:25:08 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 00/33] nd/sha1-name-c-wo-the-repository updates
In-Reply-To: <20190412001730.GM8796@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1904121624160.41@tvgsbejvaqbjf.bet>
References: <20190403113457.20399-1-pclouds@gmail.com> <20190406113453.5149-1-pclouds@gmail.com> <nycvar.QRO.7.76.6.1904102254500.41@tvgsbejvaqbjf.bet> <20190411205146.GK8796@szeder.dev> <20190411205857.GL8796@szeder.dev> <20190412001730.GM8796@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1095331993-1555079124=:41"
X-Provags-ID: V03:K1:AdJWG/S9VLQlu63SvlZDAtUOFlAAEbyO1Q6s82kepCNI/oBPV+w
 jjOXl3IsViOtwQfx6LIM5K7f/qj8FzPhmGZU0RSG+wZ3jXMg2x5b6aYC912VasvStv0f0wf
 dq9ry6cpYcBH4e5uZYHQDONJ020ZjgqvavT8gwmBl/R4WGRvY4njUlmbRF9lYma3iiBUMnC
 qzvFANukSB0pc7pH+oaMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k0fKC44rWhs=:kK6vawxa85XFyHnzzSuYDs
 64ADSHZj65oC+96X1inSAtmLOj2P/TGa+Gd+UyKb58uzqqk/bm4Qw8JVSqWUrbF9my/W31ea2
 KXlxKmABkMv8Yrf6aQv4xyO7xkW6c2K0gChf1yzrrzE1xj2cwmiPGCozsP7WZcQ4ctMcgbz3P
 pqB4d4o+Fji2balo88ExaH2Rqgy/1RAENZ7Zs3FaA6xHfZDpga+tIevmze8Lo6nY1+dxKMYf9
 LRB2SoOgfACCr2k2+3gWeZW0e07uW52xBLIfNUA0Cp/OHNXviq1qsxct99ovdKnDfY/9jWOj5
 aoZCUGbsHwz9DXrlkvd9BEq3TDOULw5CBMgr8teP7fboHdh1kMH0Re6m0ExI+PxeEKekjPl7g
 IKvV45wospuFOz4FIO21I97gKlJM7ilNNVjAefe8q/8tPmdxx97oHvks5+mSuQ8f38YzF+JXx
 nD7lCt+eh3U3uxBpqeRQFbJ8u1uvjyNaDJ+iDVRBkbYs6ALs+ruXzZm+9UFsZWDCWypYAHMIA
 y9Xa6n8pyqIRvUtvhWNQMfbp91BCUAz28+DiVYNDMS3mijHS91Rw0+BRZoxB1zUPuPb0FsfOn
 wGt7GX4Dr304bNar9z/uD73gVDPPy0PXX1UYSzWquYJObOj8ouGjN4Q3DDnhzgnrU/2F5jSCo
 OGZcJt+zzeKz8gpHJ4pVwlfE3WP/Nr7wbXYQcV+ajB+jlsN9FioyQCtr+quog8eEXn3+i46Rp
 4Sl47LprpzliE1kd1TIVvaOEscK48kuGRReyTU7mCutQidUWZarhKdYB+D09KvRtIED/b5lcY
 b7mMaBTmeHWT8op2TY9PpBc1UoqnbqkV5GMr0phHlQhVhzPJ3IGsBFS5/at9dKc3c8TV3ULsb
 swEwOf2U01Id7UwhHDz+xvCcrNVDXG7nhoHC0Uky8c+f/AKX+BbtyAEN//NElXSr48uucRhc7
 SG+R0KbNJPg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1095331993-1555079124=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 12 Apr 2019, SZEDER G=C3=A1bor wrote:

> On Thu, Apr 11, 2019 at 10:58:57PM +0200, SZEDER G=C3=A1bor wrote:
> > On Thu, Apr 11, 2019 at 10:51:46PM +0200, SZEDER G=C3=A1bor wrote:
> > > On Wed, Apr 10, 2019 at 10:56:52PM +0200, Johannes Schindelin wrote:
> > > > >         ...>}
> > > > >
> > > > >       @@
> > > > >     + expression c;
> > > > >     ++expression r;
> > > > >     + expression s;
> > > > >     + @@
> > > > >     +-- get_commit_tree(c) =3D s
> > > > >     ++- repo_get_commit_tree(r, c) =3D s
> > > > >     + + c->maybe_tree =3D s
> > > >
> > > > I think this is wrong, and admittedly I had the very same version
> > > > originally.
> > > >
> > > > When you have an arbitrary `r` in any `repo_get_commit_tree(r, c)`=
 (as
> > > > opposed to `the_repository`), the conversion to `c->maybe_tree` is=
 most
> > > > likely incorrect.
> > > >
> > > > Therefore, I don't think that we can do that.
> > >
> > > So, as far as I understand, the goal of these 'c->maybe_tree'-relate=
d
> > > semantic patches is to prevent "generic" parts of Git from accessing
> > > this field directly, as it might not be initialized in a
> > > commit-graph-enabled repository.
> > >
> > > Only three functions are explicitly exempt, while this last semantic
> > > patch in question implicitly allows a few more that assign a value t=
o
> > > 'c->maybe_tree'.  These functions are release_commit_memory() and
> > > parse_commit_buffer() in 'commit.c' and fill_commit_in_graph() in
> > > 'commit-graph.c',
>
> ... and make_virtual_commit() in 'merge-recursive.c'.
>
> > and after a quick look these functions seem to be
> > > rather fundamenal in the life-cycle of a commit object.
> >
> > Erm, not "commit object"; I meant the life-cycle of a 'struct commit'
> > instance.
> >
> > > I think they deserve to be explicitly exempted, too, and then we cou=
ld
> > > remove this last semantic patch altogether.
>
> And it would look like this.  Yeah, that's a very long line there, but
> I don't think we can break it up.
>
>   -- >8 --
>
> diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit=
.cocci
> index 57c8f71479..fe814f313e 100644
> --- a/contrib/coccinelle/commit.cocci
> +++ b/contrib/coccinelle/commit.cocci
> @@ -10,20 +10,15 @@ expression c;
>  - c->maybe_tree->object.oid.hash
>  + get_commit_tree_oid(c)->hash
>
> -// These excluded functions must access c->maybe_tree direcly.
> +// These excluded functions must access/modify c->maybe_tree direcly.
> +// Note that if c->maybe_tree is written somewhere outside of these
> +// functions, then the recommended transformation will be bogus with
> +// repo_get_commit_tree() on the LHS.
>  @@
> -identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|lo=
ad_tree_for_commit)$";
> -expression c;
> +identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|lo=
ad_tree_for_commit|fill_commit_in_graph|parse_commit_buffer|release_commit=
_memory|make_virtual_commit)$";

Hahahaha! That's *really* long.

And a good indicator that this should be hidden in a single helper
function (`set_commit_tree()`, file-local of course) that is exempted in
the cocci patch.

Ciao,
Dscho

> +struct commit *c;
>  @@
>    f(...) {<...
>  - c->maybe_tree
>  + repo_get_commit_tree(the_repository, c)
>    ...>}
> -
> -@@
> -expression c;
> -expression r;
> -expression s;
> -@@
> -- repo_get_commit_tree(r, c) =3D s
> -+ c->maybe_tree =3D s
>

--8323328-1095331993-1555079124=:41--
