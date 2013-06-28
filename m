From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: [PATCH] pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Thu, 27 Jun 2013 21:19:02 -0400
Message-ID: <20130628011902.GD11985@odin.tremily.us>
References: <20130523102959.GP9448@inner.h.apk.li>
 <20130523110839.GT27005@serenity.lan>
 <7vd2shheic.fsf@alter.siamese.dyndns.org>
 <20130523164114.GV27005@serenity.lan>
 <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
 <20130523215557.GX27005@serenity.lan>
 <7vli75cpom.fsf@alter.siamese.dyndns.org>
 <CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
 <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org> <vpqwqpf9p2i.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=KdquIMZPjGJQvRdI
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 28 03:19:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsNLJ-0006je-DO
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 03:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab3F1BTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 21:19:10 -0400
Received: from vms173015pub.verizon.net ([206.46.173.15]:51348 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103Ab3F1BTE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 21:19:04 -0400
Received: from odin.tremily.us ([unknown] [72.68.89.85])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MP200HWMWZR7B60@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 27 Jun 2013 20:19:04 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 00A23A54851; Thu,
 27 Jun 2013 21:19:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1372382343; bh=SbhT4dIUZDny6jVVFveEI+SahKSDk2sB0byO6LpvHkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SN+UWgmE5iMsLD8Yhw8AyXzB/ff+LkOX2EpY6/HDZyKcmOc40C+GnYnSEbtPKhGH5
 wnimomMthm5OaTrTvHLEKqiSB23LVMNe/yMq8NB03orWDwPpW48Fb24AmrZKI/TaDQ
 xY+G3jihpd4x5tjkxVBwRdZmRVyg2ApV1uRmpUoo=
Content-disposition: inline
In-reply-to: <vpqwqpf9p2i.fsf@anie.imag.fr>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229170>


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2013 at 12:16:53AM +0200, Matthieu Moy wrote:
> IMHO, that would be terrible for beginners.
>=20
> My experience with many beginners/students is: they run "git pull" to
> get changes from their co-workers, don't read the messages.

I admit that I'd be happy with a config option that just disabled pull
entirely (forcing people to fetch/merge explicitly) to avoid this type
of beginner mistake.  With an unconfigured pull.rebase, this patch
does that for merge/rebase cases, while still letting folks pull when
it's a clean fast forward (usually ok).

I'd also be happy with an opt-in disable.  The real solution would be
to talk my group out of using a central shared repository or into
using pull-free feature branches, but I don't see either on my
horizon.  Git doesn't need to change to mitigate sloppy-shared-repo
problems, but having some sort of anti-pull configuration option would
certainly help me out.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRzOSDAAoJEKKfehoaNkbt7ukQALB9N5XqSTFkyeOz1P1oamSv
a9NCu1qCkC1qiM2bWnsTebFWpEABpaxxkmN7gQaw+Fx1mO1o0+qewiVzZocVywzc
nrRu3pOEfghlTBPxereh+xKaai6BLQV6AkSFrNYDCQSvjh6Za85DbfRwTbQjzKxf
R0lecTtdzHd1FuQ/87rNW3oFlmfgYTcKOqs19b2HcStSCTEHmK0C2MyoSajlX8gV
oqJAnhomy+sp8OPFRhR0RE9W113X0Rs0TRkkrpMQX+dmN6pjRhr3dqa8may0ygZ3
hxN/k3mLBW8HxUhFtm2qSIKIpjQ12c+pRGBYUPwKQpQakaeJ8SILgftxI085qltH
gNx3aU4MwFtu6hbEkeL8PkIW8shbJKG6b+6abptPROptFb9JQD/mWDKPtg2bfA0i
egk0fmgDyAs6Ia/BKpJg6BI7+QnSXxB9eAsM9rDXzBU/As4wN7sp9sGmBOxRY6NS
aRy+G+6nFZ1JveZ11b5YsgI3wTczTRkEtQma4FTd5kFYhqAls5geSsi6ioAWNtf4
5yD+KM3/8zsZW4seGncRwXMmhVqvJfx7vFS/bud1sGbgS+5pMFg/0f8kdaf9yd7b
0mF0GWL2qt3GzOCnxcANewkUwmLrXzYT8tuKdnUIAtNi0slv2ZFWlfDQR4+W/cor
N2C/fWXmcrtdAk0jw034
=rzcZ
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
