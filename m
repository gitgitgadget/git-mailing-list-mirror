Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C131F424
	for <e@80x24.org>; Sun, 22 Apr 2018 17:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753411AbeDVRtQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 13:49:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59694 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751683AbeDVRtP (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Apr 2018 13:49:15 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E577A60446;
        Sun, 22 Apr 2018 17:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524419349;
        bh=SsBuz1X0Yj/YgvQcQsnv86wkgJPRD2KuOypXrHI+QoE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Xb2x106kg0aGPwAnyi08zbr6KP5mAXm1n4wOzhnp7PwhsyMHJt1TOaKn27qx+pJ/n
         bqTeI6BV87owYUvYruwPUPVSBOP2IiEDsfT+Qf5K65TQxnNzec8RTPpFbpk/k/7e/r
         8B1exgVn/U2PxfizdwIDfMDVAlvWDqOTv0q3CTYDcaHqtcT0nBspfdSFP5pe3dhSpk
         WpEPFksatOsYD2+VPs9Gao6BWSo9cyw+552AT83muIxxVZmqWLW2G08AcurZyeBIgR
         QI2iCyU+Tc+I8eoTGHDmbtZ5OPPxwHQ1RfeGhqzJn/jG4s/QqanqVxZJrXMSpRW71h
         DZiuLo76f1l+PuYJdjnyBGHjk5e0J7S3UyCrrjE5eMTNOBgmcYj/gInZ4zeZERfMDz
         qJGFebwaI/21NUfxFu9GWwiddRs8xQoH4c9y0xBbM9wxritnCCdNB7clAoFGTxDg0K
         kWnlqQEFVujNckAVMu68L/3oSnRKhxb76iBxG6jk/wBnlnIQAEc
Date:   Sun, 22 Apr 2018 17:49:03 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Perry Hutchison <perryh@pluto.rain.com>
Cc:     ikorot01@gmail.com, git@vger.kernel.org, sunshine@sunshineco.us
Subject: Re: Is support for 10.8 dropped?
Message-ID: <20180422174902.GJ14631@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Perry Hutchison <perryh@pluto.rain.com>, ikorot01@gmail.com,
        git@vger.kernel.org, sunshine@sunshineco.us
References: <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com>
 <CA+FnnTz-qdVK5482GJo06QrvMktGYhJAJ6g-Naq0BgT-uoRvEA@mail.gmail.com>
 <CAPig+cS+gf5gGM3fmnxk-6k7ezbtS=KQFqkkxVtcytHfcQApEQ@mail.gmail.com>
 <CA+FnnTwvnA90nDARKW9r7p5iraoOGTvfDJ26n6Udc68bDSUASw@mail.gmail.com>
 <CAPig+cRjYju4zEgiY_TuOOk0e7A8zNz+hu+40vQUEGDX6FGDxw@mail.gmail.com>
 <CA+FnnTzFomd91d1F6O-a28hXQ6PxOiBd44da4nSVW0MuDKgkmw@mail.gmail.com>
 <CAPig+cTw5GjB4VgFD2teDvMuyGPFFoNSCqbXbarEXCe3fVdLjQ@mail.gmail.com>
 <CA+FnnTzkZS7HP61Ck3y5p0EC7J_h=ToR5tq5cvEpJ79vYuSxZw@mail.gmail.com>
 <CAPig+cT0ogLmiviWhdZTLxDM7+VN3hk7wgkKnvX96Ym-yXR5bA@mail.gmail.com>
 <5adc355c.rJrv6ddtapM9C9H5%perryh@pluto.rain.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJAclU0AInkryoed"
Content-Disposition: inline
In-Reply-To: <5adc355c.rJrv6ddtapM9C9H5%perryh@pluto.rain.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-trunk-amd64)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IJAclU0AInkryoed
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 22, 2018 at 12:10:20AM -0700, Perry Hutchison wrote:
> Eric Sunshine <sunshine@sunshineco.us> wrote:
> > On Sun, Apr 22, 2018 at 1:15 AM, Igor Korot <ikorot01@gmail.com> wrote:
> > > MyMac:git-2.17.0 igorkorot$ cat config.mak
> > > NO_GETTEXT=3DYes
> > > NO_OPENSSL=3DYes
> > >
> > > MyMac:dbhandler igorkorot$ /Users/igorkorot/git-2.17.0/git pull
> > > fatal: unable to access
> > > 'https://github.com/oneeyeman1/dbhandler.git/': error:1407742E:SSL
> > > routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
> > > MyMac:dbhandler igorkorot$
> >
> > Try re-building with OpenSSL enabled (remove NO_OPENSSL from
> > config.make). You may need to build/install OpenSSL yourself to get
> > this to work.
>=20
> Explanation:  "tlsv1 alert protocol version" means that the server
> requires its clients to use a newer version of TLS than what was
> used in the local build of git.

I think the issue here is that you're using a crypto library which may
only support TLS 1.0 on 10.8[0].  GitHub requires TLS 1.2 as of
recently.  So this isn't really a problem with Git, so much as it's an
incompatibility between the version of the crypto library you're using
and GitHub.

I expect that due to the PCI DSS rules prohibiting new deployment of TLS
1.0, you'll continue to run into this issue more and more unless you
upgrade to an OS or crypto library that supports TLS 1.2.  As of June
30, TLS 1.0 will be pretty much dead on the Internet.

[0] I surmised this from https://www.ssllabs.com/ssltest/clients.html,
but I don't use macOS so can't speak for certain.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--IJAclU0AInkryoed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrcyw4ACgkQv1NdgR9S
9osTiRAAkuPluwBK/zisc4tHnDvw/yTMH4s8o2oK+RjM75dxfJH3IbKGCOgkurvy
Rd2ndDoRiqz80PhB/+l2lg0Y9AXgU8gUn/qvQwyP6fZx32nQfGQRrbFzb/EqkUAS
5hHPEtnozr7Nwhw82hDIbn1Flb5xNn+NDKCwk1TxsEIWfNLrA+WiHdo6rgIZUjtH
lizv0A5qK85hpQlHeyb7WwLz2dhR42sIWmoNLTzDYlTLCovcI9reEWCD1Cgtaxx/
ZhVKzx7u413b3TpHrl56hG/XCwn3k5/R3Hh1uZew18LJj+sf87EXDLrlMA+xvziD
gDZiFDdPPmnp7EXUXwBS4o3EiTBpcpH2fibiYO+S017I6ySGEQ+HbJEYrdkINba+
iG8U9Ua/krpNIKH/DRi3Ki+sIicNwEt4cn96zqHPc+M52Tsow9vnAOE31KUwaQn4
rNut1AccyZ7bQ9f7hq7057wmNBtK5m8VOYvcGkslEorV0plW7jrkh/ds7Zktoz3S
qkGxuz7vTpKC9QpE5l+P44oRjdddYyrHQUp7FiybO5ISgkXGnjyEjrDROxG6aJzf
QCg19ghQ5j2/uOaacCD1V9CClGwMb3twx5o7AidAyN6OqOPpALDJXY71OtsiXXsy
fewdMV4Mp2fhta2d6OSDbJoDHaiVdzivsREzydgH5GXxk42oeQ0=
=1syP
-----END PGP SIGNATURE-----

--IJAclU0AInkryoed--
