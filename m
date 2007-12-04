From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: git help error
Date: Tue, 4 Dec 2007 20:06:25 +0000
Message-ID: <20071204200625.GA32717@bit.office.eurotux.com>
References: <cc723f590712040826o7ca36bfg35b8cb4d64ee8d2d@mail.gmail.com> <7v1wa25oqc.fsf@gitster.siamese.dyndns.org> <874pey9uow.fsf@osv.gnss.ru> <7vr6i245b4.fsf@gitster.siamese.dyndns.org> <20071204194754.GB30780@bit.office.eurotux.com> <863auiw86m.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Dec 04 21:13:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ize9H-0005rs-JS
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 21:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbXLDUNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 15:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbXLDUNO
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 15:13:14 -0500
Received: from os.eurotux.com ([216.75.63.6]:40760 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbXLDUNO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 15:13:14 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Dec 2007 15:13:13 EST
Received: (qmail 7387 invoked from network); 4 Dec 2007 20:06:31 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 4 Dec 2007 20:06:31 -0000
Content-Disposition: inline
In-Reply-To: <863auiw86m.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67080>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2007 at 08:50:41PM +0100, David Kastrup wrote:
> Luciano Rocha <strange@nsk.no-ip.org> writes:
>=20
> > On Tue, Dec 04, 2007 at 11:40:15AM -0800, Junio C Hamano wrote:
> >
> >> Having said that, I do not mind accepting a patch that prepends the
> >> nonlocal path to MANPATH in help.c::show_man_page().
> >
> > Actually, current man utilities locate the manual page by looking where
> > the executable is, if MANPATH isn't defined (tested in Linux and
> > Darwin).
> >
> > So, "unset MANPATH; man git-add" should be sufficient.
>=20
> That only works for paths registered in /etc/manpath.config (or an
> equivalent config file depending on system/distribution).

Err, no. I doubt my ~/opt/noarch/.../...; ~/opt/`uname -i`/git/; etc.,
are pre-registered by my Linux distro or OS X 10.[45].

man man:
       If you specify the -M pathlist option, pathlist  is  a  colon-separa=
ted
       list of the directories that man searches.

       If  you  don=E2=80=99t specify -M but set the MANPATH environment va=
riable, the
       value of that  variable  is  the  list  of  the  directories  that  =
man
       searches.

       If  you  don=E2=80=99t  specify  an  explicit path list with -M or M=
ANPATH, man
       develops its own path list based on the contents of  the  configurat=
ion
       file /etc/man.config.  The MANPATH statements in the configuration f=
ile
       identify particular directories to include in the search path.
=2E..
       In addition, for each directory in the command search path (we=E2=80=
=99ll  call
       it  a  "command  directory")  for  which  you do not have a MANPATH_=
MAP
       statement, man automatically looks for a manual page directory "near=
by"
       namely as a subdirectory in the command directory itself or in the p=
ar-
       ent directory of the command directory.

So, according to the last paragraph, and assuming no -M argument and no
MANPATH environment variable are defined, man should be able to find the
manual pages for git commands if they're in PATH.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=C3=A1tica, S.A. <http://www.eurotux.com/>

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHVbNBinSul6a7oB8RAnhyAJ4tK9tsjdINR6pRKvwpWkAGLnxCeACeO7TD
ex/hb0nBVxKNSlP3tRJJ1UM=
=Y2Ue
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
