Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F3861F576
	for <e@80x24.org>; Mon,  5 Feb 2018 09:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbeBEJMJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 04:12:09 -0500
Received: from eight.schwarz.eu ([78.47.62.209]:36644 "EHLO eight.schwarz.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbeBEJMH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 04:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=schwarz-online.org; s=x; h=To:Date:Message-Id:Subject:Mime-Version:
        Content-Type:From:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oMiJcSxxZa7bFEmQFcbnYPmnUibLI3n2aLIhEY37y3w=; b=WkUJvITpV4CQaEWgcd3zMZVZCV
        JPwZm6HcKEhxc5JN205H9e/qNRolhxs19knUdTl2Gb73oBAlqODyj+OlwRqgZyGLJ+1Djqx5rZYHZ
        ML+3XvU/3HXtpp9LgL/5ZcmD3ph1t/H+bvZXV/X0E0hOcs/q6QFcHh8r24jXdtEzdIFiGkXaMdLeu
        Zm5LKz5UQEan7fnu2ezsOkXyClyujJ78PMLInA7krvXDUPsJg8iPJ1fwKwAPgFGgZ/0iI5FTZAJ4X
        EVmEax1BnsYB8h2y+G70uiv03MxSI0hLYVIHD23rU00+KL42bCYH7FfRqycOsV//V/sjU2LddI6Zs
        BeFV8P+w==;
From:   =?utf-8?Q?Martin_H=C3=A4cker?= <mhaecker@schwarz-online.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_AC371013-1571-4FF0-9192-E448116027A4";
        protocol="application/pgp-signature";
        micalg=pgp-sha1
X-Mao-Original-Outgoing-Id: 539514724.977883-455b55ba728d32a4098a144b36e33e54
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Missing git options
Message-Id: <AD196D8E-04DB-4274-ADEB-D914A79628B3@schwarz-online.org>
Date:   Mon, 5 Feb 2018 10:12:05 +0100
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.5.20)
X-Received: by eight.schwarz.eu with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mhaecker@schwarz-online.org>)
        id 1eicon-00010E-UQ; Mon, 05 Feb 2018 10:12:06 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_AC371013-1571-4FF0-9192-E448116027A4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi there,

I just recently learned that not all command line switches seem to =
automatically correlate to options in the git configuration.

This seems something that should be relatively easy to fix.

What I=E2=80=99m most missing is

=E2=80=94 snip =E2=80=94
[log]
	graph =3D true
	patch =3D true
=E2=80=94 snap =E2=80=94

which would / should correspond to `git log =E2=80=94graph =E2=80=94patch`=
.

What do you guys think?

Best Regards,
Martin H=C3=A4cker

--Apple-Mail=_AC371013-1571-4FF0-9192-E448116027A4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF0EARECAB0WIQRyALCMEeyeJp2h5aqZEm8JhZOQPgUCWngf5QAKCRCZEm8JhZOQ
PnBQAJ9ufd+eECPfD+r6MuTaedDwmM7avACgz49jJLOIFtyyUv4y/zcGv1l1zvA=
=Jp5R
-----END PGP SIGNATURE-----

--Apple-Mail=_AC371013-1571-4FF0-9192-E448116027A4--
