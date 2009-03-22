From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 1/8] builtin-apply: use warning() instead of
	fprintf(stderr, "warning: ")
Date: Sun, 22 Mar 2009 12:36:46 +0100
Message-ID: <20090322113646.GL27459@genesis.frugalware.org>
References: <200902190736.49161.johnflux@gmail.com> <20090219081725.GB7774@coredump.intra.peff.net> <20090219120708.GM4371@genesis.frugalware.org> <20090219122104.GA4602@sigill.intra.peff.net> <4f61642d10063adbff86094e91b1b6e90efabe8e.1235047192.git.vmiklos@frugalware.org> <20090220030245.GC22419@coredump.intra.peff.net> <7viqn5iqnn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jQIvE3yXcK9X9HBh"
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 12:38:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlM0r-0007af-P5
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 12:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbZCVLgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 07:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753980AbZCVLgt
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 07:36:49 -0400
Received: from virgo.iok.hu ([212.40.97.103]:39999 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020AbZCVLgt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 07:36:49 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0007E5811D;
	Sun, 22 Mar 2009 12:36:46 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 52C5A44783;
	Sun, 22 Mar 2009 12:36:46 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 44D0811B80AE; Sun, 22 Mar 2009 12:36:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7viqn5iqnn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114135>


--jQIvE3yXcK9X9HBh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2009 at 10:11:24PM -0800, Junio C Hamano <gitster@pobox.com=
> wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > Other than that, these all look pretty straightforward. Probably the
> > shell scripts should be switched to match, too. But it would be nice to
> > hear from Junio first that this cleanup is even desired (so you don't
> > waste time).
>=20
> I think it is a good thing to do.  If the pre-release-freeze is a good
> time to do so it is a different matter.  A good way to judge would be=20
> how much of these overlap with "git diff master next" (smaller the better,
> obviously).

Should I rebase the series against current master and resend?

--jQIvE3yXcK9X9HBh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknGIs4ACgkQe81tAgORUJbGbACfdpwr90PaZ9oIb6uVnhOnFYXP
n34AnjubWxYNaQu5O8HjchtGTj/Cgise
=dSPF
-----END PGP SIGNATURE-----

--jQIvE3yXcK9X9HBh--
