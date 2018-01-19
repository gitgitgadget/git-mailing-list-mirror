Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7602A1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 18:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756177AbeASSJH (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 13:09:07 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:44263 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756186AbeASSJC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 13:09:02 -0500
Received: by mail-pg0-f43.google.com with SMTP id m20so1998102pgc.11
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 10:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mcquay-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Avy9y8JlTA2aIcl/bHrn2xg5/8Vq7kq7ph1n31b6gC0=;
        b=Jj41nih/VKVM1RSz5hKoydDBcI/5auf1wa+Q0niEHR0M5HaEdWK/AfnME1PehNPQm1
         4KApbRZLmwo9O4AR8pygfvUprGzFwCJYMVFx9EFkVE5Q7EgTNQfP9RNQWYJkm9sRWY+I
         R9DfKk7jWiGnmluUQueCJSAGKQP7x3CYfptMo8zw+G8AqmTq6TEuZgbokYYr2t4zW4z5
         geLz2vBViPlHvTm42hsqUyi56jdI7ml+1lLVXXsS+OqIyn6mM4UoAyVt7ItZGmqbCLq3
         RFJIYEyoYiS/jG+BOLYWbyuRBshnviBup+/i5A1Stc5Ndkoh3bPnhJPF8H/BsQK/mtNH
         730g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Avy9y8JlTA2aIcl/bHrn2xg5/8Vq7kq7ph1n31b6gC0=;
        b=MxO0GkL91FlsAs/4KgaBOqZAvOEFEUas5hG/mh/HV0s5wWucrRtyqJggymgXgBgAyt
         aHfOu747F3tHdLxGlHpbTq8oL2LQwGER4vUM/mX+R+MVc1WvYWgbxDmEa3oZVy47Sl+J
         Y3PTCuTlYRiRptnytdxSS4yPhspmf7jUQWcoaw+QFoFuUbBQ97d700IvXvJ4fKdEFXR0
         /96rZwO3/C762/KQAE1ULkjvIPWAlMFeEzKGBsB70cBG7BqhJlR+xTO1i2LQrzgfwRpS
         MrO4yP3kP9KSgyQGrUVRK9cUOi3tasUmH/rgWIsrRu8rDD1dCKrVXhImHA4x9gpu8ubp
         a2pQ==
X-Gm-Message-State: AKwxytcvLz/QD/YLVHM/yue3ZmXQzTu9KEqIdIx6vJ/wz7yuKyTID+J1
        ORV/M9685j0cJKS6T7xjU97H2zWNiV0=
X-Google-Smtp-Source: AH8x225kkQOMoMWbFw/EehSUhQkgq1tz24eBoAWk0ZeslGpK2GXTMSC46WnW5IXdTBZEl7pqJomrGQ==
X-Received: by 10.98.186.18 with SMTP id k18mr1668541pff.115.1516385340708;
        Fri, 19 Jan 2018 10:09:00 -0800 (PST)
Received: from smm.local (ec2-54-153-88-228.us-west-1.compute.amazonaws.com. [54.153.88.228])
        by smtp.gmail.com with ESMTPSA id 184sm18170024pfg.87.2018.01.19.10.08.59
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jan 2018 10:08:59 -0800 (PST)
Date:   Fri, 19 Jan 2018 10:08:57 -0800
From:   "Stephen M. McQuay" <stephen@mcquay.me>
To:     git@vger.kernel.org
Subject: Segmentation fault on clone
Message-ID: <20180119180855.GA98561@smm.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I submitted a bug against the brew project when git version 2.16.0=20
started segfaulting:

https://github.com/Homebrew/homebrew-core/issues/23045#issuecomment-3588910=
09

I've built git from master from https://github.com/git/git and was able=20
to reproduce (no surprise, the top commit claims it's 2.16.0), and also=20
built from the `next` branch which yields similar results.

I'm on latest customer release of MacOS:

    $ uname -a
    Darwin smm.local 17.3.0 Darwin Kernel Version 17.3.0: Thu Nov  9 18:09:=
22 PST 2017; root:xnu-4570.31.3~1/RELEASE_X86_64 x86_64

    $ sw_vers
    ProductName:    Mac OS X
    ProductVersion: 10.13.2
    BuildVersion:   17C205

The clone url in question: git@github.com:gdamore/tcell.git

Any other information that would be helpful?

Respectfully,

--=20
Stephen

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEVnuBnnGQMCaGOsqiTkty9Hm6POUFAlpiNDcACgkQTkty9Hm6
POVHuQ//cHlaFWUb4MGpl4+0++J1pQtYyHBoKOxFWfIHd77hSh1ZA3sgfbGYwl+3
BinQ0b85m8vl5XieRiWFs5SEJvSa1w9d94m1MUR3j1gP+iDHqXhUIbmonjVLCScf
RKBpi1f49MyxJ8j1lSO9v80vQ6VkEz2lbp/zTIAWIrHyBhz9xMvdnXA+3q6g8yyO
jGgRbA2zIP1L/OTFmuHj+AjXr53psJ+loLZDnuw11ZxEp9mJFdeoCThLdmssi7vY
OU7SdL/sLJw5niXNC9Vop2+GL7aPZLrhV2krGgQ4PfKIqdx+7QUrJv9f9j87fuL0
5bTZwvhz3PFtfRjZxtq/Zih96gUe247PN2G3zFlUO5S1tnW0rIVs+WpchUCs+qxa
ZVbIVQZKm9uXgCy3ZbMJ2ckWFFCfanbiU7Tz//1QfGT3ejlsIn1z1oj5+WlCBG6u
rbsgHJlTtaagPcmD7rcqkkU5vLx1HS4v3kxoqGrD+cYlr0QZtKUXty72ikCRViON
ajXL2ZlOB0cMq+VPKvpJAXQf8hy7veOSDlTJsolbBfEVU47PjM4J+HR1TjOr/MOx
J5ES/jl7KMaJ8nXpBGcH1yw7QaJLIKGPyfbcee9NsR4ypASCKJ+YXO05nHEoDvGT
lSm2iy/GI+4QJbszuA77rP4FXCjCEGMb29hNoyZwn2hLErNlc4w=
=d+2j
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
