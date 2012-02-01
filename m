From: Thomas Dickey <dickey@his.com>
Subject: Re: [PATCH] Correct singular form in diff summary line for human
	interaction
Date: Tue, 31 Jan 2012 20:56:06 -0500
Message-ID: <20120201015606.GA24482@debian50-32.invisible-island.net>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <20120131152028.GA10717@burratino> <7vvcnr92y0.fsf@alter.siamese.dyndns.org>
 <CACsJy8Dd4_Pnvzxww38EfZt8NgRow+qxCReohc45XoNpfJCbYg@mail.gmail.com>
Reply-To: dickey@his.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=gBBFr7Ir9EOA20Yy
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>, dickey@invisible-island.net
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 02:56:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsPRE-0002Vi-Cr
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 02:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab2BAB4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 20:56:37 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:40417 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab2BAB4h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 20:56:37 -0500
Received: from par-debian50-32.invisible-island.net
 ([unknown] [96.241.212.238]) by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LYO00EX4YPJEPL0@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 31 Jan 2012 19:56:09 -0600 (CST)
Received: from par-debian50-32.invisible-island.net (localhost [127.0.0.1])
	by par-debian50-32.invisible-island.net (8.14.3/8.14.3/Debian-5+lenny1)
 with ESMTP id q111u75f024505
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT); Tue,
 31 Jan 2012 20:56:07 -0500
Received: (from tom@localhost)	by par-debian50-32.invisible-island.net
 (8.14.3/8.14.3/Submit) id q111u6lb024503; Tue, 31 Jan 2012 20:56:06 -0500
Content-disposition: inline
In-reply-to: <CACsJy8Dd4_Pnvzxww38EfZt8NgRow+qxCReohc45XoNpfJCbYg@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189493>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2012 at 08:32:43AM +0700, Nguyen Thai Ngoc Duy wrote:
> On Wed, Feb 1, 2012 at 12:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >> If there is an environment variable to say "I don't want to see
> >> variations on strings intended for humans", can it be spelled as
> >> LC_ALL=3DC?
> >
> >  ...

=2E.. diffstat (google helped find context)

> > If we were to touch this, I would prefer to do so unconditionally witho=
ut
> > "hrm, can we reliably guess this is meant for humans?" and release it
> > unceremoniously, perhaps as part of the next release that will have a m=
uch
> > bigger user-visible UI correction to 'merge'.
>=20
> Unconditionally change is fine to me. There's another implication
> that's not mentioned in the commit message, this change also allows
> non-English translations. Any objections on i18n or we just keep this
> line English only? Personally if scripts do not matter any more, I see
> no reasons this line cannot be translated.

I seem to recall that gettext does support plurals...

However, going that route means that even innocuous things like the
parentheses "(+)" can be mangled by translators (guaranteed to break
scripts ;-)

--=20
Thomas E. Dickey <dickey@invisible-island.net>
http://invisible-island.net
ftp://invisible-island.net

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk8om7YACgkQcCNT4PfkjtsENQCfRMsM9VAgmMkk0T4bvc1/dlkC
IpsAn221lYX8rzFDRKnNPxNM4ZEN5Z+/
=oNeF
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
