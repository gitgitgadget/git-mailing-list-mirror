From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH] git submodule foreach: Skip eval for more than one
 argument
Date: Tue, 4 Mar 2014 15:57:03 +0100
Message-ID: <20140304145703.GE11566@login.drsnuggles.stderr.nl>
References: <alpine.DEB.2.00.1309261605330.20647@dr-wily.mit.edu>
 <20140304135106.GD11566@login.drsnuggles.stderr.nl>
 <CALKQrgfC1Cf=ZnwhaDUz-2q=vLa0UbO4ONybvCPu7RiF+3sm3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rYG72ePx0AS+3phQ"
Cc: Anders Kaseorg <andersk@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Mar 04 15:57:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKqmU-0000fx-U0
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 15:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371AbaCDO5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 09:57:15 -0500
Received: from drsnuggles.stderr.nl ([94.142.244.14]:48049 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757187AbaCDO5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 09:57:14 -0500
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1WKqmG-0003Bp-4C; Tue, 04 Mar 2014 15:57:04 +0100
Received: (nullmailer pid 12263 invoked by uid 1000);
	Tue, 04 Mar 2014 14:57:03 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Johan Herland <johan@herland.net>, Anders Kaseorg <andersk@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALKQrgfC1Cf=ZnwhaDUz-2q=vLa0UbO4ONybvCPu7RiF+3sm3w@mail.gmail.com>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243346>


--rYG72ePx0AS+3phQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2014 at 03:53:24PM +0100, Johan Herland wrote:
> On Tue, Mar 4, 2014 at 2:51 PM, Matthijs Kooijman <matthijs@stdin.nl> wro=
te:
> > matthijs@grubby:~/test$ git submodule foreach echo '$name'
> > Entering 'test'
> > $name
>=20
> jherland@beta ~/test$ echo '$name'
> $name
>=20
> What would you expect echo '$name' to do?
If I run git submodule foreach each '$name', then my shell eats the
single quotes (which are only to prevent my shell from interpreting
$name). git submodule will see $name, so it will run echo $name, not
echo '$name'.

> What happens if you use double instead of single quotes?
Then my shell eats up the double quotes _and_ replaces $name with
nothing, so I can't expect git submodule to replace it with the
submodule name then :-)

Does that help to clarify what I mean?

Gr.

Matthijs

--rYG72ePx0AS+3phQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAlMV6b8ACgkQz0nQ5oovr7zTdwCdFHWdEoPabs9kf4rgT+zyRtRK
oBMAnjgGq/8zSJaHyg2vJKPpJYow+hXp
=D9z6
-----END PGP SIGNATURE-----

--rYG72ePx0AS+3phQ--
