Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 172841F463
	for <e@80x24.org>; Fri, 20 Sep 2019 14:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392859AbfITOht (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 10:37:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58792 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391448AbfITOhm (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Sep 2019 10:37:42 -0400
Received: from genre.crustytoothpaste.net (unknown [75.104.69.183])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 055AF6074C;
        Fri, 20 Sep 2019 14:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1568990260;
        bh=2ud2sOOwBVUn6rfwTbqCFasm5nukaikcm8nEpvywTIU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=A5XRliBC4XRegZ8Fjas2Dlzy357NGeIMT82M05WQTvXnL4WGFJTc8YMyL3Xpdlbo5
         pWhGErQa5iWQjVx8FcSAte4w4rfRGic5xxYPsjQ4Gt5CbUZYUY4sJ/pPahSPjVcdaZ
         qF9dyRTDb/RdOF18nR4psl6wKMLOMF6+yS1cm3HD/CabVIRVGLidv/3Z8V2o8ihc6F
         bm1D/cDl5TJzGFCHhIzLbLzlwKHnAb7NXEnPU1QudkJiwkUPingNrrwFV7q3Qvt+gG
         6Vgz3KYHD5D3D1v393sA0Mi5aZs6POJ8/nZJLcD8JDgiNmrqjktkEsdgUvh1xQxS2i
         5EowuWFq+0avTDOV6GdMAcLt9HTXux+zPDT/Wo6kWGwJK/r5Jye4SDeMLrdH+0RcpM
         td+szM+tIiFCdW2HdqdhI0HkQ2974nV9y9V7/tY/jKZIO4AaySEQTbmU2AhGwFPoOI
         ggTnfh9KddMhVMFEuicwo0GJp7xxaFnNK4UnJVoDxFkARvbGS67
Date:   Fri, 20 Sep 2019 14:36:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
Message-ID: <20190920143614.GB20698@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-19 at 16:30:13, Derrick Stolee wrote:
> 1. Improve the documentation for contributing to Git.
>=20
> In preparation for this email, I talked to someone familiar with issues
> around new contributors, and they sat down to try and figure out how to
> contribute to Git. The first place they went was https://github.com/git/g=
it
> and looked at the README. It takes deep reading of a paragraph to see a
> link to the SubmittingPatches docs.
>=20
> To improve this experience, we could rewrite the README to have clearer
> section markers, including one "Contributing to Git" section relatively
> high in the doc. We may want to update the README for multiple reasons.
> It should link to the new "My First Contribution" document
> (https://git-scm.com/docs/MyFirstContribution).

I think there's a lot of improvements we could make here, and I know
that many folks are already working on contributor documentation.
That's enormously valuable work, and I'm pleased to see it going on.

> 2. Add more pointers to GitGitGadget
>=20
> We have a reference to GitGitGadget in the GitHub PR template to try and
> get people who try to submit a pull request to git/git to instead create
> one on GitGitGadget. However, that captures contributors who didn't read
> the docs about how to submit! (This is somewhat covered by the "My First
> Contribution" doc as well, so making that more visible will also help.)

I think GitGitGadget is a useful tool which I haven't really had the
time to learn how to use.  I appreciate that many people prefer a
patch-based workflow, and that using a patch-based workflow and a
mailing list provides the project independence and avoids favoring any
hosting platform or tool, which I agree with.

I think also that many folks find a pull request-based workflow to be
easier and more familiar and supporting this a bit better may lower the
barrier to entry, so I'm in favor of bridges that make contributing
easier, even if one still needs to subscribe to the list to get
feedback.

> 4. Add an official Code of Conduct
>=20
> So far, the community has had an unofficial policy of "be nice,
> as much as possible". We should add a Code of Conduct that is
> more explicit about the behavior we want to model. This was also
> discussed in the meeting with wide approval.

I think this is a good idea.  We already document how to contribute to
the community by sending a bug report or a patch: how to format your
emails, how to sign off your patches, and how to write a good commit
message.  I see a code of conduct as another way to do this by
documenting our social norms much as we document the way our
contributions should look technically.

I also know in the past we have had problems with a contributor who was
being argumentative and disagreeable.  I think documenting the kind of
behavior we want to see both helps individuals ask themselves if their
own behavior is helping us provide a positive community and helps other
contributors provide feedback about unhelpful or unacceptable behavior
on the rare occasion that we see it.

Lest I give the impression otherwise, I think that overall the Git
community is quite welcoming and positive, and I anticipate that it will
continue to remain that way.  I expect that the difference in behavior
on the list if we adopt a code of conduct will be small, since so far
pretty much everyone seems to be engaging in productive, helpful ways.

However, I know that many folks from underrepresented groups in tech
feel more comfortable when there's a code of conduct because it signals
to them that the project cares about fostering a respectful, healthy
community and that their contributions are likely to be welcomed.  I
recommend the Contributor Covenant for this purpose, since it is well
known, well accepted, and is used by numerous other FLOSS projects.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2E494ACgkQv1NdgR9S
9oskGQ/+N4Y3vFPu7rVKBtrjdwm7d9FtzEpmGNByoyMf7mwngk4i1/ESHMhYxMzc
bI1OUIgCNiidurUE2JMJ3ACnDGxaA7aDShLnJ3ykMuvetpy3rtfoOeNXz/Uxs0ff
W04utK7C9L2RaGwhzJoSNNUJ2hjeGPBaCfPWO0g1U483y65SIoQdGli+MXqmuhbm
ZHDfCSjWiWKWe+5KwZPN8c1gLSpVI+Y7daAoPeVFKBgQmDk/tOcp8TxFggSFIPCG
xsrBrGlK+FmtSLmqlJvJM0HwQiLzQqUU0ME7CQAcsg72jeQMCRHMwmMh+aPqdxUe
f/b/JV1iFzbI6OriaV8lLPXbWuVcOreRH6+vly674wxt1uBvlNGUZNrq6m7cOX27
T4ujIZ1l7fkuyy0KjrbI5eVFodx/qEBWuXyxNLfVMB5BdODhxsD0VfdHC0q5OLJ5
KWD6+dGR1/n3WzlE3qipXV1SPLcC8ccoHrQ6uxv4SkscsF1LvjIKIATgeUeFnWS7
LiXQ3j0IUhM8DcKZQ0fVg5g1k0Mfd/LpwvZkEHcIQCbGSJW62rttOUMFS4M0JCDp
SOd9JY1PLoslYaTJ+a4W2X/NHtVShyPLefoq9tKcee7H5hPQKgt0O2ywI7I5dM2x
Iqv1u3j19ZYMtwlbiitL9EyMd0+oSauKBY2hx1ljTLzRCG0OhU4=
=S3gh
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
