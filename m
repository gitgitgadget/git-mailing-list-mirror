Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA30C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E527560F58
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 10:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbhHQKHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 06:07:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:57355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239287AbhHQKGs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 06:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629194746;
        bh=AUZEszBJ8RGhveQK4xE+xCqn2zuOoebxwKEwmRXbe3E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=S2B9wnQOomIFLxRfQr584jaQU6ueU5kBHMpjU1uOwHuV3RSDML0455KMXJIukvfbb
         XA97BJtMDT6m78wdkKzLLS6kmoqt8cQspn/qyaaUTAOe2nr1239QL2VkHJphKqSTf1
         R2mQkMRqQcooq+tTuaykXBgm1qQsUhs1A0ildyT0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6Zw-1mixWx4C2I-00hdKE; Tue, 17
 Aug 2021 12:05:46 +0200
Date:   Tue, 17 Aug 2021 12:05:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/add: make clear edit and patch/interactive
 are incompatible
In-Reply-To: <20210817064435.97625-3-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108171202250.55@tvgsbejvaqbjf.bet>
References: <20210817064435.97625-1-carenas@gmail.com> <20210817064435.97625-3-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1590393394-1629194746=:55"
X-Provags-ID: V03:K1:qCp1stfDwShFpPzMsnOjkFG2GFsKPcvxLIcgMoY5omKj0HS5JoK
 PVO0m2lV+l+rgEHo/FnND0lJRIkbaQ51Xm55v6fovhWM3Gt46Kwv53+GW7uNgfppSSb2TQG
 3avGkMBni0ILn+pPJX2SOC9O+TUbG2cGqQEy0t0SPNpP2uIxqcAwFJhP+SfYfif2ylkhuNF
 pGO1idR5SJXMbcp9mFn5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XvOlt0K+zJ4=:ql4vBSQAHxp/Mz2UvT8qYM
 +phftdbKr+Rmxe512beY5p+bWDN9Ff9nV3E06739fSBc2YZIpQ8qxbB6CDxONH/39n81xIpS2
 8wnnFpKnDKslJp9y48X90eyYwP7A28EmG4v7l1B/pNHv9u7N1CpIsB14jOInU+m5Wus+bfrsw
 cp3lQUg8wNQ5+MCg0HM8et5RehFA3D+BwuangDz/HAtxFOuLyGypF1M0bPJZBorMDteyTcaHe
 2gZzhuAW6BS7BTSXC0lBrFzFfWkbZ3/pYzZPAYW3APFOtkBvlPgSItGvvHmbBh+kqBQ88/lQl
 yMnlsw6B0XPINXjERbsMnNSYX80XIePzh0PRZ08nnoPK3vdWE8V/XSVBaMCZuzhe8GkWKqP+d
 j5o2N3S7w5VVScHjalKGUUfqNnRmm4zuDbJhROUTIXzwePms+SlJlZpBxw8q+8HBzXnDbfG8L
 WuGVLrfKTk2QXsEJxnokYEwhyI2jga8nNqSQT1/99I3tn0Y4idTEju42oYTLWHKdJIPH9NuBU
 AruVu/X+F3jLX/nvEu2vfmrLlK/VIEAjcSNHT9FbBlnnCKVn1Uo1ndh7EiJeOvCC6KSODVIQM
 CLUoywkKEDn/M9NRBWUbFBwZejx54twspziW6D9hOnBk3yl45xRxV3JBEy8wLFLquYiYkUNW8
 P07YtisF5uw3XWB9mIoyO5GQXT+PHWUHpklvCwHRpZQCxDV0fvdlYuB7jIOuOOFXmvKGXr0M8
 bCwyin+AbucBbr4CR20pOt1j6GBcQSgPLvNUYStmE4xIWrDISZWt4OPTb92JD7eSohsXfjFEb
 Er+4ABAlSTTPwo7wXsgZdDkypB1xTKFr2B0bh00H4qXbHLTnI5nU8E46e+nFI/ri59OlA/OX4
 G0K/i7T03plGr2H3/VD0qIbCrd6WIqfzPLhv24AUR9EtIZzrzaqW+nDxINVyUOmvQU87/6hjd
 wQTn301Hn/jTGyjsLflv1ql18RTtu3aLx71qQdctItinh9Pe+PFmsmhQfhvQZ0s02bia/Lk9l
 nJCXmsXRNdR5A8C7rrxTZ9VdQZ7Bc5tnXUWp8xTYOsyHilOp0nRcB8Nq5m7PmlkyU5B9zZdnB
 HEm7zguQXEI7mKdDToz6PNQFnshTtDxnXW+Bn1I8YZKVgL/b3UBG8LPgw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1590393394-1629194746=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Mon, 16 Aug 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> c59cb03a8b (git-add: introduce --edit (to edit the diff vs. the index),
> 2009-04-08) add the option to add an edited patch directly to the index
> interactively, but was silently ignored if any of the other interactive
> options was also selected.
>
> report the user there is a conflict instead of silently ignoring -e
> and while at it remove a variable assignment which was never used.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  builtin/add.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index a15b5be220..be1920ab37 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -308,7 +308,7 @@ static int edit_patch(int argc, const char **argv, c=
onst char *prefix)
>  	repo_init_revisions(the_repository, &rev, prefix);
>  	rev.diffopt.context =3D 7;
>
> -	argc =3D setup_revisions(argc, argv, &rev, NULL);
> +	setup_revisions(argc, argv, &rev, NULL);

This looks fishy.

I guess this was in reaction to some compiler warning that said that
`argc` is not used after it was assigned?

If that is the case, I would highly recommend against this hunk: the
`setup_revisions()` function does alter the `argv` array, and `argc` is no
longer necessarily correct afterwards. Sure, if there is no _current_ user
of `argc` later in the code, you could remove that assignment Right Now.
But future patches might need `argc` to be correct, and from experience I
can tell you that those kinds of lurking bugs are no fun to figure out at
all.

So I'd say let's just drop this hunk.

>  	rev.diffopt.output_format =3D DIFF_FORMAT_PATCH;
>  	rev.diffopt.use_color =3D 0;
>  	rev.diffopt.flags.ignore_dirty_submodules =3D 1;
> @@ -486,6 +486,8 @@ int cmd_add(int argc, const char **argv, const char =
*prefix)
>  			die(_("--dry-run is incompatible with --interactive/--patch"));
>  		if (pathspec_from_file)
>  			die(_("--pathspec-from-file is incompatible with --interactive/--pat=
ch"));
> +		if (edit_interactive)
> +			die(_("--edit-interactive is incompatible with --interactive/--patch=
"));

This hunk, in contrast, makes a lot of sense to me.

Both 1/2 and 2/2 (after dropping the first hunk of 2/2) are: `Acked-by`
and/or `Reviewed-by` me, whichever you prefer.

Thank you,
Dscho

>  		exit(interactive_add(argv + 1, prefix, patch_interactive));
>  	}
>
> --
> 2.33.0.476.gf000ecbed9
>
>

--8323328-1590393394-1629194746=:55--
