From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] docs/git-mailinfo: Mention the manual separator (---)
Date: Tue, 30 Sep 2014 14:48:46 -0700
Message-ID: <20140930214846.GK3770@odin.tremily.us>
References: <28b04f1c17f2cc2fe252948bc0b7bb10df24b489.1411571629.git.wking@tremily.us>
 <xmqqiok4rew5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKy6e3LXpfmanBFM"
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 23:49:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZ5Hz-0000hq-1j
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 23:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbaI3Vsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 17:48:51 -0400
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:44530 "EHLO
	resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752965AbaI3Vss (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2014 17:48:48 -0400
Received: from resomta-po-06v.sys.comcast.net ([96.114.154.230])
	by resqmta-po-11v.sys.comcast.net with comcast
	id xZoh1o00B4yXVJQ01ZonFk; Tue, 30 Sep 2014 21:48:47 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by resomta-po-06v.sys.comcast.net with comcast
	id xZom1o00L152l3L01Zompp; Tue, 30 Sep 2014 21:48:47 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 55A7613DF174; Tue, 30 Sep 2014 14:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1412113726; bh=UprEAt0RAzqo1+KmWSMPTrPu8Dw7D9DQjJjddooeugc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Am/B2AbfKLNDVIFzHyiiAQG1vEdk7zXwRu41Bdrx9bGYa/EVZP8VXme8fxZ69mob1
	 grt2xZrilmz2KLgezh7xCfudCCWCo1nW0icK9fsBeed9tvUuq+yMYc5DruJP6UTaGz
	 a3ZIVHms2swY6Y0C7hezh4V5f4uzg75bjM7epQ5k=
Content-Disposition: inline
In-Reply-To: <xmqqiok4rew5.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1412113727;
	bh=VCObjagsmOvJVOa7NKfx9IrWX21seeIZkob1eLxtIuY=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=nPHcU7grWUDJBH7Z9z41wkpepY5ZeTzbriuwSybLG8Eg//mP8/AlmtLt0KHMQOgmX
	 EY7bFLjncNH6P858qi5c/Kj00cWfCdu54bRPqN//6Wo7fIwyoMuwp4muCbM6pbBEit
	 RgaMaDavroJFWhs5Jz5UR7tFKnhbyVZtXn49Ulw20yk+pI2d7LpIw9u7xKUIBWTYr7
	 XLGzBt9Sk94qQIbhUBYJrYXqgilfEwjocXRCra/hTzI91GwRJvM/7k7ewL3FfI9H2z
	 fKdqEY/LhfiATHrrwc7B6Mj5w83choosPtKYBELa87EbYTwKMmIxD8rJqxPmcOdfj3
	 UCZpqv+V6tDWQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257685>


--tKy6e3LXpfmanBFM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 02:12:58PM -0700, Junio C Hamano wrote:
> If we are extending the documentation on "---", =E2=80=A6

Ah, I see that the --- are actually mentioned already in the
DISCUSSION section of git-am(1) since 2499857b (git-am documentation:
describe what is taken from where, 2007-03-24).  I expected the docs
to be either in git-mailinfo(1) (since the code added by f0658cf2
(restrict the patch filtering, 2007-03-12) is in mailinfo) or to match
a grep for '---'.  Maybe we should drop this patch in favor of notes
in git-mailinfo(1) and git-format-patch(1) pointing folks at the
DISCUSSION section in git-am(1) and a more easily grepable =E2=80=9Cthree
dashes ('---')" in gi-am(1)?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--tKy6e3LXpfmanBFM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKyU7AAoJEG8/JgBt8ol8an4P/0saJM834othoBhnpre6qj5a
HPPlGpVeMyWnTdVh2LYHoRjWX9s8/mjPQfi0hoK4nUEAAJ7b/sC7TPY/UaS7edfm
jvgXmDzW1EcVCFzNTa0txewc/yYFoAdXHpnfZiAkvAo+E0Flxt98YcA2kCh8nFtN
z5vsVBkDkgmG5kGVKc3+rr2LAwmIm6WQu2cB7Gmls1CzShzgddGvjFdA3x0GEW31
CbTqR1rHdmZ/6fE3BGU8oWci+kd3LdNUlwkKnsLMkMTWcrwd9GqUvnvvUANQ5MRs
oTlM7KoXKMj5xRYWOLqQPQTYXbr7n7u9wNLOoa4ltd0UCrErRpvJZmhUjp0TojIk
x42mqOGIRqvLJRHI6nH5Em4VgiBSynQy45LqVv4QiJNjnrYBdHsSCKJwODsAXJ7v
J38aJg3+GXsNQTQGI1sx3c40xroTZyld9R/RkiCyba3TagX8hVWj6vTtBELrapo+
T2o1C3CKuUIci34lLrGh5RKJM8esQfQbdRxwyUcal7QzUwQwVyIU28eeFYSv+46C
7UOFlKeFcWKM0fzF0ROISBqpZJQy10xoW5pHgqhTqVhBJdy13ux0yCzJESl7fHrd
KLDY+ZFQQiWDtEdCip15qpf9kG/dPgJPseRFY21rR7Od1P6Fkd+TghZkpmU7MMrd
TqUKm9oRUZXoJjJhSDEB
=5Ft9
-----END PGP SIGNATURE-----

--tKy6e3LXpfmanBFM--
