Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B5F21F453
	for <e@80x24.org>; Sun,  4 Nov 2018 21:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeKEGRb (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 01:17:31 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53184 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbeKEGRb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Nov 2018 01:17:31 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5930:2634:17a1:2ef9])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 18F8B6077B;
        Sun,  4 Nov 2018 21:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541365270;
        bh=B7xNjQ2ZMAJoxrFB5/uyxLdHYuxdo9sgI/9ilAfRyxI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=i4ev6PfRtsgirhGyY5+9rJy3bLJ1lG9R3LBmtCLSLsCUg5TQcOHcMGejE1467Poo3
         jmuQCxEKQQZdZBsTWTeIaRVEEHbJ7TJYyg8LNyHrazxkAQk6FKSPeiuTTkBMHLs3Yp
         ySQRgWUW0Z6+pwI70hyDZFF2SscQDonxs58EAjiDR20af5EMM4e5jfnsy6J2ivbztn
         PowISwQTOPI6ES2aF7BWp1m00uCrz3Orq0TTXQ9P+KEBKrZypOlhCelu3eMmuw4c9D
         f3xO6PcCyr1vBz7aC89WzQHGWRd8eZsedQLGKcqDA6MVS0Y2wX2BARW3Ug2xpVFu/P
         WPmmOboYr3vm6OSoIfa0EHHF7gkeJGjf8csqhL5ZSeFUIoxmzzFTnVDlu8HqMmGNRk
         4b1uOu5T27U6zMo70ERHUWDTLlSl1TVF+hpM4PDBSEjvnjlYaWPGbDXWsRncgF54Gp
         syzdUaCbPfboKCUbXC9Ef4nv2TXBlde8Gzjo9gMY7DqBT6Myfn9
Date:   Sun, 4 Nov 2018 21:01:05 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [RFC v1] Add virtual file system settings and hook proc
Message-ID: <20181104210105.GK731755@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>, Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
References: <20181030191608.18716-1-peartben@gmail.com>
 <CACsJy8DbiVZYmY11Nt4c_+egSi5tz0iVq7rNv2BiVdyJ4htgvw@mail.gmail.com>
 <1f7efd07-4881-daa7-cd1d-145bbf3ffcc8@gmail.com>
 <CACsJy8BqWu0YG_Q8EFNeDgrRhYCCKBU+zPJjrhAWFU_gTDCoXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uuKVzAmB+c+zQlhu"
Content-Disposition: inline
In-Reply-To: <CACsJy8BqWu0YG_Q8EFNeDgrRhYCCKBU+zPJjrhAWFU_gTDCoXg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uuKVzAmB+c+zQlhu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2018 at 07:34:01AM +0100, Duy Nguyen wrote:
> On Wed, Oct 31, 2018 at 9:53 PM Ben Peart <peartben@gmail.com> wrote:
> > It's more than a dynamic sparse-checkout because the same list is also
> > used to exclude any file/folder not listed.  That means any file not
> > listed won't ever be updated by git (like in 'checkout' for example) so
> > 'stale' files could be left in the working directory.  It also means git
> > won't find new/untracked files unless they are specifically added to the
> > list.
>=20
> OK. I'm not at all interested in carrying maintenance burden for some
> software behind closed doors. I could see values in having a more
> flexible sparse checkout but this now seems like very tightly designed
> for GVFS. So unless there's another use case (preferably open source)
> for this, I don't think this should be added in git.git.

I should point out that VFS for Git is an open-source project and will
likely have larger use than just at Microsoft.  There are both Windows
and Mac clients and there are plans for a Linux client as well.
Ideally, it would work with an unmodified upstream Git, which is (I
assume) why Ben is sending this series.

Personally, I don't love the current name used in this series.  I don't
see this patch as introducing a virtual file system in the Unix sense of
that word, and I think calling it that in Git core will be confusing to
Unix users.  I would prefer to see it as a hook (maybe called
"sparse-checkout" or "sparse-exclude"; better names are okay), and
simply turn it on based on whether or not there's an appropriate hook
file there and whether core.sparseCheckout is on (or possibly with
hook.sparseExclude or something).  With a design more like that, I don't
see a problem with it in principle.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--uuKVzAmB+c+zQlhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvfXhAACgkQv1NdgR9S
9ou97A/+J6+941Gj3za+s/+igtjUbvr4Z5bMELqFKBNH9Ow5dugFwpBsIN2+/4ci
j1K5hPGVxh3S4w2ZoRcR/iw6WshH7SooDglbhhnGxgzI+14bIPtS4l/173fGGGNI
PgigLAjsm6dIo6JsA5QShVVva6p24CTDNrvkUYum+nzmJLfZDpG68cUIpkLBZ6Mu
rlB8Dbc8it0SNUXBM+NVGfnpSNiD0MdfFaCES8k7BqV4CJkFmKuGvoUlOOLo5DP3
7uuOcqokQSbD9+LmPvmGy4y08ieChk0o24NC9Odx6R8FJbXgEwC/YkyrkB9xn5DB
MYrVHMjVYYZcp/NXOvaKvrgt9Y+2hZvQv1PeRwhWjE30YRWgbQ2fFxEpGj+9JvNx
tNVVMerzOlsFvkVEHAZAKKO57xnF8yIavsFuRdqxFHxwjQQJM1tBpCM+Mt7RTDSR
91R7QedCf/TigyRcpIPDbyDzCq2naUtUpr1SDUjPcrpfK2iFm/4zaEyWEG3i+5Td
gftRtYD6e2j1m0HYNVdcwk45JNWrfW82wsvUyKP7CSb0DvRKQ2MjVek/+vqsEjwg
yukuYUPh6RDjLZWVOtperf3u9xJBnVW6kIeIeDvIZFZwmlAB3QYJBMKBeIQT1ruP
Egxf6HN003WNLaIiV0wMqnCiPAMXI+qdJDkx27ec2PLy42K9+Rg=
=8k2Q
-----END PGP SIGNATURE-----

--uuKVzAmB+c+zQlhu--
