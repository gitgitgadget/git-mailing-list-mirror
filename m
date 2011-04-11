From: Fraser Tweedale <frase@frase.id.au>
Subject: Re: [PATCH] supply '-n' to gzip to produce identical tarballs
Date: Tue, 12 Apr 2011 06:59:36 +1000
Message-ID: <20110411205934.GI1521@bacardi.wooloowin.frase.id.au>
References: <1302415936-7362-1-git-send-email-frase@frase.id.au>
 <m362qm4kvu.fsf@localhost.localdomain>
 <20110410101345.GD1521@bacardi.wooloowin.frase.id.au>
 <201104101555.09798.jnareb@gmail.com>
 <7vei58wq0a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 23:00:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9ODK-0001Cc-Hx
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 23:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581Ab1DKU74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 16:59:56 -0400
Received: from 60-242-254-5.static.tpgi.com.au ([60.242.254.5]:64609 "EHLO
	bacardi.wooloowin.frase.id.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754611Ab1DKU74 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Apr 2011 16:59:56 -0400
Received: from bacardi.wooloowin.frase.id.au (localhost [127.0.0.1])
	by bacardi.wooloowin.frase.id.au (8.14.4/8.14.4) with ESMTP id p3BKxilr027525;
	Tue, 12 Apr 2011 06:59:44 +1000 (EST)
	(envelope-from frase@frase.id.au)
Received: (from Fraser@localhost)
	by bacardi.wooloowin.frase.id.au (8.14.4/8.14.4/Submit) id p3BKxatv027524;
	Tue, 12 Apr 2011 06:59:36 +1000 (EST)
	(envelope-from frase@frase.id.au)
X-Authentication-Warning: bacardi.wooloowin.frase.id.au: Fraser set sender to frase@frase.id.au using -f
Content-Disposition: inline
In-Reply-To: <7vei58wq0a.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171355>


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2011 at 12:24:05PM -0700, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> >> > Perhaps it would be more clear to use
> >> >=20
> >> >   +		'compressor' =3D> ['gzip', '--no-name']},
> >
> >> Definitely, if the argument is the same (or even present) on all syste=
ms.
> >> On FreeBSD and GNU both '-n' and '--no-name' are do the job, but an au=
dit
> >> of other systems should be done to ensure they don't break.  I chose '=
-n'
> >> as it seemed the more conservative choice.
> >
> > So you choose '-n' because it has more chance of being widely supported,
> > isn't it?  Good enough for me.
>=20
> Interesting.  "gzip <COPYING" does get a consistent result because it can
> fstat to get the timestamp, but "cat COPYING | gzip" does change its
> output every time it is run.  Good catch and a solution.  Thanks, both.
>=20
> So I should expect a pull request sometime after 1.7.5 final from you,
> with "an audit of other systems" done by others on the list noted in the
> final commit message?
>=20
>=20
Sure, no problem.

Thanks,

Fraser

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (FreeBSD)

iEYEARECAAYFAk2ja7YACgkQPw/2FZbemTUDgACeMC0Zv+fzNup7cxnXWTCRwgL2
bF0AoIZ+Q8zjxSYZbMZVzkrKzxErfL4u
=hn4Q
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
