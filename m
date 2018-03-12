Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B211E1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 15:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbeCLP7b (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 11:59:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60836 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932425AbeCLP73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 11:59:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: vmiklos)
        with ESMTPSA id 4730F2602CC
Date:   Mon, 12 Mar 2018 16:59:25 +0100
From:   Miklos Vajna <vmiklos@collabora.co.uk>
To:     git@vger.kernel.org
Subject: submodule.<name>.ignore vs git add -u
Message-ID: <20180312155924.elxjelkcriuwjdph@collabora.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ivclzy2qgki5jwhr"
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ivclzy2qgki5jwhr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

Let's say I have a fairly simple submodule setup where I do 'git
checkout' inside the submodule to check out a different commit, so the
outer repo 'git diff' shows a submodule update.

In that case

        git config submodule.<name>.ignore all

makes 'git diff' or 'git commit -a' ignore the change in the outer repo,
but not 'git add -u'.

Reading the git-config documentation if this is intentional behavior,
I'm a bit confused. It specifies that:

- "git status" and the diff family: handle this setting
- git submodule commands: ignore this setting

So that about 'git add -u', is it expected that it ignores this setting
as well?

I guess either the doc should say 'git add -u' doesn't handle this
setting or 'git add -u' should handle it. Happy to try to make a patch
that does the later, but I though better ask first. :-)

Thanks,

Miklos

--ivclzy2qgki5jwhr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlqmo9wACgkQe81tAgORUJZJ7wCgp4dM2O7bqILT6UQkXaH16DA6
khEAoIk7LuA4/a7yyNKC2FrVIrjdRMRn
=GB10
-----END PGP SIGNATURE-----

--ivclzy2qgki5jwhr--
