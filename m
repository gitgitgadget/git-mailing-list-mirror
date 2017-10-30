Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDF5A202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 23:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbdJ3XYi (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 19:24:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55720 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752002AbdJ3XYg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2017 19:24:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DE5CC6046C;
        Mon, 30 Oct 2017 23:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1509405873;
        bh=cuoyz8mf6d0IxxV8sIejxwD9DqnTJP93bH9WwHzEJSA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=GPnLJnwR0eXEZVFQbOJZ7qAUnxvHnmJcquLnqALCzfevPARlZO90YdoKoRRCS16F+
         yx4nJDDLZ/xrXr9z1bDMe16C0cJVJOVFC2XSC+8Pl3JsRNq86HCB8cL0cNjmjXF5Ly
         FTtAVxDXLzYNOEOLu7V1RPj3zFfCz7g8t3PF9FjkTcxCH1b6HCfYfXyDdchOwcEQef
         xhKBqgSrPmmzZ95WGj56Gk0fWoaRN+zgbvYj6isA/sjg2HHyykXxILoUFloSpc3NkS
         H8IIfAyuZVe4eUvAupKsD9xD2Rx5JOzAr3Hknc14hubBQDSGDK9EuUvtXam6+5u24u
         +ZvRyvu1ck69Q+YGBv5fQLQnuLmkOzLZpX6lgUtYiCyqz4K7Ii8y7XjzPIxT9cJBJ2
         mvd1G7Yj4bWsHvc3efk/SXzrCj4cOwg3+j5BCyqbqwllpea18IineY+79gY7F0e2G7
         RDkmt+H+YISVFFpB0PyjPhKKY0f1jf7ufoySs1sU6xInmeSYjeu
Date:   Mon, 30 Oct 2017 23:24:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: convert SubmittingPatches to AsciiDoc
Message-ID: <20171030232426.mhghvjfqeujgsrfa@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20171029211308.272673-1-sandals@crustytoothpaste.net>
 <20171029211308.272673-3-sandals@crustytoothpaste.net>
 <xmqqa8096yzu.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1710301333420.6482@virtualbox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6yotjllfnyzzzkeh"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1710301333420.6482@virtualbox>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.13.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6yotjllfnyzzzkeh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2017 at 01:35:19PM +0100, Johannes Schindelin wrote:
> If you want to go into the direction of the web, AsciiDoc is actually the
> wrong choice IMO, and Markdown would be the right choice. Basically
> everybody on the web is either supporting Markdown or being asked by users
> to do so.
>=20
> Assuming that *that* is something we want to pursue, I would also suggest
> to move the man pages away from AsciiDoc to Markdown (using e.g.
> [ronn](https://rtomayko.github.io/ronn/ronn.1.html)).

The thing I really like about AsciiDoc is that it works well for a
variety of output formats.  Markdown is designed for HTML, and only
HTML.  It may have converters to other formats, but then you can't use
any extension mechanisms in HTML.  Markdown also lacks features that
AsciiDoc has, like cross-references, named anchors, and the ability to
write the linkgit syntax.

AsciiDoc, via DocBook and the XSLT stylesheets, supports conversion to
PDF, DVI, PS, and ePub, among others.  The things I'm seeing for
Markdown to PDF involve either Pandoc or a browser engine such as
phantomjs.

Also, AsciiDoc has the benefit that it has only two implementations.
Markdown has so many variants that it's hard to write things like tables
in a portable way, so we're going to have at least as many problems
(between the website and the codebase) as we do now.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--6yotjllfnyzzzkeh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAln3tKoACgkQv1NdgR9S
9ot5FQ//QXvHdEG34gOc2L6yMAUf6zJrseVB3S5B0siCsIk60fF6z+bi611mE8yu
g2aaJz+ylmQZ/svZQOsqi//b3wgnqn7ktYSlqnU2dqnLJyk1+Jw/GuZUUk/2mgG/
EG94tmkcV0PuX/zosNVldQhLPjKRhWSxUFA9tiF2VAmn3uKeuSI2TAwEKvrrphIi
pZnmCpV0CI9SeREn+ItIRPgjhER44dMNw1a7Y0bHpjU2BLMKbB5smllW3tk5vrXi
XvS4XGpmUsX4yGzIL0ybQGjP7x9/KGiqanJmyeXrrfew/+844KbbSCOSCLCD2vx2
qDhY0cDaGh8CHP8Q3K3DLtZoqgvOd46TZbor6d4p+PIPK3sKBOW/SN7xlwLSA5Pq
K0ogjHqeFbrWjBgkNyeDQ3IifXk67115C/BDdCdmP2ZWxQZwWuQVjNjDKOfkS4+Y
HqgkQ5lOzdQp2FBdf5/IE7nsE+yGyhMHuGtmqILCXDg+2aqtbAmy8n5ZKKglQ0Gw
g7DnCuD/MIWVgMRw+HTQ6jDgR0wxnROVYtbgivyPXRBvRulVJ59MPJ34eQeKXTCO
op1RaqXPiaXrz0kE+tYSkkQxQmVbn8rfjC6l6QDPriHRpOCE9ux5w/2Mdzr5+3lJ
NXwCVa4fIDYxSjTve0QRKxhLHSSifK+UDw2cAc+MnxMELu6JLB4=
=YFhq
-----END PGP SIGNATURE-----

--6yotjllfnyzzzkeh--
