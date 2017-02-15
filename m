Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FE21FC44
	for <e@80x24.org>; Wed, 15 Feb 2017 11:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbdBOLot (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 06:44:49 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:18103 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdBOLos (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 06:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1487159075;
        l=706; s=domk; d=aepfle.de;
        h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Subject:Cc:To:From:Date;
        bh=5dunrhXvD/9S6AS9xA+UZhGmLK7fCVQuWxSVyGdx2bE=;
        b=m26M2G+bZQUD0xdt5c7k28TrpVP5kMAo+8mTcj8QKV/Ws/4ze8JgvBwN+zApPl3e4i
        Sdc0yjU2NAZOh7zofBzkQiC6vCKyO4ZRtYST1olKsdsCpIlrqTvCFVYUvpG7yqU2frRB
        h1L5QvND7BE5b5ywcoFqVgLFuHx5dthGJy0gY=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnAYQz4mzReNqcqYjtpsQ74r5YPOZnnb6/KqEhYo5+P1A==
X-RZG-CLASS-ID: mo00
Received: from probook ([2001:a61:3430:6aff:7470:afe4:5c34:8968])
        by smtp.strato.de (RZmta 39.12 AUTH)
        with ESMTPSA id J03d88t1FBiVMXt
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 15 Feb 2017 12:44:31 +0100 (CET)
Received: by probook (Postfix, from userid 1000)
        id F27FB50B9D; Wed, 15 Feb 2017 12:44:30 +0100 (CET)
Date:   Wed, 15 Feb 2017 12:44:30 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: missing handling of "No newline at end of file" in git am
Message-ID: <20170215114430.GD16249@aepfle.de>
References: <20170214201104.GA26407@aepfle.de>
 <xmqqh93w8q0r.fsf@gitster.mtv.corp.google.com>
 <20170214215103.7d5e5f4c@probook.ubnt.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Content-Disposition: inline
In-Reply-To: <20170214215103.7d5e5f4c@probook.ubnt.lan>
User-Agent: Mutt/1.7.2 (6927)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Feb 14, Olaf Hering wrote:

> How would I debug it?

One line is supposed to be longer than 998 chars, but something along
the way truncated it and corrupted the patch. No idea why the error
today is different from the error yesterday.
'git pull' has to be used in this case.

Olaf

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWKQ/GgAKCRBdQqD6ppg2
fsgoAJ9xEjtC/dgpU81YKvmfp4dD/NMlkACbBWLT9hiqXDBsGg8QX1R/GDxGBPk=
=LrSP
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--
