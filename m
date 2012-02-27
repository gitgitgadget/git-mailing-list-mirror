From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [RFC/PATCH] Make git-{pull,rebase} no-tracking message
 friendlier
Date: Mon, 27 Feb 2012 18:07:34 +0100
Message-ID: <1330362454.691.5.camel@centaur.lab.cmartin.tk>
References: <1330013115-26355-1-git-send-email-cmn@elego.de>
	 <7vhayh2t15.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-JcthIemsOykIwAg1QWV8"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 18:07:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S242h-0003ol-IC
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 18:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113Ab2B0RHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 12:07:11 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:33957 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197Ab2B0RHK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 12:07:10 -0500
Received: from [192.168.1.17] (brln-4db9ac75.pool.mediaWays.net [77.185.172.117])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 3032B46057;
	Mon, 27 Feb 2012 18:07:03 +0100 (CET)
In-Reply-To: <7vhayh2t15.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191630>


--=-JcthIemsOykIwAg1QWV8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-02-23 at 12:28 -0800, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > The current message is too long and at too low a level for anybody to
> > understand it if they don't know about the configuration format
> > already.
> >
> > Reformat it to show the commands a user would be expected to use,
> > instead of the contents of the configuration file.
> > ---
>=20
> Sounds like a change going in the right direction.  I am unsure if it is =
a
> good idea to remove "See git-config...", but otherwise I like the updated
> text much better.

We're already telling them to go look at the git-pull or git-rebase
manpages, where there's already a lot of information and adding another
RTFM seemed a bit unfriendly (and not that useful, as they'd be
manipulating the config via other commands and shouldn't need to care
about config that much)

>=20
> But of course I am not the target audience, so let's see what we hear fro=
m
> others.

Sure, I'll see if I can come up with some better wording and send a
signed-off patch.

   cmn



--=-JcthIemsOykIwAg1QWV8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPS7hWAAoJEHKRP1jG7ZzTW3MH/2mn8/nlJd9juv+hTVaospRA
gdf5I1G6YwKF15cPywiKEcoG13uyh9ZB+2IuPbKRNxgGZM9DXXViCUppMPm4aABM
WWWJtUh/PhtLT7PJli+Zv9jyECC5yf5Q7qFhC9RUwcbaKyrurgXhI1XAr5fRkslr
MbdYNfdFpGaO+xdk2xOCB8TmTPK6zT5n55Dun7AzbMpC4Kq0Hg/L5OXnmW2yvgCr
YhGr3XDg/qUu3WkQfauCxSrT/FUFQeNvtp+KBRAoXuUMLKhqxTYPMrc3kMpOLN8b
L5HsIgMuu3rlwOdOXelh5HWjVbSH+hpb3YBzo9lpnJ5OgXIpcFzRvKK9cRW499Q=
=sMA1
-----END PGP SIGNATURE-----

--=-JcthIemsOykIwAg1QWV8--
