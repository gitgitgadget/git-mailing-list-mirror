From: "W. Trevor King" <wking@tremily.us>
Subject: Re: What's cooking in git.git (Apr 2014, #03; Fri, 11)
Date: Thu, 17 Apr 2014 09:52:47 -0700
Message-ID: <20140417165247.GQ21805@odin.tremily.us>
References: <xmqq1tx3qzel.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8kRBn33jkh2Wtq5"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 18:52:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WapYV-000860-HK
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 18:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbaDQQwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 12:52:51 -0400
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:40232
	"EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751110AbaDQQwu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2014 12:52:50 -0400
Received: from omta22.westchester.pa.mail.comcast.net ([76.96.62.73])
	by qmta14.westchester.pa.mail.comcast.net with comcast
	id r0Yp1n0011ap0As5E4spMx; Thu, 17 Apr 2014 16:52:49 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta22.westchester.pa.mail.comcast.net with comcast
	id r4so1n00W152l3L3i4soy7; Thu, 17 Apr 2014 16:52:49 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 0B8E6115102F; Thu, 17 Apr 2014 09:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1397753568; bh=cy1kJ4WLRkd6vXs9jffSAvfT84baLl1CIT++yJqW4Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cJCDoGNhC2apOfeXn7Snasu9qjjWOJSMsA/dWfKjaOQl8HSL878/t6sLD/GzgIWh1
	 qkNoYslTv4klReP3jKUS/mBwGf2MPXlzFPsB/VydNol9ruht/UhX2Fe975lPOsyMkA
	 POL63dH4vq0YNhS85xNwEo72AfvB7QELwIIj3DIg=
Content-Disposition: inline
In-Reply-To: <xmqq1tx3qzel.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1397753569;
	bh=qqxanFcxBshW/Q5BU6uJPbPW+gseMHpofF22pgoZpWg=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=PmsB/+dwEF4pQoQ30h2q8bsSv+4ApPApaoAxLxQfQWxdM4leqzWDuBuMKusVJT0Nj
	 MD3VNV5wiU7B5yv6TO9u8rml2D3mpJUN/6Gkzlz/pwOasq1JwVsk7M8HRnC3eD+vl0
	 yqqt3YTwmGeyrlZ9jWRceJ9gt4Ry7+T6xA9ETy1JEcl1Wd+T6vSvzH5l8sYjjU/d9p
	 ssDXdFL187wlKmXOjega7qiOkf9IiDYH51/yFlTKJEtyfQMsFYIbUC1CXBi3JSr3+P
	 jm70Hu5GGsMv/8E1cFPN6Rh9e/TRCyrMx9TrFOF2kAWa20p786VjD9uojpi/471dHk
	 G+mGQxW4QXs2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246422>


--a8kRBn33jkh2Wtq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2014 at 03:22:58PM -0700, Junio C Hamano wrote:
> * jl/submodule-recursive-checkout (2013-12-26) 5 commits
>  - Teach checkout to recursively checkout submodules
>  - submodule: teach unpack_trees() to update submodules
>  - submodule: teach unpack_trees() to repopulate submodules
>  - submodule: teach unpack_trees() to remove submodule contents
>  - submodule: prepare for recursive checkout of submodules
>=20
>  Expecting a reroll.

I think this was rerolled with Jens' v2 [1]:

  * jl/submodule-recursive-checkout (2014-02-03) 9 commits
  - submodule: prepare for recursive checkout of submodules
  - Teach reset the --[no-]recurse-submodules option
  - Teach checkout the --[no-]recurse-submodules option
  - Teach merge the --[no-]recurse-submodules option
  - Teach bisect--helper the --[no-]recurse-submodules option
  - Teach bisect the --[no-]recurse-submodules option
  - submodule: teach unpack_trees() to remove submodule contents
  - submodule: teach unpack_trees() to repopulate submodules
  - submodule: teach unpack_trees() to update submodules

Cheers,
Trevor

[1]: http://thread.gmane.org/gmane.comp.version-control.git/241455

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--a8kRBn33jkh2Wtq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUAbeAAoJEKKfehoaNkbtZKIQAJFzJ9BE099xYT2GWtpNykQa
bl98ElBYeCW8v4kuYFg3DbSZeiFJJMjZC5biQJvlYtI5NzGBHlHcaG2sgfz/iGDO
iLN27jpfpBmrNPznnaJ/G6jw7JU7tEPkPnePRbuAifDe6F43Clfo37DcsYDLyb9M
iXDxYjY+11LsPaYMHf4Qo2EhnPaHy5SoVfjzfvTfAdBAUyCvmIgYKkUueOxGhIbQ
77+/aA54k4bWLfduDKaPGcLcL1LrDQDauH5fqxDitJs7URiwlm1qQKrc/OZ2Dbaz
RM5+rBdmCfG9cRUHBeAeJsWLF8yfSPDjRBZf48cGQe2Wa17WK4n/d0AGAVvBW6iq
Dx0Pim8dj0zgXHrtSRMykBm+geWI7R7yjIg03VL8l4Lrno3DlTAIYodT8zCzfWBi
YxW3dxhTeS5POxHJpJP6tC8KssfBRm0wK7JQBKXpkancyLxQHfJI3WIur4lbDwBR
rMdUt73dlU9Iw384abZVNAlk76FuolaTH36JMVAkFSkOdc4D4XRxFdNucPnzyFWx
s5FsvCq0DsMzHiizHr62aZseETxzlVRBDuGs0E8hqoWySe0fXPkhkiG1FmxxnqHX
P2XxF8NVA0HXMbc3YKJdion5zlBrbktLsDgxwgD29TtLs9h05pVthlCJyEjhZaNB
UsDgeGjbplVFOnYpAaIF
=TRAa
-----END PGP SIGNATURE-----

--a8kRBn33jkh2Wtq5--
