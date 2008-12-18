From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] fast-export: deal with tag objects that do not have a
	tagger
Date: Fri, 19 Dec 2008 00:38:43 +0100
Message-ID: <20081218233843.GA21154@genesis.frugalware.org>
References: <20081218164614.GS5691@genesis.frugalware.org> <7vbpv9guqd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0812182044100.6952@intel-tinevez-2-302> <20081218213407.GX5691@genesis.frugalware.org> <7viqphf4ua.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, scott@canonical.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 00:40:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDSTQ-0002tM-Fc
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 00:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbYLRXis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 18:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbYLRXis
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 18:38:48 -0500
Received: from virgo.iok.hu ([212.40.97.103]:53127 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbYLRXis (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 18:38:48 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 51A71580A7;
	Fri, 19 Dec 2008 00:38:46 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E5BED4465E;
	Fri, 19 Dec 2008 00:38:43 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D48A411B862F; Fri, 19 Dec 2008 00:38:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7viqphf4ua.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103510>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2008 at 03:20:29PM -0800, Junio C Hamano <gitster@pobox.com=
> wrote:
> Such a "faking" can well be done, and should be done, on the consuming end
> of the information.  If you fake using the commit authorship, you would
> never be able to tell from the result which one is faked and which one is
> genuine.
>=20
> I think you'd rather want to see "Unspecified Tagger" in the resulting tag
> object (or even better, a tag object without the tagger field created by
> the fast-import process), and leave the interpretation of missing tagger
> information to the consumers.

Aah, I missed that Dscho's patch will not just not die(), but it _will_
output a stream that fast-import will import. So just forget my
complain. :-)

And Dscho, thanks!

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklK3wMACgkQe81tAgORUJbVVACfeC3aaoXpiGK2saqCZ12B9w71
eAwAn3p/0YDnsxm6a9UjKeQczW6ZelPo
=d3IS
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
