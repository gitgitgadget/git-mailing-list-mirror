From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] fast-export: deal with tag objects that do not have a
	tagger
Date: Thu, 18 Dec 2008 22:34:07 +0100
Message-ID: <20081218213407.GX5691@genesis.frugalware.org>
References: <20081218164614.GS5691@genesis.frugalware.org> <7vbpv9guqd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0812182044100.6952@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J1G63k6rHSyTx7zN"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	scott@canonical.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 18 22:35:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDQWx-0008Nh-9a
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 22:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbYLRVeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 16:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753529AbYLRVeL
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 16:34:11 -0500
Received: from virgo.iok.hu ([212.40.97.103]:41201 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753615AbYLRVeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 16:34:09 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 762C3580A6;
	Thu, 18 Dec 2008 22:34:07 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 0DE9C4465E;
	Thu, 18 Dec 2008 22:34:07 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 21EE811B862F; Thu, 18 Dec 2008 22:34:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0812182044100.6952@intel-tinevez-2-302>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103495>


--J1G63k6rHSyTx7zN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2008 at 08:45:44PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> 	I think so.  The responsible code is in fast-export.c, in any=20
> 	case.  Of course, fast-import refuses to import a tag without a=20
> 	tagger, so...

That's why I asked. I think it's a reasonable assumption that in most
cases the tagger and the committer of the tagged commit is the same. So
in case the tagger info is missing and we tag a commit, we could fake
that info on export.

Obviously this should not be the default, but I think such a mode would
be useful in real-life.

--J1G63k6rHSyTx7zN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklKwc8ACgkQe81tAgORUJZ17ACcC5DE0MzOmjigixfJ3QvsOnP2
ohUAn1B9cHQSztQOLBg6q5qlBWmfourF
=s/9P
-----END PGP SIGNATURE-----

--J1G63k6rHSyTx7zN--
