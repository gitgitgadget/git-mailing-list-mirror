Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63B1620357
	for <e@80x24.org>; Fri,  7 Jul 2017 22:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbdGGWHd (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 18:07:33 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35594 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752569AbdGGWHc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 18:07:32 -0400
Received: by mail-qt0-f196.google.com with SMTP id w12so5913056qta.2
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 15:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W1/2Hu2jhffMATzz5Kec5Iu551IRoBbOVoYQGtmFP8k=;
        b=ryXjX94B3jo+5Dk/ItKAStNtVJU1k+RXY8mjuZ3fwrep6ewK91N0+4g7PhMjigkqKv
         75HJYTKYF4K1jd7gshtOdwqIE6Q9HFR4b81rjpIqic5AVhANDZMNCbkC8IyFB4YSTPAo
         UXNd/yCs03XgN7zvRHD07h97HO+ryFUWojHyaaUdUc1V/o25S1Tfy9H/RkP5m4nq3b1E
         APOThHdUyaOx9+2tc5KtMh9ob3KUWL3jPQItq+MCf5gX9kmNbitHStapuac4ejEopjtI
         2h02/QDHxVkBfMejrwrhnmCg6Mf3yDtNzwAl40/45GuaiIg8OrseswdqObSjRyMRW6B6
         OkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W1/2Hu2jhffMATzz5Kec5Iu551IRoBbOVoYQGtmFP8k=;
        b=hRpUx6DqQNNGvkaccA9x/bIn9RMk6dZ5rUh2PNEMIJZ8BDD4FxARLcHQnqgZM1M9jO
         oXJ7/QGmaL1BB11ZjXsCkFMg+W/rk3vdrTXemRfbLmy1zd+ZMBy+jvkoZ46TLobctz+A
         tqlPGiy3OXde7pwmBcZhmF0/ZBr11PfUWE5dF+4VDQGyOZGlX+aNzt4dD4uE08pAo97l
         dlY/JG/KJxv/bRnOkTLyNfD+JPKjL9s7AM6wXFQXqgvffXtwh2rGv3IBDIAAffJIeSdg
         uXD4F3SbRyKhETyFrvCj5exNjgrn0NWB8EE+aFBDC9SioKWf1va2hih+W+RIXOMbYoKR
         szeQ==
X-Gm-Message-State: AIVw110iwhGjMhCbRzipkpuq7DyMLee85OKvT43SnSxvAIBoVepM1GII
        YOk3o5gl4RHpAJwc1i8=
X-Received: by 10.200.44.87 with SMTP id e23mr43926912qta.123.1499465251230;
        Fri, 07 Jul 2017 15:07:31 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-05.NATPOOL.NYU.EDU. [216.165.95.76])
        by smtp.gmail.com with ESMTPSA id i5sm3672042qtc.2.2017.07.07.15.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jul 2017 15:07:30 -0700 (PDT)
Date:   Fri, 7 Jul 2017 18:07:30 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: Re: [RFC PATCH] t: lib-gpg: flush agent sockets on startup
Message-ID: <20170707220729.a3xrsju3rf4guyzs@LykOS.localdomain>
References: <20170707220159.12752-1-santiago@nyu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mtdjkfztb6mut4nl"
Content-Disposition: inline
In-Reply-To: <20170707220159.12752-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mtdjkfztb6mut4nl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

I don't know if this is a desired feature, but I noticed that, one some
versions of gpg, gpg tests are skipped when I run a test suite multiple
times.

Cheers!
-Santiago.

On Fri, Jul 07, 2017 at 06:01:59PM -0400, santiago@nyu.edu wrote:
> From: Santiago Torres <santiago@nyu.edu>
>=20
> When running gpg-relevant tests, a gpg-daemon is ran for a
> trash_directory-specific GNUPGHOME. This daemon creates a unix socket on
> the target host, and it will be used on subsequent runs of the same test
> script.  Add a call to kill the agent and flush the sockets of the
> relevant trash directory.
>=20
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
>  t/lib-gpg.sh | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index ec2aa8f68..22ef2fa87 100755
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -31,6 +31,7 @@ then
>  		chmod 0700 ./gpghome &&
>  		GNUPGHOME=3D"$(pwd)/gpghome" &&
>  		export GNUPGHOME &&
> +		gpgconf --kill gpg-agent &&
>  		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
>  			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
>  		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import-ownertrust \
> --=20
> 2.13.2
>=20

--mtdjkfztb6mut4nl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAllgBh8ACgkQRo8SLOgW
IpXwJxAAmAL02RrH5FaAORqDp1hH4hIt0jggwdcFDPaqaT3I6CWkRwddnV+iyPAm
CeTyOc0gASBNf2HGr2jqmr1X4sPFyqd7bgC3jqsVK8TVtpudk7MY1HiGG4bMCXkV
9QTL1MHTL+4QyjWDkF1rs88q+dKHIkd/5t0GcdXmm4t4MfrEh8zJgeJHe+vgSCdi
VmLKw37jg89j337we6+CwNkqiboLylXSfULrHOevMbgXoBIEmrZ8X4CJggfOqFgl
T9u6HgKHCdkwa45pL4cgpFAIeTSkB+hiyCcnBarOzCE5E4cjpFhpyVdLrA37M0+p
QqGGFsHjGLstEmf7QS2S5YlePNGgwvnIonoahL7DqvhxDvSbSzYOO64/dh4z3kY/
AxxlwUiNN21mpTsfRFhgcDLN8bzsNOlkaxJQKwAEt8xY2Vp9OIh0Qq5PUqX51HIZ
CnxNpCcM2A/LY/ableQ2RstptHBo79+/a/XExsl/S3/gHZpqG6TDIUexQ8dv4YjG
cX5JtdYrphrVjFXcerzKVPalhqLaCUtuQRQDbdlAsz3sZrTDls8dLzXhULko42uQ
/DjeUKWkE+Fv5UeEhM/RQxncQQby9tKPlosSKUS6ubkK8WAdnvhURk7SVupd/RYf
nKx/fpSaYu6tW0hOoW9s0Klw4Mak9pl/pGbqbP7Xmy1uZDPo8Xg=
=aX44
-----END PGP SIGNATURE-----

--mtdjkfztb6mut4nl--
