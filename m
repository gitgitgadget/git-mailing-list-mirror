Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8675D1F4C0
	for <e@80x24.org>; Sun, 27 Oct 2019 17:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfJ0R65 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 13:58:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53972 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726930AbfJ0R65 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 13:58:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7CC9360459;
        Sun, 27 Oct 2019 17:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572199135;
        bh=X16Ms0JCXIaaWOLjL+mUX5JhJ6qyXWUA//yzaEs1LXc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Imkhd3NY+DB3rc20PELK1IWxGb1yVbvbxA9n7X1AWN/lxbpdCwUt088SuRqxMtcXf
         z8bhupJ/eQNppCUU/nyZ08Dvw37WLRiOHsftIRA2X20kk+BbTpbX+h0bbXP0UAVToi
         51dQBobDIvmXyw15St9kgINJNl803AxulBJ1V6DfsbOgNJBbaWr5QeYtw+JE6G9gva
         x9JlcRSfItUEtG1x8+RCAe8XIbB+F3RBbkjtqDl2IEiAK5EzoOKyGSp4tVEzXu6CFg
         M4jtUA04fZg6dPsRu/gE+1C9o8blh2IKdPR9li/neq13yoQrSwfCYWwEEJw6l3btDd
         /I6DP8l3kbaNI3mb6/RUZ4Fz6hZ8TViH1DVakxsnPrMiZ8ox1N+hhTxeWNcyqzvzMi
         eT5Zf4O8mTsdP6j7iv1Br4D4abIcct9jVoxuo7zptVHGh4f4iy9dVfHZttGn0J/2ry
         A+ofk9TVkPcQVjIvrjwuzaA2l+YEm9qMMmnweoR9G2DWFDaGtG9
Date:   Sun, 27 Oct 2019 17:58:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ingo Wolf <ingo.wolf@gmx.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: WebDav WorkDir Windows not working
Message-ID: <20191027175850.b6le5r3jf3cxtnah@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ingo Wolf <ingo.wolf@gmx.de>, Git List <git@vger.kernel.org>
References: <6c355683-726d-c497-d5df-bb7f8ea770d2@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3zjlg5r5bexigydd"
Content-Disposition: inline
In-Reply-To: <6c355683-726d-c497-d5df-bb7f8ea770d2@gmx.de>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.2.0-3-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3zjlg5r5bexigydd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-26 at 03:07:39, Ingo Wolf wrote:
> Hi,
> Git Windows somehow does not work with a Webdav Workdir even wenn
> connected to a Drive-Letter.
> It seems like everything work except stat.
> So I can checkout to the Webdav Workdir and all the files are checked out,
> but git status says the files are deleted even still there.
> I can also commit the files, but next git status says deleted again.
> When I checkout the files again checkout says error files exist.
> This is somehow strange.
> Unfortunately I still can't add a not empty worktree, my workaround is
> add the worktree to another dir and then move the .git file and edit
> the dir name in the worktrees/xyz folder.
> But now I have the strange Webdav Problem...

Knowing how WebDAV works under the hood, I'm not entirely surprised that
you're having this problem.  WebDAV is an okay file transfer protocol,
but it's not very good for expressing rich file system semantics.  Git
expects a file system that provides most of the POSIX guarantees, case
sensitivity excepted, and I'm not sure that WebDAV can provide those.

You can try a couple of things which might help.  You can set
core.trustctime to "false" and core.checkStat to "minimal", which may
help with the inconsistent stat information.  It's also possible that
your WebDAV server has a flaky network connection or is nonconformant,
which happens sometimes, so you could try a different WebDAV server
implementation or a different server.

If none of these seem to work, then you'll probably have to come up with
a solution that doesn't involve using repositories or worktrees on a
WebDAV mount.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--3zjlg5r5bexigydd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl212toACgkQv1NdgR9S
9os5/w/+OUGnsbNO81VATcEjKgulSf1EPiQ/pNSY8pyPU7WobcKIcSfsj0KLqAw8
16Yk5SBBcN4vLUCBcN6t4DxO+OAufMizwWHoMDl45hnZc4r6ldeFeUckRAk/7krG
wKR5ALPp0WVge5DZb+P1BahRXvux5n0KBXn7fKnQyRwPeXI7fdA2sOW2klkMPICH
xKrnLK05kwuKhCfTmYlRp8So2rFBGtvc7I1QbluoNf1k62wb6PSWmZOVE+F2bvLr
Idd2+HdHb8Ycyar+ikCjBsVEG7KjNI7qs/YX0UDZuWMIcunjxaiVjOshuj3qCGDj
RfECyGuqZN3vNJnKUdmLvUYqfTdOBrDn7YOc6oJsQhSkQf2faQI3Ue4+erHT+9EE
QlaSdQacCv3LWyOFkPEGq8k2nIwJadSUkq7PIp/k1reZAgDCRUD+QITuRZvZIb9s
y2NQHdNvXdY+8fX6Tr9UkmXxdcexgVqxfoRdsPTzup7HHHVTehtNlbbZ495vhnZm
bMxkCQ2xtoB8+CKlhvLV/f6LYW8GlM0PMwaSF6fYMp6T6AsmbKxdVkffjTfaaf8u
7cVFNvCcFMyrLvwgGa5/BU1cA78uouJkQeGEap7Vpi2PKvEwuhmZBSIoJQBKTNnS
SYkwCz0s1JS9ZULIaE3UPUTqfD3tbGZLZW17Mi8YzPQitSlJNEE=
=kTpy
-----END PGP SIGNATURE-----

--3zjlg5r5bexigydd--
