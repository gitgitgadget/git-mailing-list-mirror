From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: Re: [PATCH] git-send-email: Add auto-cc to all body signatures
Date: Thu, 28 Jul 2011 18:43:01 -0700
Organization: Intel Corporation
Message-ID: <1311903782.20837.42.camel@jtkirshe-mobl>
References: <b2937bc06d1bff456b84e51d6edee0bb1afc5f31.1311902983.git.joe@perches.com>
Reply-To: jeffrey.t.kirsher@intel.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-k33ctbn1AVYY4unvD/f0"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 03:43:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmc6h-0005oa-7w
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 03:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392Ab1G2BnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 21:43:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:18914 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756387Ab1G2BnD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 21:43:03 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 28 Jul 2011 18:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,285,1309762800"; 
   d="asc'?scan'208";a="35768710"
Received: from unknown (HELO [10.255.14.145]) ([10.255.14.145])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jul 2011 18:43:01 -0700
In-Reply-To: <b2937bc06d1bff456b84e51d6edee0bb1afc5f31.1311902983.git.joe@perches.com>
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178122>


--=-k33ctbn1AVYY4unvD/f0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-07-28 at 18:34 -0700, Joe Perches wrote:
> Many types of signatures are used by various projects.
>=20
> The most common type is formatted:
>         "[some_signature_type]-by: First Last <email@domain.tld>"
> e.g:
>         "Reported-by: First Last <email@domain.tld>" (no quotes are
> used)
>=20
> Make git-send-email use these signatures as "CC:" entries.
>=20
> Add command line option --suppress-cc=3Dsignatures to avoid
> adding these entries to the cc.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>=20

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Thanks, I was getting tired of having to add CC: <blah> especially since
we already had Reported-by: <blah> and Tested-by: <blah>, yet they were
never copied on the patch.

--=-k33ctbn1AVYY4unvD/f0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOMhAlAAoJECTsCADr/EWUQ9QIAIXomc9+J2JnRI5aNYLQC0Ik
NYVoeD4sA20e9e/GkkKJUpdh/GFaR+RU6ft+mlCnzNpUc3ELwbV922zltAgZIUDF
4H9WeTWMRyWnAMQrod5Lg732Rm1SUCCHW2qseDLDFPpLdEBjWBVcXPK8u8ImgYaw
mofSGjiczS+/lWyJvZEh2SJBjm6FhkvyiloqTYZR/Dn9zWvj1yaCAYlgGhMzESHA
3iEXt3IjDo8pbbVjOFZnvXRxK7TUYHtnT261PobZZKcTKXWm3N/xTJPT1FT1t6Wm
UgwiMGH1qhvicy4jgioQyTfZv+ueWj6qqZTe7PfdexBFzrCJ84JaVTZS8xi/z5k=
=ZF1W
-----END PGP SIGNATURE-----

--=-k33ctbn1AVYY4unvD/f0--
