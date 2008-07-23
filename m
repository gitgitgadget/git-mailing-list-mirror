From: Miklos Vajna <vmiklos@frugalware.org>
Subject: HP-UX issues (WAS: Re: [RFC] Git User's Survey 2008)
Date: Wed, 23 Jul 2008 09:47:47 +0200
Message-ID: <20080723074747.GA32057@genesis.frugalware.org>
References: <200807230325.04184.jnareb@gmail.com> <7vsku1gqny.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e+JRL32uBeeWnrD4"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 09:48:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLZ5e-000821-IL
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 09:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbYGWHru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 03:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbYGWHru
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 03:47:50 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60164 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415AbYGWHru (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 03:47:50 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 4B19D1B2513;
	Wed, 23 Jul 2008 09:47:48 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4B6F54465E;
	Wed, 23 Jul 2008 09:06:38 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 029EC11901B3; Wed, 23 Jul 2008 09:47:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsku1gqny.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89609>


--e+JRL32uBeeWnrD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2008 at 09:39:29PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> >    15. What operating system do you use Git on?
> >        (one or more: multiple choice, as one can use more than one OS)
> >      - Linux, *BSD (FreeBSD, OpenBSD, etc.), MS Windows/Cygwin,
> >        MS Windows/msysGit, MacOS X, other UNIX, other
>=20
> Shouldn't we at least name the ones we have specific support in our
> Makefile instead of blanketting them into one "other Unices"?  We may not
> necessarily want to list all of them, but at least major ones like SunOS,
> HP-UX and AIX deserve to be listed, methinks.

Last time I checked git did not build on HP-UX (11.11) out of the box
because its 'install' did not support -d nor -m. There are a few more
issues installed here:

http://hpux.connect.org.uk/hppd/cgi-bin/wwwtar?/hpux/Development/Tools/git-=
1.5.6.2/git-1.5.6.2-src-11.11.tar.gz+git-1.5.6.2/HPUX.Install+text

So I think the word "we support" is a bit too strong. ;-)

Being more constructive, what a user using HP-UX is supported to do?

1) Use the patched git from HP.

2) Have coreutils installed. (But then I think it would be good to list
this dependency in INSTALL.)

3) Patch git to use automake's install-sh. (Would such a patch be ever
accepted?)

Thanks.

PS: No, I rarely use git on HP-UX, but I would be happy to bring the
equivalent of HP's most changes to git.git if possible.

--e+JRL32uBeeWnrD4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiG4iMACgkQe81tAgORUJZL+ACfSRCRtJ/YWRSofPqEMNUvlj8k
WzYAnji6n2VSV/0+I6T9s5bTpP9d66s9
=tsUU
-----END PGP SIGNATURE-----

--e+JRL32uBeeWnrD4--
