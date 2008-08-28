From: Sebastian Harl <sh@tokkee.org>
Subject: Re: [StGit] Debian packaging update
Date: Thu, 28 Aug 2008 19:22:28 +0200
Message-ID: <20080828172227.GI1289@albany.tokkee.org>
References: <20080818201036.7c2c00f8@whitehouse.id.au> <b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com> <20080822235154.5e1f979c@whitehouse.id.au> <b0943d9e0808221457w42a84fbgdf62e3ddbb417389@mail.gmail.com> <20080823135855.1a7aafd4@whitehouse.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+1TulI7fc0PCHNy3"
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
To: Daniel White <daniel@whitehouse.id.au>
X-From: git-owner@vger.kernel.org Thu Aug 28 19:49:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlbe-0006qX-E8
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888AbYH1Rql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755936AbYH1Rqh
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:46:37 -0400
Received: from mail.tokkee.org ([212.114.247.92]:60457 "EHLO albany.tokkee.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753765AbYH1Rq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 13:46:28 -0400
X-Greylist: delayed 1437 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Aug 2008 13:46:27 EDT
Received: by albany.tokkee.org (Postfix, from userid 1000)
	id 0EA0A364001; Thu, 28 Aug 2008 19:22:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080823135855.1a7aafd4@whitehouse.id.au>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94103>


--+1TulI7fc0PCHNy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 23, 2008 at 01:58:55PM +1000, Daniel White wrote:
> On Fri, 22 Aug 2008 22:57:02 +0100
> "Catalin Marinas" <catalin.marinas@gmail.com> wrote:
> > 2008/8/22 Daniel White <daniel@whitehouse.id.au>:
> > > Since it is now packaged by Debian is it still necessary to be
> > > maintaining Debian packaging?
> >=20
> > This is mainly to make it easier for Debian maintainers. Someone might
> > also want to build a .deb package for a different version or flavour
> > of Debian.
> >=20
>=20
> I had been reading an article recently about packaging, and there was
> the suggestion that upstream having packaging caused headaches when
> merging new versions.

Including a debian/ dir in the upstream VCS usually should not be a
problem as long as it's not included in release tarballs. The main
problem _I_ see when the latter is not given (and I suppose that's why a
lot of people don't like it either) is that you'd get a really ugly diff
between upstream sources and the Debian packaging (the .diff.gz of a
Debian source package).

Imho, keeping a debian/ dir in the upstream VCS is a nice service to the
user and keeping it close to the "official" Debian packaging is even
better.

Cheers,
Sebastian

--=20
Sebastian "tokkee" Harl +++ GnuPG-ID: 0x8501C7FC +++ http://tokkee.org/

Those who would give up Essential Liberty to purchase a little Temporary
Safety, deserve neither Liberty nor Safety.         -- Benjamin Franklin


--+1TulI7fc0PCHNy3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFItt7TEFEKc4UBx/wRAjU/AKCG9BH8xRxPfe0afi2RQEhiw8r2TwCdHPjh
JpHWaz+JAUUQ1mMy4LJvfn4=
=v8t6
-----END PGP SIGNATURE-----

--+1TulI7fc0PCHNy3--
