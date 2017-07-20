Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 871201F600
	for <e@80x24.org>; Thu, 20 Jul 2017 17:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965462AbdGTRBW (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 13:01:22 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37943 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965455AbdGTRBR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 13:01:17 -0400
Received: by mail-qk0-f194.google.com with SMTP id t2so2041921qkc.5
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/P0lWHPSQi3xKG/GGwhR9+ZBzRgNwLszJvotYg+L1tg=;
        b=DA/OZBg2Qxyck6/vAClpc1RTQOFMZN2vymhgIcEen+y2eLuVbUKlc0Of/CDkQFkjRe
         hHZ0d8al1sFzqPekQvd2wvj1BDxhKTNfXiQg8fYrwcfYv5AJTE/4S5LiIZ+5UBgnsoOA
         cbTJRooxYG8E2NRCK+vfQZgwIRZIgmhjydpuo9FqR5E6zjBf6o5JUiib5rhcL84nGCRI
         yoStzdcO2H0tquFKBIDX+DwuSyugBQk02/r46DhYRBgsiF6bdh7OZWOW381EFmgm+BC4
         AkRpdHhsLSDfKk23lVRsuaUwiP3V4jrULEhsFRO7gDvBUj06DMKl9XNdVn2PcWShDIr1
         ETpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/P0lWHPSQi3xKG/GGwhR9+ZBzRgNwLszJvotYg+L1tg=;
        b=bUw1aow7IVjAfYD+iNYWKkwgU9ne3ssFj+9FovxO7cuVWpUNka9SAsYgHTk60qoGBA
         hsm0TZdHkRxBzkFKQPLTR4pOGFhJc261sEOJ5e2WtIlq4g/twOECKSizOqOhY9nXnNkM
         NwHgkYsU8jfMaJ3qpptF9VpRwX4N45afkxKaqC/opIGtNxCZz6txv5MTQgEbSpcZlHWm
         Flrx/I2K+ZT2atAHg/SNn4/1m4dqa2CpBXxNvP7hgu979y2PYAuf+8hQtD1DxWN/6CBN
         uwiawLwWFgANG69Hkh6lZj7rrhOw+lX7Y3eTJGyOlI5ELiRyNsbuW8W/Ge5F5i+rl6/S
         8phQ==
X-Gm-Message-State: AIVw113nvhsr06PtihicPYu5/ej5vH3/d7NTug1kwldMfWSUWXqurf8H
        fK74BYiLf2MnjNGGaL4=
X-Received: by 10.55.131.129 with SMTP id f123mr5337108qkd.188.1500570075478;
        Thu, 20 Jul 2017 10:01:15 -0700 (PDT)
Received: from LykOS.localdomain (ENG-KCG295-01.ENGINEERING.NYU.EDU. [216.165.113.136])
        by smtp.gmail.com with ESMTPSA id u188sm1981008qkh.65.2017.07.20.10.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jul 2017 10:01:14 -0700 (PDT)
Date:   Thu, 20 Jul 2017 13:01:14 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: Re: [PATCH] t: lib-gpg: flush gpg agent on startup
Message-ID: <20170720170113.fvquowatpv4ms6if@LykOS.localdomain>
References: <20170720165814.30037-1-santiago@nyu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="elgj5gqkfwi3swaw"
Content-Disposition: inline
In-Reply-To: <20170720165814.30037-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--elgj5gqkfwi3swaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is the patch that stemmed from [1].

I tried to keep it simple and not noisy, alhtough it breaks the &&
chain, it needs to be run right before the --import command. I also
decided to drop the switch chain in case that regression was to be
introduced in the future in other versions (hopefully gpgconf goes
nowhere by then).

I was able to test this on debian oldstable/stable and arch.

Cheers!
-Santiago.

[1] https://public-inbox.org/git/xmqqvampmnmv.fsf@gitster.mtv.corp.google.c=
om/

On Thu, Jul 20, 2017 at 12:58:14PM -0400, santiago@nyu.edu wrote:
> From: Santiago Torres <santiago@nyu.edu>
>=20
> When running gpg-relevant tests, a gpg-daemon is spawned for each
> GNUPGHOME used. This daemon may stay running after the test and cache
> file descriptors for the trash directories, even after the trash
> directory is removed. This leads to ENOENT errors when attempting to
> create files if tests are run multiple times.
>=20
> Add a cleanup script to force flushing the gpg-agent for that GNUPGHOME
> (if any) before setting up the GPG relevant-environment.
>=20
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
>  t/lib-gpg.sh | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index ec2aa8f68..7a6c7ee6f 100755
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -31,6 +31,7 @@ then
>  		chmod 0700 ./gpghome &&
>  		GNUPGHOME=3D"$(pwd)/gpghome" &&
>  		export GNUPGHOME &&
> +		gpgconf --kill gpg-agent 2>&1 >/dev/null
>  		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
>  			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
>  		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
> --=20
> 2.13.3
>=20

--elgj5gqkfwi3swaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAllw4dYACgkQRo8SLOgW
IpWQTw/+KBUIlGgpNhdgQ86KN5hZ4Xeos52WCVLfCzG8Q5sDsIPD/hboSdRPjV2w
IJTZ+eoMsUyuOcQimxG2yZp16VOz7o9N/N89CQwOjaZnonqDg5zrRF2hedkV8PYU
iz1/i5xF/vKnlhL4ChS6ORW+7Bbx0wwM3AXSbnUeG2P86vUjB50zuma9tO835eBY
vhf5mN/GI7C0NwwoE6DANSSYiCtQ2wbEDKENPxPeKs9SvqIJxsZc6F9LS8vweFds
uQvQ6WYODjFrsqGlv+BHnwjrQQcP7pEUQTnlKkPRI8x0iXhgWs8kzrh9IoxfYV74
rtKjNfqcPYIcIJT7w1GMbz1br8GKpaEStcyJ3LZ5EMgL+5KsaUXgONo4nW0+2uQV
KAJHfnhlwS9cLlrSFc2meUJ8if9dPNtQ2YzImZWZPgc+cSp9r+8HoTa8JflE0gNF
1d40XZ3fho1HMZu2nRGrmfnvLJnkf2cGsyfH6zJp9E6NaUbOi25A7j4+54gWs4Bp
hcAgIMvUpeyW7hJItz+cb5WBG7jZgwy/fFlRdmXKcd4ZJNyQjw2dAj20gqvohtJ0
r1Hy0gqKof+qzNfrxzEmLzC0xfApD3Uqqzp5RKcZpklbNgpAaa7TuMZxLiB5z/it
UTvsMW6kMFEL9vGExIl1gk7GwJLY0l9A3OIklOsXxF3YDucicqM=
=zN1Z
-----END PGP SIGNATURE-----

--elgj5gqkfwi3swaw--
