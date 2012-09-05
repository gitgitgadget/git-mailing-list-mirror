From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH 0/2] Add --expand to 'git notes get-ref'
Date: Wed, 05 Sep 2012 13:53:44 -0400
Message-ID: <20120905175344.GA8619@odin.tremily.us>
References: <cover.1346848834.git.wking@tremily.us>
 <CALKQrgdRqd59pfLtpROwxtrFjvO5oYgKKN3KCp1NA4aMEEcj1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=x+6KMIRAuhnl3hBn
Cc: Git <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 05 20:53:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9Kjc-0002mK-4t
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 20:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab2IESxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 14:53:49 -0400
Received: from vms173007pub.verizon.net ([206.46.173.7]:40445 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab2IESxs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 14:53:48 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2012 14:53:48 EDT
Received: from odin.tremily.us ([unknown] [72.68.85.126])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M9W001X71PKXUB0@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 05 Sep 2012 12:53:45 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 778765C31A2; Wed,
 05 Sep 2012 13:53:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1346867624; bh=TCJNVK5cjg7UxInm0G/eaPQUwsV7a0DMsptNWXV8QWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j2YOZ62o/cMItyc+wPiLvQctLELD7lbzTFQ1vCxKaLkD7jJ+b1b3YE+GT3fKkfoi3
 s4ntFBEXti/OVgUk7wNk81GrOTEcgk+wybtwzFY0Ynz7Fl6ZUezGH1iUOTBEUDFsq3
 JSCuUskFTwsgsbuesScVUmOj6S+PIUbb7YJdKxwY=
Content-disposition: inline
In-reply-to: <CALKQrgdRqd59pfLtpROwxtrFjvO5oYgKKN3KCp1NA4aMEEcj1w@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204838>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2012 at 05:58:37PM +0200, Johan Herland wrote:
> On Wed, Sep 5, 2012 at 2:48 PM, W. Trevor King <wking@tremily.us> wrote:
> > If I'm missing a good reason to keep everything under
> > 'refs/notes/', feel free to ignore the second patch.
>=20
> This has been discussed a couple of times on this list, but it never
> resulted in any actual changes. Read up on this thread to get some
> context:
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/160503

Thanks for the pointer, it looks like there are a bunch of good ideas.
I assume the lack of changes was due to nobody having the
time/inclination to implement

  http://article.gmane.org/gmane.comp.version-control.git/160655

Trevor

--=20
As a side note, does anyone know of a thread-specific version of

  http://download.gmane.org/<xyz>/<start>/<stop>

It would be easier for me (and less load for them) if I could run

  http://download.gmane.org/gmane.comp.version-control.git/thread/160503

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQR5GlAAoJEEUbTsx0l5OMGwgP/2/0H5yx9Op52oDIZwG0qYCn
ljAxK2RxhsL4g4BrQgGLRup834DAZrih3270Jy9OPxMw2TRvKKW+wOwXy4GnaYIP
quWFgrrzYNnLXsfXOuJOudVkBwiyYKTHxEfEGH+/lArCtGixR0+RwodrAJVyCDM9
O6gRMhGwzUDFEpf3HUf2kTjSqf4ZvYPgxkYq9I/l4v2M+loOWM4IOvtG4Zso8PfZ
Gd7ttxB+3nt9HmCfEeO6Q7EDuYniT5VQ3WChZsv9SIzegWIasxZpRq8Sp43+jSDR
Oi7ovyh0CjWoiDvLF9uljXRgERlUZlVYgZFJBvevEpTpoGb4kJE/6RbrRCkYqSCN
AECqgK8/LzWtsgoqgA/ykyNzv7a647e6CqwbhBznqjTEsn744KmjVN+x8nuPk/7s
ZIyaFXNlbPbYIMdwKBWOXSv1FpkntmdRKyl/mos2XeefB5JrvvDxztTDLtwcIHmL
jXnk8LBLQj0Z+wYkpCzIYOpJ+oaymJPi8VPQr7bc6r0cBquhRLYPckXSQZw6j9gJ
uiFdEudIM308CX9Cun9xrdX5fy4zmL3nlzFjdZHl1J/sPI7CtAHopNZjahwCCyKk
c8EizwXFVWXCEssYGv3IOsR0Hnuxo4HCba4BrLfOlTIAzLmZFQ2Y7yCxMZ4WQA+1
0xPPd2rX6wgLP7Sp+uvz
=+04K
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
