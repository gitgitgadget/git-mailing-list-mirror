Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 193AE1F405
	for <e@80x24.org>; Sat, 22 Dec 2018 23:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbeLVXMl (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Dec 2018 18:12:41 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57882 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725814AbeLVXMk (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Dec 2018 18:12:40 -0500
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BF3436042F;
        Sat, 22 Dec 2018 23:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545520359;
        bh=NdU5GKu5ztBDTs3gMBvjuPAopQv/hbzUT5EGPJ+uNXs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=n9Xhf4vp8K2i79YLuFx300/GGbaT5WGPtR5oUdNvJGe+iwy35etb67zi1/Y7Lt4eF
         mBEIpHSnmiYqQ7IUqv/r4FpnYXGkwna3wSVZjVGns3fzUJSRbWmPBiAK9uj4pB8JJf
         4Ab4LVIUeTM6ydpm7Ygl7IpwZLzCmubz+WJEb5FCJSVOqlmzDqlu5yps7st2R2gqx3
         MKDeAuC0JBgYFfkuwhDQQbCOrrLkwL0dfhpptYgNQdEsp8y8h1khVsmspOmSVd/atG
         7PYlD0ksgBgWFehwb+ERwCdtvySY/oX4h6vEbgQVkOGAlaZwpWGmCx9l2t5gAXGWnn
         xXoYJvmco7EbQsaEUTdCO/ViXqqLMNnNEJ4AOPkW5z1YEZwCCxVRlvi0SpfJJu9+wA
         z3RpouPHvcGeaKtEdVWdLKfVW1B1vSLXBMtp3HklKFW4PJrzT4/hHmNwk9DmBgOedD
         30ypSLN26S+2kEtz0T4JVxxnivuPAGXY/2llU03sZQrwGOT17Ul
Date:   Sat, 22 Dec 2018 23:12:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git-mailinglist@happybeing.com
Cc:     git@vger.kernel.org
Subject: Re: Does "git push" open a pack for read before closing it?
Message-ID: <20181222231215.GC26554@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git-mailinglist@happybeing.com, git@vger.kernel.org
References: <5878633d-cdbd-ce05-30de-3417386c720e@happybeing.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
In-Reply-To: <5878633d-cdbd-ce05-30de-3417386c720e@happybeing.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2018 at 12:46:35PM +0000, git-mailinglist@happybeing.com wr=
ote:
> Here's the output from the last command above:
>=20
> Enumerating objects: 373, done.
> Counting objects: 100% (373/373), done.
> Delta compression using up to 8 threads
> Compressing objects: 100% (371/371), done.
> Writing objects: 100% (373/373), 187.96 KiB | 33.00 KiB/s, done.
> Total 373 (delta 254), reused 0 (delta 0)
> remote: fatal: unable to open
> /home/mrh/SAFE/_public/tests/data1/blah/./objects/incoming-73lbb6/pack/tm=
p_pack_pL28kQ:
> Remote I/O error
> error: remote unpack failed: index-pack abnormal exit
> To /home/mrh/SAFE/_public/tests/data1/blah
>  ! [remote rejected] master -> master (unpacker error)
> error: failed to push some refs to '/home/mrh/SAFE/_public/tests/data1/bl=
ah'
>=20
> Inspecting the logs from my FUSE implementation I see that there's a
> problem related to this file on the mounted storage:
>=20
>  /_public/tests/data1/blah/objects/incoming-73lbb6/pack/tmp_pack_pL28kQ
>=20
> Prior to the error the file is written to multiple times by git - all
> good (about 200kB in all). Then, before the file is closed I see an
> attempt to open it for read, which fails. The failure is because I don't
> support read on a file that is open for write yet, and I'm not sure if
> that is sensible or what git might be expecting to do given the file has
> not even been flushed to disk at this point.

What I expect is happening is that Git receives the objects and writes
them to a temporary file (which you see in "objects/incoming") and then
they're passed to either git unpack-objects or git index-pack, which
then attempts to read it.

> So I'd like to know if this is expected behaviour by git (or where to
> look to find out), and if it is expected, then what might git expect to
> do if the file were opened successfully?

This behavior is expected. POSIX says that a read that can be proved to
have occurred after a write must contain the new data, so it's possible
that a separate process may choose to read the file and index it,
knowing that the index process was started after all the writes.

This is definitely an important invariant to preserve if your FUSE
file system is going to be used on a Unix system. In other words,
consistency (in the CAP sense) is required.

> N.B. After the failure, the file is closed and then deleted!

Right, if this had succeeded, we would have renamed it into place (or
unpacked it and deleted it), but since it failed, we clean up after
ourselves so as not to leave large temporary files around.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwexM8ACgkQv1NdgR9S
9osyvQ//U41O2fr+C70XVTBO/s0Ke6iaCvGEiv7rb1Y6oI2tMv6ZMuE898RIewGD
kavV6c4zn0YL3hx6ttlLFKtHiPw6z6EnRP7kjarPMrMPxpYoQJd+e78MuHHsK5gl
LSe/m6HbtvIvE5UstYN2PISsdmvBxrp3kKqNZi7ifcn7/pfzdEbi2kYjJCOWWOeO
Vx4nk9+Ke1DIZthGGvGzOp7Zd08RrBEelzpmSPQDLHeB6YmKGX0YSN9zB5OiDfw0
GCEKJ3QCEJ6nzB7JqE4xQdWkhvpB6+cKCzXb75jXBQOssV+uxcH7pj60kvu7IxW0
flD0oHN23fB7430AggiTxV2cS+aubRW53BB/AtZ30kmRfb7niHLjBYOBAB0GSBbV
O69Chv1HSFdEazYgCjBf+84uSrroR260cagCN2v/gCP9yrjP4KS8tiLER1Uk2iqm
6fRbRKmBREROG1tYzB5fKcmnW+g1QErvDPXm6grRoHwLftBN+E5TMLYuaV1fuWCK
X5K8SDboLXBS2+Jcvvr5h4o/dmz2b69d6OnQ4DIRMzA22N+QQx99SFoD28vNhUeO
MEg8xDWJsYHIwf4wZqQwX7Iz3HbHW2a/oAeBoqG5qE7Gjs6y4YwZXlg8GY6jKGum
4jSjuDfn+vS50Nhi1+y3ytBXmbyK7D+/F/aTxzp0Q0kOK79w7ME=
=+tXa
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
