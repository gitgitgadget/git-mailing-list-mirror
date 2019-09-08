Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34CC31F461
	for <e@80x24.org>; Sun,  8 Sep 2019 22:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfIHWYg (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 18:24:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58610 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731041AbfIHWYg (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Sep 2019 18:24:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:2895:5875:49cb:eb31])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 050A560459;
        Sun,  8 Sep 2019 22:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1567981472;
        bh=gB6xK9oI4+Bh60fglpDzo9xk/epr87s43eLeRw/kcFY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qaezleIjbOLy6xG/vmm14mGO0a0wor/JwGpEib2Yu0kRSOhSD3df3wk8CsK5cen0s
         NCgrz5PukAVyhT12lF20lHl3T9DE6WjMlsM5eQronpMp55IC/3ptT0sSUNMJvs6Vaw
         xfrIJ1oP0vICUWBW60h68+3end68YSM6N+3AI0K7qE/E9F5hrie747G2/7/o2Xmtd2
         rQHXox/dLajHlgqMLPLzHlHDgFe9g/ht8gWHr3VCGT9BZIu3Uh6/R7rfgTiE0i0ksK
         v8r7Le47iwS1LCVZjqfBKs0oKfsDJh23XL72nYZN7GB/w3JkF/fjlX2GdKR9dXGclS
         yuRjusjpjqBUM1XVCiu1qgaMO6ZN6Q+ILitLUsaSzmPPjdPwICC17i89AwRUiKwPm+
         buV18MbI8WSuOT1whPX+KhGBRiDq7PNGTCXmiTv7LdKZXntfGxyXuDdjQb5FR9Hl7Z
         xjNQsHSxlPgU1LUt9cNh/kbvEd2fJSEmEZ4l0Yw0ipVYxOqCbdO
Date:   Sun, 8 Sep 2019 22:24:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix build with Asciidoctor 2
Message-ID: <20190908222423.GN11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
 <20190907170746.273984-1-sandals@crustytoothpaste.net>
 <20190908104833.GE15641@sigill.intra.peff.net>
 <20190908171807.GL11334@genre.crustytoothpaste.net>
 <20190908212122.GA8514@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MSd2ShuMixI0uVaZ"
Content-Disposition: inline
In-Reply-To: <20190908212122.GA8514@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MSd2ShuMixI0uVaZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-08 at 21:21:22, Jeff King wrote:
> But it's not clear from that whether asciidoc's docbook5 backend inserts
> an extra newline, or if it's part of the xml translation. Looking at the
> actual XML, I see:
>=20
>   <listitem>
>   <simpara>hand resolve the conflict in the working directory, and update
>   the index file to bring it into a state that the patch should
>   have produced.  Then run the command with the <literal>--continue</lite=
ral> option.</simpara>
>   </listitem>
>=20
> which looks OK. I wondered if there should not be a break between
> <listitem> and <simpara>, but it's there in the asciidoc version, too.
> So I'm inclined to blame xmlto/docbook5 here.

Trying again, I'm able to reproduce this.  I found the cause, which is
in the stylesheets.  XSLT stylesheets have the ability to specify
elements from which whitespace should be stripped (using the
xsl:strip-space directive).  In the DocBook stylesheets, listitem is
specified as such an element, so the whitespace there should be
stripped.

However, in DocBook 5, our elements are in a namespace.  Therefore, the
unnamespaced stylesheets specify only "listitem", not "d:listitem", like
the namespaced stylesheets do.  Because this happens right after the
tree has been constructed "but before it is otherwise processed by XSLT"
and isn't affected by the EXSLT extension that allows re-parsing the
modified tree, then we end up with the whitespace that we don't want.

There are a couple ways around this.

1. We can force xmlto to use the DocBook 5 stylesheets with the "-x"
flag, but we have to know where they are.  Debian and Fedora have them
in different places, so we'd need a knob to figure out where they are.

2. We can force xmlto to use a custom stylesheet with "-x" that merely
imports the DocBook 5 stylesheets using a URL.  If the user has the
DocBook 5 stylesheets installed and XML catalogs configured (the default
on Linux distributions), then everything will just work and the system
will resolve it to the local copy.  If, however, things are not properly
configured, this will result in multiple network downloads for each
manual page.

3. We can give up on xmlto and do things ourselves.  This has the same
problem as option 1, since we need to learn how to find the stylesheets.

4. We can send a patch to xmlto to make it use the proper stylesheets
for DocBook 5 and hope upstream does a release and everyone upgrades
shortly.  Since xmlto is not at all active upstream, this seems like it
may be an imprudent choice.

5. We can send a patch to the DocBook stylesheets and have them include
both the namespaced and unnamespaced versions of the element names in
both sets of stylesheets and hope everyone upgrades.

My personal preference is #2; I think that seems like the best choice
forward.  XML catalogs are well understood and well configured on Linux
distributions.  Homebrew supports them adequately, but you have to add
an environment variable to your shell configuration to enable them.  Of
course, if you're doing _anything_ with XML, you'll have them enabled.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--MSd2ShuMixI0uVaZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl11f5cACgkQv1NdgR9S
9osxAQ/6ArQi+Fq9qbW+MSR76MAAZIJymXQjFseBR53H+stZP+XnVzBNl47GxeFr
h28uFb+ZjiJajJ/iF/NAqzLhi2Rl65xuOU2K6cFhFDeBqXoTFe1jiqbqIz4HYBJJ
5hvU+isLkiqGbnPLl3Z1rZcNujNQnPpR8/t65kDcEab/Kmw7k9loXj+XPsuimvCu
PU0WVHg0qj/0fTVI/j6lBYZG4izBkM4zLQszq9MXFZH44AUSw9HTspHeEXqiOh9i
Qykq1yGUc6uFElMsiiVE0ctTKwpqwlg1uwH3maNlCXVxurW2uImGpwaSrKh2CQLs
KIunLyIj0BDfwWmoJdaOnvODlMeaZSGDbjiFT00oJ1phWLZSrLolWH5RV99Va9Ls
WdieqjgmT34LZF5LxFNDR9oiYgILLYCyTF724ssvTxEH+KDflaiTIdHtXy79hgYg
s6iO1NMBUE19Lb/dt9YPm/ezamRQaq/42LMNM0VmmiViXvyyla/bMajR48hfe+8K
sUPZmCVC4G1xOkwxnhfL3p/1QD7Y1yTuPELC610YTUOh2TXZCgw2kLxIBU2XamxG
cGefthcAY9BuYc4HV7Bi+jlf5WTM4g6CvvJ8A2PhiTa63pLT9UAVDCjJOfCWj+10
cXY3i8JIjDNWJsyddYaJEsN75x49SPlWgImG103QM6roqWtF5kc=
=1FCB
-----END PGP SIGNATURE-----

--MSd2ShuMixI0uVaZ--
