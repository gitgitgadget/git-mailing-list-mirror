Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 962631FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 19:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754540AbdCaToS (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 15:44:18 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35157 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbdCaToR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 15:44:17 -0400
Received: by mail-it0-f68.google.com with SMTP id y18so3001374itc.2
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 12:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DkYMu2ptlhRj1VHEFeuQMoDnsehRWkMFGj1utO0nY3E=;
        b=SM0cwTW1jDB/nalgT1cj3F8kOpESOJ5nJtXAbo3Rj12gRhnUbpsgC/XKhqNjPqDGdS
         5C7we7rCobzbst6VhFYAb/MAgfcOIwC7jM3VnMzmB0UHhY3JHDr1pAzq4nSdaQdTHfwC
         lQ7zpzRdj4lgFq6KpdiwHWaDIhoHpBhRKRuTziTf81NQU+5HRnv0SLJMcjgAFbtG5azi
         0cl1drnvHXfCjbwBwIlhXvrly/xkpTVdJOgKHWP6kpge/Qi2B74zjJKYmKTfZIeBdvbr
         KmWPP6bF9/V1F0qebewgVVZD0sVB8WZLnJLhV1bseoZlpCGR3iOTI+37Lhc2k1HkqEHA
         bWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DkYMu2ptlhRj1VHEFeuQMoDnsehRWkMFGj1utO0nY3E=;
        b=MuSEPPfsIQDmSkJ3sIQGAwiHUhfKCOAWhUJPr8dZ6HL1KRdPAu850UUbogsEwn4NoY
         326GkuHSBn3g5XpsBweBRw34D2iBx0unuVqDoZQZiUMnqoW8v4CWQ9tOoxgYl2dQB3W5
         iaW+lSlZPg1Vc0m/ikMo6OAOV1A/Fb5aIgFPHWUQ8bz1zmgfBoLbyk3ya7bEEZrEKbs+
         byeU5A2RM/WkM7ozdUNExslSb4n6qcs8pYHdH9duCZtRHO/HEY14+vUAESE9JadTASzO
         +KZ2RUADyQ56MzhRurU3HEc1COyLNC1MamZpiH90l8KRzN/3xIrz6x2vBKzOe3PUgOzx
         SdwA==
X-Gm-Message-State: AFeK/H2xM0Jx58oEB2dF8twUWjxv1lRbOl2zGHYWoZUK7L+MdwBIdh4W2LXsGXKaj69VVQ==
X-Received: by 10.36.227.203 with SMTP id d194mr5903758ith.79.1490989456595;
        Fri, 31 Mar 2017 12:44:16 -0700 (PDT)
Received: from localhost (b03s17le.corenetworks.net. [64.85.162.126])
        by smtp.gmail.com with ESMTPSA id r30sm3638300ioi.56.2017.03.31.12.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Mar 2017 12:44:15 -0700 (PDT)
Date:   Fri, 31 Mar 2017 15:44:14 -0400
From:   Brandon McCaig <bamccaig@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Add configuration options for some commonly used command-line
 options
Message-ID: <20170331194414.GA22434@test-chamber-1.castopulence.org>
Mail-Followup-To: Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Git Mailing List <git@vger.kernel.org>
References: <CACsJy8Du+WWWkx3wqRJYA=cyTdro=OOD7GWaFi29=h1_9yC+LQ@mail.gmail.com>
 <vpqa88hlghm.fsf@anie.imag.fr>
 <20170319131845.tl6o3t2nwicj2rug@genre.crustytoothpaste.net>
 <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
 <CACsJy8CQzo9K8N3xH_HJq=NjJVOUG9wawC4Mg+UuyFRZCPBpFw@mail.gmail.com>
 <20170320173237.GA188475@google.com>
 <20170320181801.fubiyufrsyenru4b@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20170320181801.fubiyufrsyenru4b@sigill.intra.peff.net>
X-PGP-Key: https://castopulence.org/bamccaig/castopulence.asc
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 02:18:01PM -0400, Jeff King wrote:
> I think we've had similar proposals in the form of an
> environment variable like "GIT_PLUMBING" (and your "command",
> which I do like syntactically, would probably just end up
> setting such an environment variable anyway).

For reference, Mercurial has long had HGPLAIN with a similar
purpose. See `hg help scripting'. I think that this is a
generally good idea to adopt. Albeit, I think that Mercurial
considers its command line a scriptable API, and HGPLAIN skips
over any customization of output. That may not be the exact
intention of this, but something related nevertheless.

Instead of a subcommand I think that a command line --option
would make better sense. It would only even save a few characters
in *nix shells where the variable can be inlined, but could be
more practical for MS Windows users that would need separate
commands to manage the variable.

Regards,


--=20
Brandon McCaig <bamccaig@gmail.com> <bambams@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bambams.ca/>
perl -E '$_=3Dq{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY3rGOAAoJEN2n1gIi5ZPy5PwQAKLVY1fWsLzvF1IOg7s8Ye9n
QL6Y2G+h9fZIhOQmlOj9A+7yeJym5R9eRMuq6WvjIDiJdj3psP00nDwprqXGGH5E
4oyZ3cp3HjDgWMVC1Nfhrgs4rUltdp29VEo9vxtGu2NzJv+l0L5mqzAKcGGU1l/z
4OLNNv3aJM4s/LDcdrLTrgDZlhuV68dle04yyil2B33AV5jVgDbJK9w1afHW34oi
VoM7lumyyLBo/+8qG8ssRPCOp14YglcftLHkOCUa6BbuXfnt0bfA0FHkdRmG4tVM
JRy95a7VtKViRUwJ04/TOss2KTh599aZ5kVTDrPmMC1/c8DSga1SQsUOInvxsZwk
ZYp+4M1gOWwmvVsMdUdXICPU3AFpnXaiw7zBiKcBhiQMtDUDEceum+NVNv848jRa
C+AzUuYBQ/cLSNf4TklVI3D1a5vXHxqczB329osAf1WmT3RPBZpm1koobw5tDSCE
DkSmgXvOnBkmBWmAwNZNyYHnvTcfMS78YYE4QUddwC0EFVxPlizyj8xXghtcqhPi
yX7N9iwovGSB/ePpKnZcsxyf0D3R+mCTmzwX/cXN/qgZYQiQAMtGYYQ8TiAZMyEh
38WUpIh2IE2UfkN5k7ZlSm5NJosLhw3mI4YchH6Dbj4xEoCrHY9aslYMQajd4KeP
jewjnIkbQSB3+hwTqdTc
=vulm
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
