Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C2A1F4B6
	for <e@80x24.org>; Thu, 11 Jul 2019 16:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfGKQJy (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 12:09:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56586 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728474AbfGKQJy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Jul 2019 12:09:54 -0400
Received: from genre.crustytoothpaste.net (rrcs-50-84-77-156.sw.biz.rr.com [50.84.77.156])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A1BDD60436;
        Thu, 11 Jul 2019 16:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1562861392;
        bh=5ssslUG7U3WL4wkw8Ddr5Z15dJF9GgvIZi/zsI9yITM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fUgxlKkafld1RSDAC45NdclXQssaNn2TgK6IlMNkneKa3Ye0YHYUAKcTq8Osnm7NG
         SC36+hlT7rWvrS2xXRmBdLzWjUhk4w6UE76g0J3YMH/GnJRHyYrhv+kzSGBEsNU5x1
         gUvn9jchgnbd3cw8d3FnCeDSWHzqMJs++F1/l8RnRDAIhhQr88qW0PwDBvXa/EzVCK
         8lNAIqTzeLwTbZpvnUh9wbPU+3oMxBHJBsEt2+gZJX0pkbxt4o0dtEujmATQdk9gf0
         qXYT/kBynHfuthQFlhprnMWvoZ1h6f4RiwNA3KLqsmK9MWt0lEK7LsRzume9u0vyqb
         vM2beISJ3urzr7ODgccWbLRsKlelm0C1LlzMeTjgL1uoMLmDO7EG8iLu/Qcjvtgh09
         hMSCttpYRr2HfkbyS9sshRA0+cCyfSZ+SUxmuMT8uf5KclVI3R+knGJseR9IBLQsY/
         qqCgUoACfX2qB1JRekIKFzmy7gdsvru55Poazhw1MAcqTcrl4bU
Date:   Thu, 11 Jul 2019 16:09:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Mark T. Ortell" <mtortell@ra.rockwell.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: List of Known Issues for a particular release
Message-ID: <20190711160948.GK9224@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Mark T. Ortell" <mtortell@ra.rockwell.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CY4PR2201MB1559C26C1D75B4F649AD38049AF30@CY4PR2201MB1559.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwbb4r/vLufKlfJs"
Content-Disposition: inline
In-Reply-To: <CY4PR2201MB1559C26C1D75B4F649AD38049AF30@CY4PR2201MB1559.namprd22.prod.outlook.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rwbb4r/vLufKlfJs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-11 at 15:28:27, Mark T. Ortell wrote:
> Hello,
>=20
> I am doing a software tool assessment for functional safety and I am revi=
ewing the use of Git as the SCM. One thing that I need to do is review the =
list of "known issues" with the Git release being used. I have gone through=
 the release notes and found that it only contains the fixes and enhancemen=
ts in a particular release of Git, it does not contain a list of known issu=
es/errata in a particular release. The github project also does not include=
 the bug tracking list, so I am not able to figure out a way to review the =
known issues for a particular release. I considered reviewing the fixes in =
releases beyond the release used, but that has 2 problems. One, it doesn't =
contain any issues that are yet to be fixed. Two, only the fixes in the "ne=
xt" release are truly relevant because fixes after that could have been int=
roduced in a release after the release being used. An additional note is th=
at the Git for Windows project does provide a list of known issues in the i=
nstall
>=20
> Could someone in this mailing list assist me in finding the known issues =
for a particular version?

It sounds like what you're asking is for a bug tracker that lists all
known issues. Git doesn't have one of those; we instead use the mailing
list for reporting issues. We've considered using a bug tracker in the
past, but the idea hasn't caught on yet.

The GitHub project is a mirror; it isn't the canonical resource, and the
Git project doesn't use it for issues or pull requests. Both of these
are also the same policy as for the Linux kernel[0], which you may or
may not use.

If you're looking for an easy way to check off a compliance box, you may
need to work with your management and/or auditors to see what approach
you use for other software (such as Linux) that has nontraditional bug
reporting practices. If you typically use a Linux distro that addresses
this issue for you, then you'll probably want to use Git from that
source as well.

Alternatively, you can use Git for Windows on a non-Windows system; it
should compile and run just fine on Linux, macOS, and Windows, although
it tends to carry more patches than Git itself.

[0] Yes, kernel.org has a bug tracker, but it is known to be incomplete
and many issues are raised only on the various mailing lists.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--rwbb4r/vLufKlfJs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0nX0sACgkQv1NdgR9S
9ot7hg/9GPZS2rHG2itzMJLwb5576urWbVUasSn9hHct3A2rWaFOUCaD/bBRsvMl
VyrKJEWHfSJZqDMR8V3TW97kDa0wUB37kCBMGkqgShHWq5Pe7a4F5ZVEEr7oeqaA
xW/53yGqHyEUpnVRVBjjakg1iCimI8FlK5K8Q/pHfoH5Rj/5UAw+cdp24UdgU7Ye
5Jb3YytUYq+MB/svf34TjfHjeoMDQvEe6evGGXTnnEFLqUSD2FhNhipi+JxidikU
ut27UTJh2ZuCtNtHUgQNdkZp6WpPTFhFM/2wx28CwK2P+NGTN6JMXBzUtlGUOad/
sgR/R1EpEh/bFZEuyeZ5DlY0m7T/DqmJ0s/gkIBqTCNaFUq1AA7bD2OuiJhGxIoN
UojK1FwFncuk8lhn6ld61SlsQlCkGTgvPQwyvj+fwQd4BHVchQN0maJNPPZlbaP6
lOT3vxkBZ53GxmXn+i4RPQ2QGnlEiLzR+TcBD0Uygb1C5JKpLMoawv6/JRp+1f3N
JfELAt58R6lAGaypuRUIXCR0kB6yPryVi590M4lTVuHjnuzukXEH/Ou7HCCysqoN
NjIDb2qlmF2AygkOQRo+wX1o1Nv+UzUvZhJFUsztMvg5msdOEF8dE5kXsP7s/Q2T
OXsPBxqST7pBODzEB9F8XT5hXiS8e0vzpSEUp8k2s0p36vYUJDk=
=E4d4
-----END PGP SIGNATURE-----

--rwbb4r/vLufKlfJs--
