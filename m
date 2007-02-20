From: Erik Mouw <mouw@nl.linux.org>
Subject: Re: git installation (as private user) should NEVER write site_perl
Date: Tue, 20 Feb 2007 19:12:24 +0100
Organization: Eric Conspiracy Secret Labs
Message-ID: <20070220181224.GD26444@gateway.home>
References: <86sld0sq7c.fsf@blue.stonehenge.com> <20070220175536.GC26444@gateway.home> <86abz8sodh.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 19:12:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJZTg-00054I-Hu
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 19:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbXBTSMd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 13:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbXBTSMd
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 13:12:33 -0500
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:3550 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030339AbXBTSMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 13:12:33 -0500
Received: from gateway.home (a82-92-155-199.adsl.xs4all.nl [82.92.155.199])
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id l1KICOgY041464;
	Tue, 20 Feb 2007 19:12:29 +0100 (CET)
	(envelope-from mouw@nl.linux.org)
Received: from erik by gateway.home with local (Exim 3.36 #1 (Debian))
	id 1HJZTU-0000Ya-00; Tue, 20 Feb 2007 19:12:24 +0100
Content-Disposition: inline
In-Reply-To: <86abz8sodh.fsf@blue.stonehenge.com>
X-Eric-Conspiracy: There is no conspiracy!
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40249>


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2007 at 09:57:46AM -0800, Randal L. Schwartz wrote:
> >>>>> "Erik" =3D=3D Erik Mouw <mouw@nl.linux.org> writes:
>=20
> Erik> On Tue, Feb 20, 2007 at 09:18:15AM -0800, Randal L. Schwartz wrote:
> >> I tried to install git on a system where I was a normal user.  Of cour=
se,
> >> this step fails:
> >>=20
> >> Installing /usr/perl5/site_perl/5.6.1/Error.pm
> >> Installing /usr/perl5/site_perl/5.6.1/Git.pm
>=20
> Erik> It gets installed in ~/share/perl/5.8.4/ when I compile as a normal
> Erik> user (git-1.5.0.1):
>=20
> Erik> Installing /home/erik/share/perl/5.8.4/Error.pm
> Erik> Installing /home/erik/share/perl/5.8.4/Git.pm
> Erik> Installing /home/erik/man/man3/private-Error.3pm
> Erik> Installing /home/erik/man/man3/Git.3pm
>=20
> Is that a personally-installed Perl though?  Those paths look suspicious.

No, just standard Debian stable packages:

  erik@zurix:~> which perl
  /usr/bin/perl
  erik@zurix:~> dpkg -S /usr/bin/perl
  perl-base: /usr/bin/perl
  perl-base: /usr/bin/perl
  erik@zurix:~> dpkg -l perl-base
  Desired=3DUnknown/Install/Remove/Purge/Hold
  | Status=3DNot/Installed/Config-files/Unpacked/Failed-config/Half-install=
ed
  |/ Err?=3D(none)/Hold/Reinst-required/X=3Dboth-problems (Status,Err: uppe=
rcase=3Dbad)
  ||/ Name           Version        Description
  +++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  ii  perl-base      5.8.4-8sarge5  The Pathologically Eclectic Rubbish Lis=
ter

Git is installed in my home directory:

  erik@zurix:~ > which git
  /home/erik/bin/git


Erik

--=20
They're all fools. Don't worry. Darwin may be slow, but he'll
eventually get them. -- Matthew Lammers in alt.sysadmin.recovery

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF2zoI/PlVHJtIto0RArCqAKCJOObd4UtjrH5Em4Lu7ocyPWk+0wCfXhHe
SU3XYUDH1IFxbAUKVh2pv34=
=E4G8
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
