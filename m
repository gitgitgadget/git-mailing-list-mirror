From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 3/4] add -p: optionally prompt for single characters
Date: Wed, 4 Feb 2009 20:42:08 +0100
Message-ID: <200902042042.13787.trast@student.ethz.ch>
References: <7vljspjk8n.fsf@gitster.siamese.dyndns.org> <1233611191-18590-4-git-send-email-trast@student.ethz.ch> <20090203062437.GB21367@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11983958.giM4Evm18L";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Suraj Kurapati <sunaku@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 04 20:44:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUnfF-0005VP-Iu
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 20:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbZBDTmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 14:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbZBDTmf
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 14:42:35 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:47256 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151AbZBDTme (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 14:42:34 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Feb 2009 20:42:32 +0100
Received: from thomas.localnet ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Feb 2009 20:42:32 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <20090203062437.GB21367@sigill.intra.peff.net>
X-OriginalArrivalTime: 04 Feb 2009 19:42:32.0950 (UTC) FILETIME=[B8F3B960:01C98700]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108416>

--nextPart11983958.giM4Evm18L
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jeff King wrote:
> On Mon, Feb 02, 2009 at 10:46:30PM +0100, Thomas Rast wrote:
> Minor nit: the name of this variable implies that it will be used across
> all interactive commands (including any future ones). But the
> description is intimately linked with perl. Maybe structure it like
> "here is what this does in general, but here are some specific caveats".
> Something like:
>=20
>   interactive.readkey::
>         In interactive programs, allow the user to provide one-letter
>         input with a single key (i.e., without hitting enter). Currently
>         this is used only by the `\--patch` mode of linkgit:git-add[1].
>         Note that this feature is silently disabled for Perl programs
>         (like git-add) if Term::ReadKey is not available.

Junio indicates in the corresponding pu topic that he is of the same
opinion, so I'll reroll with your help text.  (It's somewhat
inaccurate since git-add is not really a perl program, but let's not
tell the users about our implementation details.)

Meanwhile I've had regrets about reusing color.interactive.help for
errors, so I'll also reroll 4/4 with a new color .error that just
defaults to .help.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart11983958.giM4Evm18L
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmJ75UACgkQqUud07tmzP24ZgCfVxdKl9tQSxA9mrqmGk/RLUwi
Zc0An1YhoKOU1Dc97iUHtxR15zwtv25/
=UdOT
-----END PGP SIGNATURE-----

--nextPart11983958.giM4Evm18L--
