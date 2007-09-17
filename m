From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: commit summary, --pretty=short and other tools
Date: Tue, 18 Sep 2007 01:52:21 +0200
Message-ID: <55887C88-8523-4839-8B91-236256A5E893@lrde.epita.fr>
References: <20070917112136.GA30201@glandium.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-65--834939819"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 01:52:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXQOU-0007Mr-8z
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 01:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079AbXIQXwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 19:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756119AbXIQXwm
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 19:52:42 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:38539 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079AbXIQXwl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 19:52:41 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IXQOO-0006VA-7I; Tue, 18 Sep 2007 01:52:40 +0200
In-Reply-To: <20070917112136.GA30201@glandium.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58501>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-65--834939819
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed

On Sep 17, 2007, at 1:21 PM, Mike Hommey wrote:

> Hi,
>
> I kind of shot myself in the foot with how to type proper commit
> messages.
>
> The git-commit manual page reads:
>   Though not required, it=B4s a good idea to begin the commit message =20=

> with a
>   single short (less than 50 character) line summarizing the change,
>   followed by a blank line and then a more thorough description.
>
> ... and I happen to not have done the "followed by a blank line" part.
>
[...]
> What do you think ?

I started using Git as a "better SVN client" and didn't follow this =20
"good idea".  The thing, as I already pointed out on IRC, these a are =20=

more rules than just guidelines.  Some tools (such as rebase) enforce =20=

them.  That is, they rewrite commit messages.  I found this extremely =20=

annoying (Junio provided a patch but I don't know whether it's been =20
applied, I personally use it in my Git).

See this thread: http://marc.info/?t=3D118561729500001&r=3D1&w=3D2

My opinion is that it would be better to keep the first line and =20
never ever rewrite the commit messages.

Cheers,

--=20
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-65--834939819
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFG7xM1wwE67wC8PUkRAoCQAKCy9GX2X5mCJwdm+O7WSIUvUnvgFQCdE2k3
Q62VGCF8l05B/1lZw3U4CSY=
=oL1B
-----END PGP SIGNATURE-----

--Apple-Mail-65--834939819--
