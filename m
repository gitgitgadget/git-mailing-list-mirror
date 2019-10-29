Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7473E1F4C1
	for <e@80x24.org>; Tue, 29 Oct 2019 00:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfJ2ANA (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 20:13:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55154 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbfJ2AM7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Oct 2019 20:12:59 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D2E3660423;
        Tue, 29 Oct 2019 00:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572307978;
        bh=/bXAJufv/t7h1fqAuPbTYf0Y2YO53Pszl35zRZBOffE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LJzl0aWQjqmSXwuAHNXoGDKsq1j48aburJDRzoBAMo4QfbTMbQDUSYNU34seRpopv
         1kawyXxm3eCaoXJR1L+q1R9s/+XOi+/uudLgIv519QLi1cMoQdcGZDjo3ZUHwfa8IU
         6h70MHZSNsRIUgVRz4mle3u11XCLVhVmnaKVu4w/sszm9i5rCl6xg4OzEbVuv1yY78
         vb47becOMXscwDXuffwnVcJWVP8uIE4D557R4WkiPu8tj0AizGNWxoJY8p+zMji6cK
         oXihkj2ItrKcL2X2zc9ZT+omLafrX8fBtOva6PjXXoKyTCDYSfA31M6Ek6B7RT+nsO
         3ytpolk3lQX96Xx/1yT92f3kn27KdfGDx4sK5jhZdYl4y7mxIB/SnEjoyEaQjL18xD
         0B9liKkLbAvHi92gBjhXHC1zeJyuTkNnTXbPYn16oVdEL8W2UgBVIYB+LcXyhQq2EY
         Qbfmv+/LwqdPrKJsi/LV6tr2MuVDE8nAYfpZnzkM/ge1TFaR6NX
Date:   Tue, 29 Oct 2019 00:12:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] Allow the 'revert' option in Git Gui to operate on
 untracked files, deleting them
Message-ID: <20191029001253.2lxsntgcivs2jhax@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.423.git.1572289087.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ezbhcl4e53l2vf6y"
Content-Disposition: inline
In-Reply-To: <pull.423.git.1572289087.gitgitgadget@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.2.0-3-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ezbhcl4e53l2vf6y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-28 at 18:58:06, Jonathan Gilbert via GitGitGadget wrote:
> My development environment sometimes makes automatic changes that I don't
> want to keep. In some cases, this involves new files being added that I
> don't want to commit or keep. I have typically had to explicitly delete
> those files externally to Git Gui, and I want to be able to just select
> those newly-created untracked files and "revert" them into oblivion.

Is there a reason these new files can't be ignored, with one of the
=2Egitignore file, .git/info/exclude, or core.excludesFile?

If so, it would be helpful to explain that in the commit message so we
can more fully understand the rationale here.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ezbhcl4e53l2vf6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl23hAUACgkQv1NdgR9S
9ovxPRAAiQOwmexq8YQTFThIBkO2edUXIfJpAfFTIUsw4q2nXqE3rIAMCRzqbt/P
Fco2tCGg7wd65tYRfYj4ZjmyPWuGu+e07TjeiNUwLKXOQhC7zl0x70+KRuYFwzuS
tKTPmd2VV1DSuI/jOK5EnM1Mt3z2MUGSdZMt9+Tza8oji8Ro3g7JZKYEUXjtbZCG
WIY3KUrtIXUwkqoMt7R/dpJdnyNGnGjE+ZVurLWPArrk8n2Yi2b0leS6R8hv4mnE
tafO/I9kJVCNe4ShGfMj/TzhN+YNdVfhgxviExLJka8F6eWVMkM/mhorOY0+Ksfl
FWOuIiMK6Q/klGJZL3YvdHlTibX41uHsBjmEpkzMQBV1UXSMo3HtQ+aysKVheP3x
FqMo6c0fbR/MFNtmezjWqCqiTyZO7FiMlc7fSvpMUAMjehrUwAv3sPyrBmn/Hz5s
JuxyO4c2eD3kFVsCLDhQWgLEgLHLUvTOTWQ21pvI9GHikxVT8aw3S6n3Mo22DxnL
BFl5bLNdZxVtbHp7NLdWxi46D1v345CPdUkAYEG+0b8M7QhIo8FORztY+9i0mSnH
6uNQRxeaEjo7a87LMuu6STxQ55fN+QjjOAVUuXYP7Rgtp8Z8B96c2qffaZdfl1Pi
lO/1JNj5aEDKWgT0WcOFcj9b8zVymfO0t8Plx27B1va1FzSgExk=
=/y1e
-----END PGP SIGNATURE-----

--ezbhcl4e53l2vf6y--
