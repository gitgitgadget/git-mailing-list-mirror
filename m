From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [JGIT PATCH v2 07/24] Added findWorkTree method to Repository
	class.
Date: Fri, 23 May 2008 20:31:51 +0200
Message-ID: <20080523183151.GT27724@genesis.frugalware.org>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-8-git-send-email-florianskarten@web.de> <20080513002409.GC29038@spearce.org> <4837090F.4000307@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K+mCiez0w9XOc/8y"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Florian =?iso-8859-1?Q?K=F6berle?= <FloriansKarten@web.de>
X-From: git-owner@vger.kernel.org Fri May 23 20:32:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzc4K-0001EE-MY
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 20:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810AbYEWSby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 14:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbYEWSby
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 14:31:54 -0400
Received: from virgo.iok.hu ([193.202.89.103]:35010 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752637AbYEWSbx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 14:31:53 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id BF52F1B24FE;
	Fri, 23 May 2008 20:31:51 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 68AF64465E;
	Fri, 23 May 2008 20:18:01 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3C0721778001; Fri, 23 May 2008 20:31:51 +0200 (CEST)
Mail-Followup-To: Florian =?iso-8859-1?Q?K=F6berle?= <FloriansKarten@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4837090F.4000307@web.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82726>


--K+mCiez0w9XOc/8y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2008 at 08:12:31PM +0200, Florian K=F6berle <FloriansKarten=
@web.de> wrote:
> Also it is better extenable:
>=20
> if (a) {
> 	something0();
> }
>=20
> if (a) {
> 	something0():
> +	something1();
> }
>=20
> compared too:
>=20
> -if (a)
> +if (a) {
> 	something0();
> +	something1();
> + }
>=20
>=20
> it's even possible that someone does it wrong:
> if (a)
> 	something0():
> 	something1();

Different programmers have different coding style. A standard is needed,
otherwise different parts of the code will have different style. It's
quite normal if a contributor has to code in the project's coding style,
rather than his own one, I think.

Also I don't think "but this style is confusing for newbies" is a valid
argument, newbies should learn to read code, rather than others need to
write newbie-friendly code. ;-)

--K+mCiez0w9XOc/8y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkg3DZcACgkQe81tAgORUJY0hQCeOt/JUAiml9A6zh7VfCk8c+Jx
jOEAn1DB8c3SUsyFMAm/GFlvVWpaaO7o
=WEKZ
-----END PGP SIGNATURE-----

--K+mCiez0w9XOc/8y--
