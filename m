From: Luciano Rocha <strange@nsk.no-ip.org>
Subject: Re: git help error
Date: Tue, 4 Dec 2007 19:47:54 +0000
Message-ID: <20071204194754.GB30780@bit.office.eurotux.com>
References: <cc723f590712040826o7ca36bfg35b8cb4d64ee8d2d@mail.gmail.com> <7v1wa25oqc.fsf@gitster.siamese.dyndns.org> <874pey9uow.fsf@osv.gnss.ru> <7vr6i245b4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Cc: Sergei Organov <osv@javad.com>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 20:48:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izdkr-0003rg-Sa
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 20:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbXLDTsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 14:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbXLDTsH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 14:48:07 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:18900 "EHLO
	exch01smtp09.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751267AbXLDTsG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 14:48:06 -0500
Received: from neti01mx.hdi.tvcabo ([10.137.34.33]) by exch01smtp09.hdi.tvcabo with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 4 Dec 2007 19:48:03 +0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av9/AL89VUdThJYTPGdsb2JhbACBWoV2h3YBAQEBHRgC
Received: from a83-132-150-19.cpe.netcabo.pt (HELO nsk.pt) ([83.132.150.19])
  by neti01smtp.hdi.tvcabo with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Dec 2007 19:48:01 +0000
Received: (qmail 5039 invoked from network); 4 Dec 2007 19:48:01 -0000
Received: by simscan 1.3.1 ppid: 5033, pid: 5035, t: 1.4708s
         scanners: attach: 1.3.1 clamav: 0.90.2/m:43/d:3087
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (strange@nsk.pt@[81.84.255.161])
          (envelope-sender <strange@nsk.no-ip.org>)
          by nsk.pt (etmailserver) with AES256-SHA encrypted SMTP
          for <gitster@pobox.com>; 4 Dec 2007 19:47:59 -0000
Content-Disposition: inline
In-Reply-To: <7vr6i245b4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.14 (2007-03-31)
X-OriginalArrivalTime: 04 Dec 2007 19:48:03.0826 (UTC) FILETIME=[955E6520:01C836AE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67076>


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2007 at 11:40:15AM -0800, Junio C Hamano wrote:
> Sergei Organov <osv@javad.com> writes:
>=20
> > Junio C Hamano <gitster@pobox.com> writes:
> >> "Aneesh Kumar" <aneesh.kumar@gmail.com> writes:
> >>
> >>> git help gives me the below error.
> >>>
> >>> [master@git]$ git help add
> >>> No manual entry for git-add
> >>> See 'man 7 undocumented' for help when manual pages are not available.
> >>> [master@git]$
> >>>
> >>> I have the git binaries installed via --prefix
> >>>
> >>> ./configure --prefix=3D/home/kvaneesh/bin-local/git/
> >>> and to see the man page i have to say
> >>>
> >>> man -M /home/kvaneesh/bin-local/git/share/man/
> >> ...
> >> When you run "man" from the command line, can you say
> >>
> >>      $ man git-add
> >>
> >> and make it work?  If it fails the same way, then what you are missing
> >> is MANPATH environment variable, isn't it?
> >
> > I think what the OP asked for makes sense. git-help should better find
> > corresponding version of manual pages automatically. This way, if one
> > invokes different versions of git-help, he will get corresponding
> > version of help text.
>=20
> I do not necessarily agree.  Read what Aneesh wrote originally again,
> and read what he _didn't_ write.
>=20
> Not only he needs to run his "man" with -M (and my point was that it is
> not the only way, by the way), he needs to futz with his $PATH to
> include $HOME/bin-local/git for _his_ installation to work.
>=20
> I think my suggestion to use $MANPATH is in line with what he is already
> doing.  If you install things in non-standard places, you can use
> environments to adjust to what you did, and that's the reason PATH and
> MANPATH environments are supported by your tools.
>=20
> Having said that, I do not mind accepting a patch that prepends the
> nonlocal path to MANPATH in help.c::show_man_page().

Actually, current man utilities locate the manual page by looking where
the executable is, if MANPATH isn't defined (tested in Linux and
Darwin).

So, "unset MANPATH; man git-add" should be sufficient.

--=20
lfr
0/0

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHVa7qinSul6a7oB8RAt31AKCaGJRiAHFHhsf+SNjtfmbgvdtYWQCeIxtA
P0TcU4qiNlNs+CsDoJkSwPM=
=1pMy
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
