Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA2DC2BA80
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 17:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A4920768
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 17:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="GfhmcrnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgDGR36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:29:58 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:25834 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgDGR36 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 13:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1586280596;
        s=strato-dkim-0002; d=aepfle.de;
        h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=3FGuj7N8e29gKvPlFnzIwsDBtK6iaslDZO/2Jm/LaGU=;
        b=GfhmcrnWyzcQmUa5Lz3s3bRLyaocHib8/gkI7bKngEYf0qBXU+9ZkVkApCoJi6Wm8P
        GtLINSe7uD6w0tp8Cs6uc1TBmF1a/sKQlvdX2Q8OT1T+yHpoUoNBaMp0x73xBdXbWTwi
        Gbc9m7MxysiWheSTPAFJe37jIzPzU8cmPHMfwkxTlnaHzEtwqGT0ObgQQPu+MrI0bFXU
        urTpXPiEyQpWxzY9SgcEgdPTlR57/33FD6vmFRHckAeEOqe+174ZsCe/K7yq+9AKaI43
        e8/v1gcbPiJ0TqIw+KAY8qVrx2NjjZeubwTksDrGrVu5RLJQRz9tqTUrW47LVl4sFJbs
        +/lg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuY88K"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id 204e5fw37HTuhOV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 7 Apr 2020 19:29:56 +0200 (CEST)
Date:   Tue, 7 Apr 2020 19:29:49 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Joe Perches <joe@perches.com>
Cc:     Jeff King <peff@peff.net>, linux-kernel@vger.kernel.org,
        git@vger.kernel.org
Subject: Re: get_maintainer.pl sends bogus addresses to git send-email
Message-ID: <20200407192949.586159e7.olaf@aepfle.de>
In-Reply-To: <2e6975d606846c834a387c07ee11cdce52356586.camel@perches.com>
References: <20200407154046.GA15368@aepfle.de>
        <20200407170257.GA1844923@coredump.intra.peff.net>
        <2e6975d606846c834a387c07ee11cdce52356586.camel@perches.com>
X-Mailer: Claws Mail 2019.12.31 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gyvhdOKHJllakF_ac6Obz20"; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/gyvhdOKHJllakF_ac6Obz20
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Tue, 07 Apr 2020 10:18:41 -0700
schrieb Joe Perches <joe@perches.com>:

> You need to add --norolestats on the get_maintainer command line

Thanks, this can be used as a workaround for the time being.
Not sure why anyone would actually care about such details in default mode.=
..


Olaf

--Sig_/gyvhdOKHJllakF_ac6Obz20
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl6MuI0ACgkQ86SN7mm1
DoDElRAAoKPmoW8t03Z5XrOYrmXy2RJPzRRguC/zAbQL+N3AK+xfNHqy93bBDyPF
xonrACp9WyHtLNywMLH+5k2PecEch70kGyzbw6P1O/H530rN1wWWdbdwywguKpgm
JVaWu5AEQHWukFfqsZH3BduY8ThOPbsGCar0l+ZtRAlUAs2eYeXv8tcdu0NeVaGS
9ZyzLO2w7i/wX2MQUfGyJAeJTLFEkXGi+4jy4z+9c05zUqPzmXSncMR5njCytNjD
W7lEOthcFVKMAUmIvMlnT8KvraKdbJ229Cqs5vlA9LCQK6bd0Xg0MAkH6tHOH61U
31EV5C4zn5j+/QZdk9qYmlPjyKz7AWp88OiC17ZOqzugILIxGFU2QZwRcxcsVvGK
dn2llTaTuzen77ifvNhcAjZPhlwrMStqAs0GSFD54XczCNnGUBV6PR/kPt/PhTWT
ICHAE5HOC+/QmWwI4LsXGwi8l6i+HEd49sr+Egl/iu7mLERmtEY7tROtyYfi+oul
/oaLYwuXV/kJsLgR2Y2V+D3iWjadyGl9OWbXNaN8AuKXL7dNP1bELbwiqBdJfu6c
CZsxfi1pzzicw+2s3Hg/phjCgYKlhf9DjVdU9SdQCUY3qF9nGHrJlB0heJBGL+6U
o/uIBId7siYE3oB3W9OBlp/ZsuQnBAnwx9FiohN5JJTjQo/5uoU=
=HUNz
-----END PGP SIGNATURE-----

--Sig_/gyvhdOKHJllakF_ac6Obz20--
