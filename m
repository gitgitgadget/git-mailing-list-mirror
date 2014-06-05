From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Submodules with feature branches
Date: Thu, 5 Jun 2014 09:23:33 -0700
Message-ID: <20140605162333.GR21803@odin.tremily.us>
References: <CAHd499Bn7CCVy=vhFzpLYXCssxR0oGxm3Vdgou_Yk5zSt1gfmA@mail.gmail.com>
 <20140605151549.GQ21803@odin.tremily.us>
 <CAHd499Dc7_fob2-X1KZ77sdx20r+erQ_9JbDc7y4G0RUxG65eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y2MHPAl/EzyWgzIZ"
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 18:23:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsaS5-0004Zq-E2
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 18:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbaFEQXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 12:23:37 -0400
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:60129
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751220AbaFEQXg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2014 12:23:36 -0400
Received: from omta03.westchester.pa.mail.comcast.net ([76.96.62.27])
	by qmta09.westchester.pa.mail.comcast.net with comcast
	id Ag461o0030bG4ec59gPcZe; Thu, 05 Jun 2014 16:23:36 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta03.westchester.pa.mail.comcast.net with comcast
	id AgPa1o00d152l3L3PgPb9Z; Thu, 05 Jun 2014 16:23:36 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id CE00F120A3F9; Thu,  5 Jun 2014 09:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1401985413; bh=cNf5xDKcnNmBw3ztEYXglrFDi3Zj9qdFfLsv3Phbosk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RgvGCDDF79xPN5t/Tbdg0oXLN/GZCVNj+wYYuBKWmrryagCKyPQz5rkdbdKbwSYLb
	 yz25vcb92xQzFw8ASWbQ2/FZdtXehOIv5VXxGyQy+/kbcXUo1AVcD2XtlCGpsFrH0p
	 jh2n//D6wjQHKzNQDozVdsBX3pO18O4BWA9nuVSo=
Content-Disposition: inline
In-Reply-To: <CAHd499Dc7_fob2-X1KZ77sdx20r+erQ_9JbDc7y4G0RUxG65eg@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1401985416;
	bh=/v82mVZ+9tHcpHZ5dQ62iT/nfq3pZU+EA4FWV9CiMP8=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=n7hmrtkdS2FvqZNG0iPyjetBrVKfEWXzDqfNmNJjZRtl7sdtJaAvzSfbtJl7QkiNx
	 ROFRj/SB+xBh2xoNIppC7fpg0jzKYgnBy310GuTCyfowr5yAnM27Bpnj1KwXt9mHMx
	 BQpvVrZ8aAYQuUzK/BXxRh5PDL+cAwAUdeh25Hqdo2jlabONvxgkB+7PIZaSD9Kz58
	 2Z0WcuMuHUqpk+diV3ODUXI80LqkKyjBykGJ5IIhSJY3Jo5dFM0NXPwUeyE5LBV+ym
	 OjeEoYjmH4DY/QA15wbQS50Cxofs4R8dpgIC4pNhPQcke2yoYtiHIKoiLXxvEEJysf
	 RCrSP/MO5Xhzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250849>


--y2MHPAl/EzyWgzIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2014 at 10:57:17AM -0500, Robert Dailey wrote:
> I was planning on creating a submodule for our third party libs and
> store them extracted in there.

3rd party libraries sound loosely-coupled to me ;).  In one of my more
mature projects I did a similar thing, and just used relative URLs [1]
and sibling mirrors/forks [2,3,4].

Cheers,
Trevor

[1]: https://github.com/wking/pygrader/blob/master/.gitmodules
[2]: https://github.com/wking/pgp-mime
[3]: https://github.com/wking/pyassuan
[4]: https://github.com/wking/jinja2

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--y2MHPAl/EzyWgzIZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkJmFAAoJEG8/JgBt8ol8ExwP/A8iybYde8Pw+S5+8xIz/oeq
O/n14BBBdDm8/yRSRSFtucyl0JjAm5s7gthFWP9Xe9alPh8/ol8u51uviB8XUapF
W0OEkokMkrVTACSwRL8INZJHGLtWWW9Wg8i0QpFbG2F3yLG/vjzBTHP+d/S3oe/V
AoK6Yn3GNyFsADXSJ64PsE6UZWIOHY8sUEyQT8UnaBbGzQP3G5oiB9XyfjKR3lB2
cdcWS6s1HWxL1lbCxJK9ZdxuFvpEs60/bAYuNYIZ5gG6LycEySMUyaatCfGzvWee
DuIE5nX/YSolJshLXiksJO4AMe8NAgfc0882GAEsMlfjE5Wn8vH31js0xyAW+jpI
I4cCgfhi6wsYd80c6dG4JE9JrSsT3xpztZOsIoPnhUdDO4yGFbk/7v7rSucGA+b/
NaeEoM4DixwHqtb5wd1E8on/ze9MF4cx152sHbiDQHxbd4V2ii9a0nZD8KgZ/mfZ
jL9gEcTroJCdBsU8MxJu9SYQ/TC+ypGma5jMfBmzQhtqMrDbooGa/eHUad4zMJtu
39jFzKu+BuGgMyd2T3LNqVQsZX8lAcARHVl+DCInwUp7GBLTtdFfOY3RhHMuSH4a
E3qhGn9PAK1YwYRpFlnkAQM0rfP/J7OO0fQrVj9CPM3yQSgO00puyP0w1Utu8rCP
yHpPaNurTQKX4+ti9HYc
=pv2w
-----END PGP SIGNATURE-----

--y2MHPAl/EzyWgzIZ--
