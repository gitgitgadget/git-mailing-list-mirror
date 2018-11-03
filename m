Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6D4D1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 16:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeKDB4S (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 21:56:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53098 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727615AbeKDB4R (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 3 Nov 2018 21:56:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:293f:cdba:df65:a13e])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4B9F160758;
        Sat,  3 Nov 2018 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541263468;
        bh=cI3opYg3WmkL3ZgHWQOVGUR1Tb2teWM7AXuzvYB2Iss=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uQLJaFdpUc01qe8sOl2j2GECXMw3f0SWsEsOm48zoAdSdNoIJf55opSfuxBr1l4k2
         z52zargNB0N+zjDyhExk4o1Rpy8vSEPYrQxY+9DfqXIc1k8ChcP0tlqR5W5Guira4w
         og2D1uLYI7cfGMdNAWghxM+7CZAeVNgqaHh/eX2TRLDrKALxYBp2sjJYWNhctXgwId
         TkEnyGCGQhD/QahbGZyomuaNQc4Yt/Dp7Fp8n9T/t3YlBt0J8j1nYFZMBwqR+P7B6V
         quiTUY9J0mUTft9hS+pB5opBvY9s2sVVSoeb1VBZurau3KZHu6DQmEmpbpNv8sXw3F
         rmKSInQYX3DhLm3U7XkG44sEffIZ5PCJRb5RPJbMl1JFGJ7TFj1t3VvwfYdrXJwHyZ
         cQLHjU1yf5XJA/IuhXwFawUWsNBT55FCEUyHtMpzgyYD8F2ca+unWcGhmVSqVIZgtq
         JRwQPmbiyC53dYAU73adw/3NYQKw3YlfesZ4Voqj9xkqs1FNdp3
Date:   Sat, 3 Nov 2018 16:44:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Peter Kostyukov <peter.kostyukov@kohls.com>
Cc:     git@vger.kernel.org
Subject: Re: Git Slowness on Windows w/o Internet
Message-ID: <20181103164423.GE731755@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Peter Kostyukov <peter.kostyukov@kohls.com>, git@vger.kernel.org
References: <CAEL6bLrY5OgsjrZSSHDfYgrjefninR4wuZhGCsop_f-HCH7Jmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
In-Reply-To: <CAEL6bLrY5OgsjrZSSHDfYgrjefninR4wuZhGCsop_f-HCH7Jmg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2018 at 11:10:51AM -0500, Peter Kostyukov wrote:
> Wanted to bring to your attention an issue that we discovered on our
> Windows Jenkins nodes with git scm installed (git.exe). Our Jenkins
> servers don't have Internet access. It appears that git.exe is trying
> to connect to various Cloudflare and Akamai CDN instances over the
> Internet when it first runs and it keeps trying to connect to these
> CDNs every git.exe execution until it makes a successful attempt. See
> the screenshot attached with the details.
>=20
> Enabling Internet access via proxy fixes the issue and git.exe
> continues to work fast on the next attempts to run git.exe
>=20
> Is there any configuration setting that can disable this git's
> behavior or is there any other workaround without allowing Internet
> access? Otherwise, every git command run on a server without the
> Internet takes about 30 seconds to complete.

Git itself doesn't make any attempt to access those systems unless it's
configured to do so (e.g. a remote is set up to talk to those systems
and fetch or pull is used).

It's possible that you're using a distribution package that performs
this behavior, say, to check for updates.  I'd recommend that you
contact the distributor, which in this case might be Git for Windows,
and see if they can tell you more about what's going on.  The URL for
that project is at https://github.com/git-for-windows/git.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvd0GcACgkQv1NdgR9S
9ovJIw//XPQ7OAPpnMJbC7NSjlSf1EbY83LkeQ8CYKPmBB6hpS8xxxEBken1djui
+QSKaLzA46tql7azp8IvwKxjVB9zQG/g0DMcYeiMsWyZoAG6JhgASwvpl1AbfO+r
adbkzKoZLJilGlZwXvfaTmyWaQ8RoyYf9z7iwXFYP13kp+W/LuDlmB63U5TbVHj+
AFCBLicqgk5ClZjVah0OqiFKaJPExvFwXTAbunuB/E8anrM5g1Ec6kvB5LZvR3s5
dLYLHB87I+d+3dDPN1DH7cr9veE/DRnyrW6lxOZoZRNoMlINgpT3W160kKWSqiwT
HJYbrUiCdSv4gV12TIx+8N79l2aUSJe4EU/yJIgHTNIp9SJs8ZYyjngQfC9Or8ps
s6WBgePlvK2J3Q1rT3uXuIg6oVMF/varrRW+/e2bXg4z7FOTKN88XznkZiEZxnLE
YhDt4QqaX1Gn03/ZTDYvhSicLfzAa7m9mpqClZHp7qgL3RRzjT7+woFWeN+cY7CS
8HMQPP1E+PK8SgFk86o9xtMqik8FN3sOBW2DDZiPMgl7HbxI+MY5lt0Woks/5L9B
aV2E3BYBgzwhI4CS72XQdO8t7qACNMgt62sfqgYEI5vEK6iWudS8ZiuISCEi09N2
w81btfZUiXjqfy78BB+LSBN7ztaiDxVwsxKXZdmVJDrKrAZ8W/Q=
=SVlE
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
