Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD9CE20958
	for <e@80x24.org>; Sat,  1 Apr 2017 13:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbdDANv7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 09:51:59 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59758 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751481AbdDANv6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Apr 2017 09:51:58 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BE726280AD;
        Sat,  1 Apr 2017 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1491054716;
        bh=GV4KE0Q0EEpOwbl6HtPG2d+DVBjwUJ8TTfAjnefGJ+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lnri2Sk+WX8JbsA6mMQvjFm2eZDNEQnYh0Gtk9NN6/18BWiXfM8mObw/XXpj99B3E
         kDE8ezja4xUQsJ3hvaFdu4o0/Ad691QvycNy0w+CQNIthSrSKoxf4ig4ceRkrffiKE
         xvgOcvZLQh9ZLys8gz6xi69kyLdDiTH1inF7ZIuytKkUBrJ/EHthlxHaNXnz6hZcGs
         thKeWBwK3H99tkaDiKMAaR6UskgXz+u+wwjrDrJxh58GftVMXU+Pry4nDG3cpdSc/C
         8qc0Q9nchGxwHFK9U31di8kbCk0A/o6n0jQFZkaPmx6aPj2Bn/daFC/o7LeRzDc3Md
         mibYTzpeSlHfa+DX5gAXqyjaDvsvk7gshSaNsG7TxwCSkgEYvvWAHUcDFVmYIgNnHi
         6B1E0/NcUF3o1U7Dc7xPouh/9HhmAKWXi6mybvdGyTjNRRC3v1mGeihQcg9kdNJijf
         1dV3HxilWxf3AvgIXYNzFfs7qvFcVzgvreUEGPYax8YoGRnZxxo
Date:   Sat, 1 Apr 2017 13:51:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] status: show in-progress info for short status
Message-ID: <20170401135152.sorijliupquoxk5j@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
References: <2c3c8028cd057428758bb1e21a064a264936de90.1490968428.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="onsaow6sdzurpziv"
Content-Disposition: inline
In-Reply-To: <2c3c8028cd057428758bb1e21a064a264936de90.1490968428.git.git@grubix.eu>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--onsaow6sdzurpziv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 03:59:17PM +0200, Michael J Gruber wrote:
> Ordinary (long) status shows information about bisect, revert, am,
> rebase, cherry-pick in progress, and so does git-prompt.sh. status
> --short currently shows none of this information.
>=20
> Introduce an `--inprogress` argument to git status so that, when used with
> `--short --branch`, in-progress information is shown next to the branch
> information. Just like `--branch`, this comes with a config option.

I don't have a strong opinion on this feature, but I would note that to
be consistent with other options, we'd probably want to write this as
--in-progress (with an extra dash).
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--onsaow6sdzurpziv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljfsHgACgkQv1NdgR9S
9otDAA/+JRDHbYlqA0AIpid+Jx0uf1BYOBGMNtSp4eOVL+rgChoETQ9A256UXVK0
uUHXRMf4GyxKPRQmZ+7JM+tIm9qEaQeDnzUpBDT9QieSZb/3f65BkUW4bGBAacEv
X/eun61luTYvUJBX3x2OZjjQKhtc2lKkAT8OvSuLAWye444JgH0Utz266jOht7jh
KiYFrLewsp3r0XAWcWJr/F0jcb/36xmpDDw1zjgNO1yNt2VPErue2df4juGO232Q
QNWX0+JVgBQl31gmBAHV9p4ZdA6vLsK+VY5k4I/dN4JQB5/zQwHLIoAkKLleewbh
ngOU7Srj+egVgRyTlz11wfcZC26xODm600UaWUL60dfmpU1mkOjNYPdPlF58po1G
nDbBAMkrrv+09ZhPBt207dLRDhiVeSDdlsEmV3y2ImYYDO7dUnf4qHn0OGQrQv95
ohgcdSBI92ncOd9Vi8oqb4IHpsiUteY1PNqHeZgF0oU5YaLlnQUZWG8hXQnTt7r7
i5UBE44/7KIZK5lZG/D4WCa2rPi6M3pOGY3wMXEFIq1miJG0OgHrNfHxu+eYY1/F
5Ng4HFnVAypQCWVdg3FR0k1RXixv+a4FRZ5YZby3iN9ecq4NoCotmNWSfb1qwr3C
0wcJQ0VkgYkOWhOz52BzNDBM6b654X8BdtqwNeft/ptUGhFNZWI=
=jlmd
-----END PGP SIGNATURE-----

--onsaow6sdzurpziv--
