Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B851F403
	for <e@80x24.org>; Mon, 11 Jun 2018 02:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbeFKCES (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 22:04:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37016 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753728AbeFKCES (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jun 2018 22:04:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7ED7860129;
        Mon, 11 Jun 2018 02:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528682656;
        bh=XZcPcAI3zWio4wdSuFmzgbIpA+Hbj8WnNSISHpEmwK4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=nScwxjsA9fQdZnDQLbGtl+kUS5x8vODCR9n/zxFWa9NJ00v4fuVwJbFFvW0Ea5qvb
         vWT1uXGjyXzqDw3P49O0CH84Rny5+P2+i5LeCCFp7dqT62kOlm66ku0INttIro+1Gx
         WjL1eQKRC/hVvoldeHgNZ3Wp5AvgrrIS+7PNE7hKTp3C88HyX5SBszWe5ZYvJZ8WTG
         amv6LsjzsESQCB4EsOEtGhq0dfC2ifVYANByZf+hH/DMBnu8sjjM9dp6KpbxdPED58
         +CKHz0bZ325vzbtTCH6+ex0DWlZusUWlBx41+EfyLR7Cv/G2z1T5Ulhh0rWV2oGeWE
         AvqorjRlUOI04k+a8KkEtnuVBLm816t+J50I9eSnNvHdml0QufCjW9of1C718y6qkr
         bHMJlS60bu0U3Q1XiMxhynn7+JxmdlHcoDw4MGWRubRmqV2q1kkq+UVuZJ3ydoOQ0a
         gpnXDlfqsBN6nyAju/GiN0zxtDDHlTmCqtTaCwr/Rk46emSFcdQ
Date:   Mon, 11 Jun 2018 02:04:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Clemens Buchacher <drizzd@gmx.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] checkout files in-place
Message-ID: <20180611020411.GE38834@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Clemens Buchacher <drizzd@gmx.net>, git@vger.kernel.org
References: <20180610194444.GA1913@Sonnenschein.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
In-Reply-To: <20180610194444.GA1913@Sonnenschein.localdomain>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 10, 2018 at 09:44:45PM +0200, Clemens Buchacher wrote:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index b6cb997164..17af0fe163 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -923,6 +923,14 @@ core.sparseCheckout::
>  	Enable "sparse checkout" feature. See section "Sparse checkout" in
>  	linkgit:git-read-tree[1] for more information.
> =20
> +core.checkoutInplace::

Perhaps "core.checkoutInPlace" (captialized "place")?

> +	Checkout file contents in-place. By default Git checkout removes existi=
ng

"Check out".

> +	work tree files before it replaces them with different contents. If this
> +	option is enabled Git will overwrite the contents of existing files
> +	in-place. This is useful on systems where open file handles to a removed

Here and above, uou don't need to hyphenate "in place" when used as an
adverb, only when using it as an adjective before the noun (e.g.
"in-place checkout").

> +	file prevent creating new files at the same path. Note that Git will not
> +	update read/write permissions according to umask.

I'm wondering if it's worth a mention that running out of disk space (or
quota) will cause data to be truncated.

>  static void *read_blob_entry(const struct cache_entry *ce, unsigned long=
 *size)
> @@ -470,8 +475,15 @@ int checkout_entry(struct cache_entry *ce,
>  			if (!state->force)
>  				return error("%s is a directory", path.buf);
>  			remove_subtree(&path);
> -		} else if (unlink(path.buf))
> -			return error_errno("unable to unlink old '%s'", path.buf);
> +		} else if (checkout_inplace) {
> +			if (!(st.st_mode & 0200) ||
> +			    (trust_executable_bit && (st.st_mode & 0100) !=3D (ce->ce_mode & =
0100)))
> +				if (chmod(path.buf, (ce->ce_mode & 0100) ? 0777 : 0666))
> +					return error_errno("unable to change mode of '%s'", path.buf);

So in-place checkout won't work if the mode changes and we're not the
owner of the file.  One place where I could see people wanting to use
this on Unix is shared repositories with BSD group semantics, but that
wouldn't work reliably.

I don't see that as a problem, as that isn't the issue this patch is
trying to solve, but it may end up biting people.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsd2JsACgkQv1NdgR9S
9ovqyxAAj/D7oK2yyLtI6DcSdUzAVdYGZDzceS+5sIr2Ef7LWjJYKvvyx+ULYPJU
IgQRrltftqztEQiVVRrVb7aBXxVcS0l2AMdtW1rC/olSfVH/RQ1FFKcO+f0Quuyi
xKvqDjWfz4G62+KQMc2knlcDSypOLlf9uOz/uA/DLbfEIGojI3JGOFtdP8aqXu9g
vp3PnlV+159iCMgVfZu+8M8SS2HpxkGieUk2bcZRLpCog22VG3PpXP44tBsprXtK
2N6k8BluFAJhKb0QSCXf0M9xaXEXFH3VNVgfl9+jHlg4AytBV+WedwlZiOycJC+8
t62U8kuKEf8/MJeo6tPe5VrPJQcM7mde+2YLbcvEDl+pqJIcmVGSK8ZDWwQgQ3BW
0sUG2qFHjQ3QFwoWwBmVAwE9BEmJmhtg+9Mm5RTvV5FXgvochrEAr98Eai6utTaI
caJvAmUXNwPYTqtlzUEIrJ+8b3kLBDXDk86ST2WLxgiy3uVBCiKPeYe3PvmQJpLW
gnq+awxgnsded29TpQsRmoE7FMJwFQ7RXEmNm4D2DDnhLcKDLGIjRejEvnuz3c3J
5TeJN0ThcjZrqMonR2eLjoU6sRORIaAuiZ4bluS0UB2slRTrAHpzG3FjrnYMs6Cd
bTscTvbxQ5tC9vIQ8gAb826UYZjlufcEXmvYrw+JERsBC7HaETo=
=Tvpx
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
