Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5307EC2D0DA
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 08:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEC420643
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 08:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfLYIvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 03:51:40 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:39229 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfLYIvj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 03:51:39 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 03:51:39 EST
Received: from localhost (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1.3,256bits,TLS_AES_256_GCM_SHA384)
  by zucker.schokokeks.org with ESMTPSA
  id 0000000000020093.000000005E0321E8.00005864; Wed, 25 Dec 2019 09:46:32 +0100
Date:   Wed, 25 Dec 2019 09:46:32 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] built-in add -p: add support for the same config
 settings as the Perl version
Message-ID: <20191225084632.GA461356@ruderich.org>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
 <xmqqpngd60rx.fsf@gitster-ct.c.googlers.com>
 <xmqqimm5601h.fsf@gitster-ct.c.googlers.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512; protocol="application/pgp-signature"; boundary="=_zucker.schokokeks.org-22628-1577263592-0001-2"
Content-Disposition: inline
In-Reply-To: <xmqqimm5601h.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-22628-1577263592-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2019 at 10:39:06AM -0800, Junio C Hamano wrote:
> I think it is a mistake to write the lower-level terminal access
> code without using established libraries (or write it with a higher
> level abstraction offered by scripting languages like Perl and
> Pythnon), and I would personally take, given a choice between
> accepting such maintenance/porting liability and dropping of
> single-key behaviour, the latter in any second.

I've no opinion on the implementation or maintenance work.

But as a heavy user of `git add -p` with interactive.singlekey
I'd like to keep this feature in Git. It makes using `git add -p`
a lot more comfortable for me.

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-22628-1577263592-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAl4DId8ACgkQkv79t+RM
MvlDbA//TvDEAfjXyiW0g9pBaXfSgbY0/qvd1d1fl4G/YEjyci5BZ2CGYU+49AYq
AeY3raxT8YNed/4uAK4bMIAjFw5MsVCkpza5Q8w3j3Vw1MBd6oCabHnsxbaJDCSW
mrw8353JoD0gCA7oNyzBoOxPfupT7EmJav2+AGO/P1KzYb2QrbIsD6AEX1O/sGnF
7m0uIQVicwuRES+IMt/adI01lsbc4gxdJK/daTMYILNmdLen112Id++HYLbfi+Vf
MjOxiXQLnhN9hn84psB5zARaej27CrYueBPT0vMXI+TTDNycjOgzZeTQH3wBNlXD
6k9EsULqrKwVVXmIVB626nH04rUA063RL95xbaaAzE5AJKphmudHU6i4oqOGgnuA
aDgAppB2Cue+uV9vi+8v0iUHMCwr4LJHiAWf3MBeb6O5QQfOaq1I85OuOjMR2BWv
4sqa1HDt0NuM5HVBlCfGXiLvzydYtO0ULIR5nVehbevuTL1xPLsI9i9SvUwLMdK0
XvLmaamCxaIOlwGnzK1VSOYM0skGwYq/dYsw2o4tBm/gg7K0BJooYsOWeYMBMmvJ
2oct7GtfmzLGFAvotG4sOOt+4UgdUzshiyZZIuzptVnpk4AuImVWRidZwU8Jp5xO
9dygYkOtq2bpez05iIcHTaQ3x0Sr9UmxSejxSUrCjJwVeBptAqI=
=scPn
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-22628-1577263592-0001-2--
