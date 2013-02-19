From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 1/3] user-manual: Reorganize the reroll sections,
 adding 'git rebase -i'
Date: Tue, 19 Feb 2013 13:51:19 -0500
Message-ID: <20130219185119.GD8170@odin.tremily.us>
References: <20130219093429.GA4024@odin.tremily.us>
 <cover.1361267945.git.wking@tremily.us>
 <e9f8a25c05f9cfe89c6bcbefb69f40cd629f9925.1361267945.git.wking@tremily.us>
 <7vwqu45efr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=0H629O+sVkh21xTi
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 19:52:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7sIq-0001tv-Ns
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 19:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934071Ab3BSSv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 13:51:29 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:40997 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933985Ab3BSSv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 13:51:27 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIH008BQDPJWS10@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 19 Feb 2013 12:51:20 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 395508AC35F; Tue,
 19 Feb 2013 13:51:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361299879; bh=0euXdI7Xusg+6XZQ5fkmHxmjIMFPUe+PBrIHTCIkvqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c/WmhhXNnmCYU8a+9hnD9XwsMUVKvw3ykMFySF8dsBmNLmoKv3OS+Lgl2PKozf5HM
 m4Olfadl80sPA3zEgzVQEWE9QlCilSSP6ZREg/qiSnN1oCB/T6DQfEYb+EQvgkWdD7
 DzH7pyN5GDwQ1iXq79avZ9r77q7lLzk/t3mqXbVE=
Content-disposition: inline
In-reply-to: <7vwqu45efr.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216645>


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2013 at 10:47:04AM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> > +Sometimes you want to edit a commit deeper in your history.  One
> > +approach is to use `git format-patch` to create a series of patches,
> > +then reset the state to before the patches:
> > =20
> >  -------------------------------------------------
> > +$ git format-patch origin
> > +$ git reset --hard origin
> >  -------------------------------------------------
>=20
> Technically speaking, this does not "reset to before the patches".
> You would need "git reset --hard $(git merge-base origin HEAD)" or
> something like that.

They'll be fine if they haven't fetched since they started their
branch ;).

It does look like I've got an extra comma an a missing =E2=80=9Cand=E2=80=
=9D.  What
about:

  =E2=80=A6create series of patches and then reset=E2=80=A6

Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRI8mmAAoJEEUbTsx0l5OMg6gP/jcZ7FIWFZfN8wl98a2m+GaL
orVpunV8Zk6asbPASXVpJ8EUPM+9rMvjrV1IaU+ueD3z9/p0KEKHMBukmX0neuDd
gxDbXIqZDlYfvq2xO5cKvwyy2SMFleTTqdC8JhUDzRGPbKuNGzsVugh/8/mx7joM
hmCEm0Cu4IOzD+tqMMWMkwJQ9MQvY3Jh+4tR1D5FCBi3EHPktEzr+Pf2AAS6r9+F
hIAhwpEmDcktoO5DCIKo8OXRAdw1PJT0vLZgtU+uUbSOWK7t7zTplBfQZU3INShZ
SBgsnQv5ZX/GiAmnWTTqMh3gDG7msLQjygEyZRzU9ZVYQAd8U3IKXDQNGOcAt0Jf
5Rc/I060dvAOwGZ1MCXwLYhNqGU7e9G1mYbyIjS53310QetEEVjMZpyeaHTfIdfP
3enIRHb+z2WZbURTcHFbYYOSSz/yyIFANnx7nbVFeZJlX5M0E9zqmrw98KyaxKY5
bCT3dWxgMFjk8eWYVU4ewjU/zYOrmGaIzoD45gvgPpfGytmrxRafKP54eAZr/b7K
XVYa+ja/tgFv7MXI9imPB8peclSDi9wStBtVuWk8WU6pa8E0XvA/BuiVPQ7Bet1p
YKM1Dy3nYsbQ6PUY5IPst8HqQWtGckhL4fVT2qzVh+zBF4t5GbOtwmwE50ika1BH
WjSPguXo0JNi7B/d3n/5
=aCzJ
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
