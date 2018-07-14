Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44CF1F915
	for <e@80x24.org>; Sat, 14 Jul 2018 17:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbeGNSPu (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 14:15:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57998 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727079AbeGNSPu (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Jul 2018 14:15:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B73086047B;
        Sat, 14 Jul 2018 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531590961;
        bh=t1fEpGoMpHrYC1PyoTcASkGbJwBnuB7yvcMxVwIOjTs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TOZ3daXPsaneiSRmkyO3kd9kDZyoPez+DVLmRLvVOVMg4muQRm/FmU4isKUIF6b9L
         cTgswYNM9ezdVYtpNADWWTnVacYG+6r8zil69/aUbuGFvFmJswOwkAnl+GtLPuaJdi
         sKfUOy8YyNMUDaZuit5oy/dzFVYNsGJzWzB1TpTsNjC7rEM/36cpRKthgrxjvcYLpW
         4wtqPW92FMZLGXkC4WI2lo6OFGnEAdPwpwtWXufbdvzfklpkWRv79v3yFxBB3bP2lF
         NnVOKFdqCoyNAWi48XOJGbuWBFCNv3FsPdLSbA/M125ZgLweWSSEXFW0e8h+mD99mF
         UGHWmUcmZWsCvOLYw+zYkL8grGtbkjPe2HrUv1VO7Wx9oIV+m787Mef8a3a4sNvrDe
         2crt2juaOPVsE4rJtImaFwSmbl70QbaiL0eSxv+vjddUfwg7X4iZ/yPvsLJejYczGE
         LshfdDXjAJoJAfvuYnkHcEgZUewWh1DTlPLKDfV587FfF3Z+RRx
Date:   Sat, 14 Jul 2018 17:55:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Vitali Lovich <vlovich@gmail.com>
Subject: Re: [PATCH] sequencer: pass absolute GIT_WORK_TREE to exec commands
Message-ID: <20180714175555.GD1042117@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Vitali Lovich <vlovich@gmail.com>
References: <20180713230548.GC1042117@genre.crustytoothpaste.net>
 <20180714003505.67650-1-sandals@crustytoothpaste.net>
 <20180714005702.GA20399@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <20180714005702.GA20399@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2018 at 08:57:03PM -0400, Jeff King wrote:
> On Sat, Jul 14, 2018 at 12:35:05AM +0000, brian m. carlson wrote:
>=20
> > diff --git a/sequencer.c b/sequencer.c
> > index 5354d4d51e..c8e16f9168 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2636,6 +2636,8 @@ static int do_exec(const char *command_line)
> >  	fprintf(stderr, "Executing: %s\n", command_line);
> >  	child_argv[0] =3D command_line;
> >  	argv_array_pushf(&child_env, "GIT_DIR=3D%s", absolute_path(get_git_di=
r()));
> > +	argv_array_pushf(&child_env, "GIT_WORK_TREE=3D%s",
> > +			 absolute_path(get_git_work_tree()));
> >  	status =3D run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
> >  					  child_env.argv);
> > =20
>=20
> As a general rule of "always pass GIT_WORK_TREE with GIT_DIR", you have
> to deal with the case where there _isn't_ a work tree. Are we OK here
> because this code is inside sequencer.c, and you cannot do a sequencer
> operation without a work tree?

I believe that's correct.  We only call this code path from
sequencer_pick_commits or sequencer_continue, and those code paths are
only called from revert, commit, and rebase--helper; all of those
require a working tree.

> So I think it would also work to set:
>=20
>   GIT_IMPLICIT_WORK_TREE=3D0
>=20
> here. But if the answer to my "are we OK" above is yes, I am fine with
> either that solution or the one you show here (but I think the commit
> message should probably mention it).

I'll reroll with a mention of that in the commit message.  Thanks for a
careful review.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltKOSsACgkQv1NdgR9S
9ov1nA/+IB7L/CjwmEw3rzNpK/LN/5YIOXrvNb4Oe7pgtiKEipArYzyubyYwTOkh
xwN864gG9JzCscRB2ou7Cw+mJU2DuuoZ5KASr8oCtQD6HMIilfXY2Hvm2NlTqwEq
egPJqGOTfznhAgUVZb5obTV0lHZRbXdWaU7fCmmBTdoDtcm0LogpDZYswbSAgG3G
wP/B8hhSMcRtEzzWQtOOARbIALy7vf/P2BE1QALq/0ovlFc9WIGdfeI4FeN8vwZ6
GPGZ0CkNuKH0CjFpr7uF6HZ+hUp3pPVkC0NVEEFhggaqaVpstfAIVIr4b3viPLa+
1hC2fjk2FQPS0wXwaI6oY/cBlgsoXQTbXTr9xP0kLkhr8a/lAIo8gHnUQJbvXqzP
Ber6qRG5podPNvZgBLlIuCYWtjOYEgc0fuysvyJWhQdXF9ljJ5UcLiXeNSEBwx9y
POYz381Fv15ShFi6uq2zVTb7VRWrGpFSTyW16dbZyMMM/ycaKzbG6UkY/QAtJsUt
0gq9CfymzWRzqzxiVaVv2qJC+cZDTGMUIwinOwrG3cwPJwvPPiHbYCjUwXLw3Hl/
tj0hhtQl/ZOvg+O7rDjn/mLhvRhSSVavAIj0MY/CjZVsBC6jSXrN+AKf42BqdhUT
J1WSn/EKBfO4ApTKRSXGOS0hryiZPySai0+dDWrF1boYVfxR1Mc=
=unG4
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
