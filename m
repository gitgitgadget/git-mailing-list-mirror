Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A8F20A04
	for <e@80x24.org>; Sat, 15 Apr 2017 04:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbdDOEei (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 00:34:38 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:34692 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750776AbdDOEeg (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 15 Apr 2017 00:34:36 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EC892280AD;
        Sat, 15 Apr 2017 04:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492230873;
        bh=F+kaRYBCNvRfWHD7L6cDLc/AsBa5tj8ypQ4/N5yRQT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lEJFM9Vv2/AaZg4lqS7cafiMLlbvvrYsuf7JrxAiIjrR7VwZ8k3ulG4kCvVQg5JEk
         3kySSfCAIUSC6sNqR6Ko4L07IyymMqOmAzmAjW0ndc/NHEsJBMqdS8NvTRUiFKpeYn
         5WPvpN6QpN/RFuRqGcspRIPvBgo+0K5+LrsOdzNWCVRZeSLGZ3j5KxfoIAfGYg9w7F
         j/c6KLCWCITnTYCW0InlRe0RX4NowdzaZqs0MeVJ4pU4+f/eJiypuuHgCb+cwQv3O3
         3bojFH7qGyKFzFGHbXlQ/zJB0rR5qn+X7QpqV+/HuDbGirEhuGwdJn4bhCFXK68POW
         nvOp9LGgnz2XhyfjYI9740V/3LSiecRM2P/kvR1CNoP2kaWABWxcxjKCKsL1TqeZA5
         V02KEmMd0yOXAMRAuVedAyxwImrrET9ihY62BXXdPMde/sT+CDKtbvyNs73BnP6xNF
         oWB1014HZQnUCgcOyAU3jkV+bF/gbMcaRlmnzW5TRooM+RysJOK
Date:   Sat, 15 Apr 2017 04:34:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeffrey Manian <jeffrey.manian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "up-to-date" vs. "up to date"
Message-ID: <20170415043429.ymrex77bfil2qbge@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeffrey Manian <jeffrey.manian@gmail.com>, git@vger.kernel.org
References: <CALFtnmeRxgetuCVbO8ZmVkCR302vQ2s4hTPoHxAe5NEfmjtXEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cw5w6kcrsn5on2jw"
Content-Disposition: inline
In-Reply-To: <CALFtnmeRxgetuCVbO8ZmVkCR302vQ2s4hTPoHxAe5NEfmjtXEg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cw5w6kcrsn5on2jw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2017 at 04:34:16PM -0400, Jeffrey Manian wrote:
> Hello git community,
>=20
> This is about an issue of language style and punctuation, not anything
> functional. Apologies in advance if I've brought this to the wrong
> place.
>=20
> There are a bunch of situations in which git will print a message like
> "Your branch is up-to-date with 'origin/master'" or "Already
> up-to-date."
>=20
> In many of these cases, including the two examples I just gave, "up to
> date" should not be hyphenated --- at least according to most (if not
> all) English-language style guides.

Yes, the Chicago Manual of Style agrees that "[i]f the phrasal adjective
follows a verb, it is usually unhyphenated."  I often keep this rule in
mind when writing commit messages.

> Here are a couple posts in support of that, which also explain when it
> should and should not be hyphenated:
> https://english.stackexchange.com/questions/180611/do-i-keep-myself-up-to=
-date-or-up-to-date-on-something
> http://grammarist.com/usage/up-to-date/
>=20
> And the Chromium community dealing with the same issue:
> https://groups.google.com/a/chromium.org/forum/#!topic/chromium-reviews/e=
dodON6G2oY
>=20
> I thought about submitting a patch, but I started looking through the
> source code and found that "up-to-date" appears 61 times. So before I
> get into that I thought I would check with the community to see if
> this is something that's already been debated and decided.

To my knowledge, we haven't discussed this issue before.  I'm not Junio,
so I can't speak for whether a patch would ultimately be accepted, but
I'm not opposed to seeing or reviewing such a patch.

Generally, the rule on the list is that unless the change is very large
or wide ranging, you'll find people are more likely to give you feedback
on a concrete patch (including whether the idea is desirable) than on an
idea in general.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--cw5w6kcrsn5on2jw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljxotUACgkQv1NdgR9S
9otcQRAAhEaiYQiZwrePbk8PLCbB+7nrihQ9fDi+hnKh22QyFj/+u9ZM5w3jXdc5
LrkxoqqB1k1/GlXhR//nLTpzvL61Gx7LnYppV5ZZnLSfi7XQaMCur66qAsDNFIJK
bwEv//TTbKkqlXRFZ7DMIxKCjOibUCQDOSiplSMTGGvKuLlxYlfSrscMJ1IISfQx
u2HMJBJjSIVvKd4N8vgydDLaTy5wfNE/vw9EZADFTq8WFOFCQnQXM76nwzqkE1iw
DN1DNvIHHDqHnLiAm003SjU+X9VjeqipFm0UYFhumthgJbhJw7lHvUM90SVW1SSg
l+Wc0vv4pdmGC80lyjdgLvImUl40PszMU8EsBmn2zy0L/GyN6CQHEAW1qkrRm+ri
AyWYTcL+gX/bLszHDwzss4kPCvnKM2UI679/phYs473EH3nD0f0mDVipxDznJ/vL
savvl7ix49gyul5P1f7Tht3nuFuvQd4zDwaJnhoJ79Y5mOL9jpJARZR1HfQbR+Jh
Et0nm7iSuum60F87evEX9yXEx/tJ3CqwR/IUuV0VD7kFHzdi5fh/c3Gva6hDa4j2
g2r6/UI3yNd18PdN9vQLasE3EIY2KS8ukhZ7dlyQ6uL9ZaPjdRLAg7NSGFXo5qRr
zqRUGx3YXc1jpMOWdZtSZObuka4O6GISDKvglGFdq1IpAQ/jG5o=
=9b3i
-----END PGP SIGNATURE-----

--cw5w6kcrsn5on2jw--
