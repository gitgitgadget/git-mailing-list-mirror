From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: Versioning configuration files on a server: fatal: Unable to
	create '//etc/.git/index.lock': No such file or directory
Date: Wed, 24 Nov 2010 09:50:30 +0100
Message-ID: <20101124085030.GB22067@login.drsnuggles.stderr.nl>
References: <AANLkTikfg9fLtqC6V3hQkiSZ+RfWqViJsHPxrt6ycoRR@mail.gmail.com> <AANLkTim_sPyVGK3XWEVseseRzcmNM-YS=aFSWZeBiB7n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7hb49YTkEhc+rP/V"
Cc: Ilyas -- <umask00@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 09:50:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLB3m-0000DY-Iq
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 09:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab0KXIud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 03:50:33 -0500
Received: from drsnuggles.stderr.nl ([94.142.244.14]:47345 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab0KXIuc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 03:50:32 -0500
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1PLB3e-0006MD-9J; Wed, 24 Nov 2010 09:50:31 +0100
Received: (nullmailer pid 24438 invoked by uid 1000);
	Wed, 24 Nov 2010 08:50:30 -0000
Mail-Followup-To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ilyas -- <umask00@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTim_sPyVGK3XWEVseseRzcmNM-YS=aFSWZeBiB7n@mail.gmail.com>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -2.5 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162054>


--7hb49YTkEhc+rP/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

On Wed, Nov 24, 2010 at 03:45:43PM +0700, Nguyen Thai Ngoc Duy wrote:
> On Wed, Nov 24, 2010 at 3:01 PM, Ilyas -- <umask00@gmail.com> wrote:
> > The patch bellow for problem 'Versioning configuration files on a
> > server: fatal: Unable to create '//etc/.git/index.lock': No such file
> > or directory' works fine on FreeBSD/Linux.
> > Please fix this problem in upstream.
>=20
> I also have another patch to fix this [1]. Hopefully Junio will pick it u=
p soon.
The patch sent by Ilyas is mine and it was just a quick hack. Please use
the patch sent later by Nguyen instead, it solves the problem properly:

> [1] http://article.gmane.org/gmane.comp.version-control.git/161825

--7hb49YTkEhc+rP/V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzs0dYACgkQz0nQ5oovr7xKwQCgqd/l6cuub7zXlnbepYCDRwEW
i88AniNyZFrWeYS5gNlKJfEnENo6ml2p
=uRWs
-----END PGP SIGNATURE-----

--7hb49YTkEhc+rP/V--
