Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96C551F461
	for <e@80x24.org>; Thu, 11 Jul 2019 22:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfGKWBZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 18:01:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56592 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726181AbfGKWBZ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Jul 2019 18:01:25 -0400
Received: from genre.crustytoothpaste.net (rrcs-50-84-77-156.sw.biz.rr.com [50.84.77.156])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6A04960436;
        Thu, 11 Jul 2019 22:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1562882483;
        bh=fP2cAW3b5/5AmT0SvtSple2IUhEeo0kraUkjQ1nRlG8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0jsbmque1AUuuD2U0+0B9G9uNoIC5fJurM+aDy6wPm/ggl/+h1pi7ZD7NVTOv5Ta3
         ltd09DaX+FL7SACVfyZpfF06jvjJS4HdAEerecxNYrdIoJEpxQmlDFFq4UGeq3e0xa
         hL+VcOU4dyGSahdCPN53oZG2WeICPkBENG7iOudOI0sJGX7OPj+6zSEVnpCyPd6OxD
         bhhfsRiZV6bDafTfoRCJA54kW2UAr4zE8T9QG0a4fQUhN9R+mAFZm2WVBbrgryY+XC
         Qu+wTOObjd8y2w3wOFbT81aDSm0fzfzTkbuS2zweEVijXsEvlxmulJz+tIr/WdoWog
         bAhBfiqevWYsGNHiEmeWb6QBdSJzIrx/TPz/J9W0w6UACq1bm80SD8EsMEXFt6rHmz
         K0MJDmZzCQuwqyYYTlcJf+GmZd55ZsfZhqSw3RnHp//9f/Vhl+e5dAXm5lFJI/QRnP
         Tjvr8ZHY60WtiE/JKUD8FrGjKLyEbxbNmo+t5xJ6DbBmUyDXSEj
Date:   Thu, 11 Jul 2019 22:01:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael Kielstra <pmkielstra@college.harvard.edu>
Cc:     git@vger.kernel.org
Subject: Re: Pull vs push messages
Message-ID: <20190711220118.GL9224@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Kielstra <pmkielstra@college.harvard.edu>,
        git@vger.kernel.org
References: <CACf0ZibKt-mpqpavmK3SVMC-Lqm9KB9kUvPj-KFkvT_LVRyOZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3xQkynibq3FKlJyM"
Content-Disposition: inline
In-Reply-To: <CACf0ZibKt-mpqpavmK3SVMC-Lqm9KB9kUvPj-KFkvT_LVRyOZw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3xQkynibq3FKlJyM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-11 at 21:36:50, Michael Kielstra wrote:
> Hi all,
>=20
> I noticed that git pull reports "Already up to date." but git push
> reports "Everything up-to-date".  (I'm using git 2.20.1, the latest in
> the Ubuntu repos.)  Just for a consistent user experience, would it be
> worth standardizing on:
>=20
> Hyphenation (up-to-date vs up to date)?
> Periods at the end of one-sentence messages?
> Colloquialisms and tone of voice?  "Already up to date." sounds like a
> terse error message but "Everything up-to-date" sounds like a chatty
> friend.
>=20
> Maybe none of this is worth the effort, but I thought I'd mention it
> just in case.

I'd be happy to review a patch that changes this, if you think it's
worth changing. Generally the way things work here is that except for
obvious bugs, people send patches for things they care about, and then
other folks will review and make suggestions, or sometimes there won't
be any interest in a change, and the patch is dropped.

We'd probably want to standardize on "up to date", since that's the
correct form here according to the Chicago Manual of Style, and drop the
period, since this isn't a complete sentence.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--3xQkynibq3FKlJyM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0nsa4ACgkQv1NdgR9S
9ovgCA//Sp+TuhABwXCAzjQ3RjyqFZdk3Hom4FNpshKb9eKXiUgFjrYT8QGn68cm
xh2dxxns0+IFdS3SBwIooyY3TFD9FvAGdY0fsovma9zg8+ixHUIchflgxnr6r9gr
aiX1M09hq5p9/z8jfUk48bPcrn1KdGGJ7vzcEFiId93Y8pL6EKQCtiGcyLlUbgUe
OwEdqZGmc/O4VrCUzNjy4I+AX8RrP+X9o+8DRXavHT1YoEKdetPm2ZQ1DmvAW2mL
WpAWJ83VUBo5x7d/rESsHXV1ouYO7isr8artW5sbDvroM4HK1CWlyI+ju/g8EWEe
Iv/yoCxLF+fxs10A8Yj3tiAtWqjn/N3bEdOU3xQghn0G57AgHYyz+SIfRhxkPGeJ
rHoOSCgrbdgaWcNfhkYRI3G8fiFPHuOLVWZx+1GwOM9xQLEY4aOVDbNOG8aSiJZm
UU3+RJBxoFiNAtALl2XcdeRxmeDMPvvpGlIs5s73KCDuFZ43iqmnZsIQuibc4D1o
IBRmDWEPU8IF7JOfLfVAjkIIDITnDh311OARhvjD+84vJeroeFzUGcuCPCyRyWkF
lTV7cC5gaIrjguG41QoqWRNU0chh14DTELzp4wyQW4oZggef6SisdxMX0WgfHBym
hIAELPQgR+BQep/QkQj5POG4y1/gBQbNLB0oa2mWJ/TlzV8cQDM=
=RX2V
-----END PGP SIGNATURE-----

--3xQkynibq3FKlJyM--
