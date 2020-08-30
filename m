Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A686C433E2
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 22:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D049A2083E
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 22:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JXlOs9mW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgH3WKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 18:10:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50530 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbgH3WKL (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Aug 2020 18:10:11 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 983DC60129;
        Sun, 30 Aug 2020 22:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1598825409;
        bh=eruL73ENvlnrG/00ZdzTpoXJ00i+GmXbKqkWF77vVKA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JXlOs9mW43WnZv8su10CV5kK72xPUOxSfvJgG36Gfdjy7DB9IEM981QoxGkPObRpc
         oN/qiKurua+fiFHc772svXpZ+tDoVAtgKa/1xUbv6dEIH9lfSK1MVO/dv1O9GhumTm
         Nipan7G3kfu5UHr/G2drjTNQmaDCyv6wATnUKDtQZpc4ht0ikUA7jiq+1A7AxzuNch
         lZqeM/0tG64p2zw960M2bpo0O4iC9anXzgsMen0SflGLxIe43AvHP4J3PX2gnDodEo
         NpurY/0uX4FyL012oAddwyQ02sacdSlNSjh7DYWoL3uM1R1HQh+v5A/6vKJL51QD9c
         j+a2FDz/WTk9nFm/u8qw75YsPUGxyp/CiL4TlZjRCKJGiUx/MXWnhZwuLowB0uRNxF
         MZ9QyAgMs5qlQyyYf/UQnhZ3qZlODjapfaosg3FpOGwKFGGi9Cvb4e+ZEPz1F06qqm
         GiV8HnZMW4DBTliY3urAPTju8a7MJ8faLREOvB428mfpRb3pajI
Date:   Sun, 30 Aug 2020 22:10:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Makefile: add support for generating JSON compilation
 database
Message-ID: <20200830221004.GB241078@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.714.git.1598815707540.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <pull.714.git.1598815707540.gitgitgadget@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-30 at 19:28:27, Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>=20
> Tools based on LibClang [1] can make use of a 'JSON Compilation
> Database' [2] that keeps track of the exact options used to compile a set
> of source files.

For additional context why this is valuable, clangd, which is a C
language server protocol implementation, can use these files to
determine the flags needed to compile a file so it can provide proper
editor integration.  As a result, editors supporting the language server
protocol (such as VS Code, or Vim with a suitable plugin) can provide
better searching, integration, and refactoring tools.

So I'm very much in favor of a change like this.

> +ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
> +all:: compile_commands.json
> +compile_commands.json:
> +	@$(RM) $@
> +	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' $(compdb_dir)*.o.json > $@+
> +	@if test -s $@+; then mv $@+ $@; else $(RM) $@+; fi
> +endif

How are those commas at the end of the line added?  Are they natively
part of the files?  If so, this seems reasonable.
--=20
brian m. carlson: Houston, Texas, US

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX0wjvAAKCRB8DEliiIei
gXxaAQDhuy9TbzwR9pOAX4UI1NMMY5n3ORv/cdRBbiZT66Pc7AEA3LGizTEmmJjb
WATo8FXqIY3W89ja8+/N+GukWkTZKAI=
=P0dX
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
