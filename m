From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: [PATCH] git-init: inform user of `git --bare init' option
Date: Fri, 23 May 2008 15:24:32 +0100
Message-ID: <20080523142432.GA8360@bit.office.eurotux.com>
References: <20080519175313.GA17305@bit.office.eurotux.com> <20080520194850.GB19226@bit.office.eurotux.com> <7vy761sgks.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 16:25:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzYDA-0001Ml-AJ
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 16:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbYEWOYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 10:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbYEWOYk
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 10:24:40 -0400
Received: from os.eurotux.com ([216.75.63.6]:37472 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbYEWOYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 10:24:39 -0400
Received: (qmail 18282 invoked from network); 23 May 2008 14:24:38 -0000
Received: from adsl.eurotux.com (HELO bit.office.eurotux.com) (luciano@213.205.93.24)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 23 May 2008 14:24:38 -0000
Content-Disposition: inline
In-Reply-To: <7vy761sgks.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82713>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2008 at 11:02:59PM -0700, Junio C Hamano wrote:
> Luciano Rocha <luciano@eurotux.com> writes:
>=20
> > Creation of a bare repository isn't consistent:
> >
> > $ git init --bare
> > usage: git-init [-q | --quiet] [--template=3D<template-directory>] [--s=
hared]
> > $ git --bare init
> > Initialized empty Git repository in ...
>=20
> The examples do not demonstrate that "it isn't consistent".  It just
> demonstrates that it is easy for people to forget that --bare option is an
> option to the "git" potty itself and not an option to "git init".

Well, "git --help init" works the same as "git init --help", so "--bare"
not working depending on its position isn't very consistent...

<patch snipped>
> Given that you are adding a special case support for "git init --bare"
> anyway, a better approach to help people out of this easy confusion (and
> we have to admit that the confusion is very easy!) would be to make "git
> init --bare" pretend/behave as if the user said "git --bare init", don't
> you think?

Yes, but this was easy for me to do. The proper way, however, will take
me more time.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkg206AACgkQinSul6a7oB9YwQCdFqiqKTx1PJy//y8u2C6JXq+o
poEAnjhMD/AWEDY/22Bu7btujcTZNUjo
=8r6G
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
