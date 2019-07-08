Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170B81F461
	for <e@80x24.org>; Mon,  8 Jul 2019 20:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbfGHUJN (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 16:09:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56532 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727663AbfGHUJM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Jul 2019 16:09:12 -0400
Received: from genre.crustytoothpaste.net (rrcs-71-42-118-242.sw.biz.rr.com [71.42.118.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CE63660436;
        Mon,  8 Jul 2019 20:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1562616551;
        bh=hVF1C+Gj490K6RmwwlO+RoeccklRojpm6+1KovN0mcA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=te2VVdRxWW9IeFuIQn8UE+5c6Uw9t/aHua0fXSutIODm620YFmAgBIvtBzYMo7LDK
         tFLXWusTDwB8JJgueLsmaQoJUNxI+zhcHYPGvrTH0zkSmVZyh/wL6BPoL4/GooefG7
         HNR67KyBb1vq+W8bXH5eIN0qfGQ2LWCuuQE6sKyvj84r+KOcbSZl5SIw2Ml8gmPLIq
         57IyrDfUMPg5CnJWuoY6prvmFQyyHJyYZ9XCXqweM+Abe/LyZ00Jz7mI5oksnigzs0
         1JzGpDcfvbBfruQjp5vbqoTwdEayHEa4lvOIPwVuJYPgEyYJ6vauOCveIsOv8FRo+d
         easWhLC2bSmg1Rm72UGB+lNYbemDglXki9akGANkKWoveIPhsNviBxL8mdqarUOWeA
         qMNEPRbrjtZ19+ZEhXgVL8HszTBkSGBS4x22HXIfRfMEs0YVcUFcwFmjVUnsfSJu1I
         bZwTJ39croPL6meBKluUhhLiDfJEVqrhcLfr9sInt7jYkEbSC5x
Date:   Mon, 8 Jul 2019 20:09:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     scott douglass <scott0douglass@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: Discovering the new parents in commit hooks
Message-ID: <20190708200906.GF9224@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        scott douglass <scott0douglass@gmail.com>, git@vger.kernel.org
References: <CAOqHT5KUFOY9g-PDDq=PaXdqS41ZGYGMAUuBkU-UrPiSumqhTQ@mail.gmail.com>
 <CAOqHT5K_JZDZ1agEL4ceVdYY=4YYO715v+j_bNbJWOoV=KNqQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Content-Disposition: inline
In-Reply-To: <CAOqHT5K_JZDZ1agEL4ceVdYY=4YYO715v+j_bNbJWOoV=KNqQQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-05 at 22:01:59, scott douglass wrote:
> Hi,
>=20
> I=E2=80=99d like to be able to discover the new parents-to-be SHA-1s duri=
ng
> the hooks that run before a commit*.  Essentially I=E2=80=99d like be abl=
e to
> distinguish the =E2=80=98git commit=E2=80=99 case from =E2=80=98git commi=
t =E2=80=94amend=E2=80=99. Is there
> already a way to do this that I have overlooked? (I=E2=80=99ve read =E2=
=80=98man
> githooks=E2=80=99 and searched the wiki and various other places.)

I'm not aware of a way to distinguish this currently, although I agree
having a way would be valuable. There are of course heuristic ways, but
they can be fooled.

> If not, I would propose that perhaps the hooks could be passed a
> GIT_PARENTS (or perhaps GIT_NEW_PARENTS) environment variable which in
> the =E2=80=98not amend=E2=80=99 case would contain the SHA-1 for HEAD and=
 MERGE_HEAD
> (if appropriate) and in the =E2=80=98=E2=80=94amend' case would contain H=
EAD^@ (all of
> the parents of HEAD).

I think we'd probably skip such functionality in favor of exposing
whether a commit is to be amended or not and let you script the parents
yourself.

There are a lot of cases where one might want to know whether a commit
was amended, but knowing that, you can determine the parents and
anything else without much difficulty, so the amended option seems like
the more general feature to implement.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0jouEACgkQv1NdgR9S
9otkDg/+MXawpUtZSM8hmTfl56rmed6mqbJISpy80CVbxTNiZNc6qGu8frm3+dfd
FBqqCNRX1XwiFkTlbuml40ug39daSmZPYD5Wzf2hGsnRRjPPE3SnGI1ycE+XUvJX
WuVwdbW/u7cN6Y4xMcZ6AUD+tT4j/0Csb0ItBW/wcbjxXGUzvErc7p1joZZjG4vQ
asOwo9aMVTbM1fH54UMp41La9VLwSZcN47KJnWLgyjZ4iFolHb/MIqGZ5DbHZnyJ
S3cTOC4UCf3e7hrZtsbBswo4GrtV/F77usJ/iqORNJTia+OtdkAobsjl9dJs7LbB
BXR7P9kehS0LWW3Bm+ScQuFbub5jLJqkWcMd87hiAzOPsSFlWh3iVJtjQtg7Y1UF
R8m2zYwZtD8gIF5CMJXWN1wvsB1RsqJe8w0R+jNlIcHdSQEdbIijFPwoIN9Gu7sD
u5plbe/Ns4yIGP0JasYcPIarggxH90W+/rRWsiDDgbtDVKTxivwwTVg/JkK8zNp1
euSL5IGoc1f0LqC3jcvOA8v3DHX4mXwwiFHp3R86FxqS8yckGdVD9/38tinDiFnn
11oJ3dRlWeBo3AhvOjXY3RDG7vtMDp2Dvwq/femRnccbocwULdIolNMPQ1NGMbbx
755ljQwWrVgeYdqMn4tuTHkYp/c+hdAclvd1ZY9A9W9C8aXVVSA=
=4m+w
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--
