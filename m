From: Erik Mouw <mouw@nl.linux.org>
Subject: Re: cpio command not found
Date: Wed, 31 Oct 2007 15:06:55 +0100
Organization: Eric Conspiracy Secret Labs
Message-ID: <20071031140655.GA8802@gateway.home>
References: <18216.31314.990545.518458@lisa.zopyra.com> <20071031133039.GA29065@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Karl Hasselstr?m <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 15:17:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InENY-00012M-5J
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 15:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbXJaOQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 10:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755232AbXJaOQy
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 10:16:54 -0400
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:2512 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbXJaOQx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 10:16:53 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Oct 2007 10:16:53 EDT
Received: from gateway.home (a82-92-155-199.adsl.xs4all.nl [82.92.155.199])
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id l9VE6uIq016535;
	Wed, 31 Oct 2007 15:07:05 +0100 (CET)
	(envelope-from mouw@nl.linux.org)
Received: from erik by gateway.home with local (Exim 3.36 #1 (Debian))
	id 1InEDf-000491-00; Wed, 31 Oct 2007 15:06:55 +0100
Content-Disposition: inline
In-Reply-To: <20071031133039.GA29065@diana.vm.bytemark.co.uk>
X-Eric-Conspiracy: There is no conspiracy!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62835>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 31, 2007 at 02:30:39PM +0100, Karl Hasselstr?m wrote:
> On 2007-10-31 06:51:30 -0600, Bill Lear wrote:
>=20
> > I don't remember this dependence from earlier versions of git. I
> > have been running git 1.4.xx on this machine for a while...
>=20
> When you clone with -l, git uses cpio to hardlink to the original
> repository. What has changed is that -l is now used by default when
> cloning a repository that's accessed via the file system (as opposed
> to over some network protocol).

Why cpio? What is wrong with ln(1) (every Unix should have one) or
link(2) ?


Erik

--=20
They're all fools. Don't worry. Darwin may be slow, but he'll
eventually get them. -- Matthew Lammers in alt.sysadmin.recovery

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHKIv//PlVHJtIto0RAit8AJ9w65EvHUzpVpsAa9rwpH8PP4oxGQCcCkwA
d/WVxtyyrpn2TiC3j/+rV9s=
=OQTH
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
