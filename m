Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E829B1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 20:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754620AbdBNULI (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 15:11:08 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:16914 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdBNULI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 15:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1487103065;
        l=857; s=domk; d=aepfle.de;
        h=Content-Disposition:Content-Type:MIME-Version:Subject:To:From:Date;
        bh=cb5esb0dRZi1soJlV8BJ57hjpeGeZCUc9W8hEErgBIA=;
        b=Vh9S6HVItsH6FNQ88iovzNgAziFazqZ/N/GGWcMTrBgf5e2ngifAK8TEgWNhR6GHDZ
        GYjKTcUnsGBPQXMkiIkCttdxlTfSWh8J5h4koSl0EsjeHTNJ6A0EnmKa+luuV+s2rE5X
        XJ/jvWAsSZ3jgfcdsWKaoZCHlzoxFB6R8Aecs=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnAYQz4mzReNqcqYjtpsQ74r5YPOZnnb6/KqEhYo5+P1A==
X-RZG-CLASS-ID: mo00
Received: from probook ([2001:a61:3430:6aff:7470:afe4:5c34:8968])
        by smtp.strato.de (RZmta 39.12 AUTH)
        with ESMTPSA id n0b399t1EKB4Ic5
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate)
        for <git@vger.kernel.org>;
        Tue, 14 Feb 2017 21:11:04 +0100 (CET)
Received: by probook (Postfix, from userid 1000)
        id 4912750B9D; Tue, 14 Feb 2017 21:11:04 +0100 (CET)
Date:   Tue, 14 Feb 2017 21:11:04 +0100
From:   Olaf Hering <olaf@aepfle.de>
To:     git@vger.kernel.org
Subject: missing handling of "No newline at end of file" in git am
Message-ID: <20170214201104.GA26407@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (6927)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

How is git send-email and git am supposed to handle a text file which
lacks a newline at the very end? This is about git 2.11.0.

Right now the patch in an email generated with 'git send-email' ends
with '\ No newline at end of file', which 'git am' can not handle.  To
me it looks like whatever variant of "diff" is used does the right thing
and indicates the lack of newline. Just the used variant of "patch" does
not deal with it.


Olaf

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWKNkVwAKCRBdQqD6ppg2
fqDGAJ47m+4NvOE/4OYhWBpSbqMVdR6nFACg30UcTdYkGXNVUw0k4yHaHInzrpY=
=PsKk
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
