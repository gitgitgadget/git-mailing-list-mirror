From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 6/6] Documentation: Describe 'submodule update' modes
 in detail
Date: Thu, 16 Jan 2014 13:16:52 -0800
Message-ID: <20140116211652.GA2647@odin.tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
 <4a8dca477ed5b190767d6a4619c593a83f86f082.1389837412.git.wking@tremily.us>
 <xmqqeh47znin.fsf@gitster.dls.corp.google.com>
 <20140116205521.GY2647@odin.tremily.us>
 <20140116210222.GG7608@serenity.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GXk5ufetu984H6pr"
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 16 22:17:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3uJA-00052W-JO
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 22:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbaAPVQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 16:16:57 -0500
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:37392
	"EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750750AbaAPVQz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 16:16:55 -0500
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta13.westchester.pa.mail.comcast.net with comcast
	id Ee0v1n00227AodY5DlGu6j; Thu, 16 Jan 2014 21:16:54 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id ElGt1n006152l3L3flGt4P; Thu, 16 Jan 2014 21:16:54 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id C2782EFF359; Thu, 16 Jan 2014 13:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389907012; bh=5V6TXvIrqw3GenZhk3YjKCM71lTF/GqPHT4SMfuiZMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=La3JlT+DWq+i5kazWMvuBQrKaiTtT3iQnJsmp1gUZfGKKJauCzcb5so7rP6H+pgmw
	 oUUOLSMtjyLhfa6jDyfX8T3azfzorumDiaQM/E5cDk3HYupD0levH69igx+aydV/+m
	 4WGNBBxdXuBJ6sz3/1GD++URkOo772OUio8xUiBo=
Content-Disposition: inline
In-Reply-To: <20140116210222.GG7608@serenity.lan>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389907014;
	bh=RT9Fk1EsykyPDqFh1y+9PGng/76XsHchl1fxXu7VkPI=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=DWtieHnfsO60dTFAKlyitI7zIHWwRGAHVrgkTMHEP4GRiNoLeQAOpjO4XfVyhwG0Z
	 5aLBPpGQhwTtgZgz7lzmHwtoXFRnYmxX46qis0tSY8lF/RnYbUdMIYeA8EKyUmvxUt
	 AO/J7otDa2G/+cEkvALwo6Sq4RSVWPvNOdfcatPgHFx70WEaq/xhmFm8UhEyYJ2Vrp
	 wLR29hBvcw3d+hnf73daXM2bYuyubvA6Emnyd6czUoE94LIq2mZPtBwbWLRLgZPDTs
	 0lHdfvYu7aNPbysH3rYmbX6vN4Q9dpLVf6BZS3pKx+dxZquyWaUN2GH9NFqokGGyHN
	 hcA7fkcFkqjyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240536>


--GXk5ufetu984H6pr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 09:02:22PM +0000, John Keeping wrote:
> On Thu, Jan 16, 2014 at 12:55:21PM -0800, W. Trevor King wrote:
> > On Thu, Jan 16, 2014 at 12:21:04PM -0800, Junio C Hamano wrote:
> > > Not '--checkout'?
> >=20
> > Oops, will fix in v5.
>=20
> Shouldn't this also be `--checkout` (backticks), according to
> CodingGuidelines.  This applies to all this options in this patch I
> think.

I can change that too.  The existing content is inconsistent between
backticks and single quotes, but I see no mention of single quotes in
CodingGuidelines.  Thanks for the reference.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--GXk5ufetu984H6pr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2ExDAAoJEKKfehoaNkbtfJcQAJ94XPDHU6YVUntdd3JUEM9A
KlPtbwijQIdEW6PTelpI8j3YnmDFAJ3aU1ze4K5qL8EocL1JlV7iJ/tEuQpyjHcu
u/5al+WzDjKgu5apyuGh6XyV7DvzfEzg0golTilq9gQ42FU7wncvxd8WGbSYiE86
8+tqi9vfaKAGdQoTpj2N7hbA49k/2YV9xlJmFeCcOxcvcCRS1pOjBrmXUhsdrsPd
mi4PODH1rAoM3IC5ayyH66VHL0lXBEioL5BrKMVuUa4pHKmtWW5TjGdG0MPmipVv
/zclOBOSo21UzmayabDQquWW6S/7NGrezuwyf06pPe/Empw9AKfelEZgaFD15T1M
UJ6g3lAUpdvEUpvtg3kkKPoWE30yre62jalbOiDlddfprYzHGv7rOIuJE+ZFq0BM
lbIFD2lD5XyRMR3X31PHavEmI5GsRpopSiNQhUPeLmTUIcC24sgawigahMgzZbH9
e1eJM9l6HDNxQsihxE9OWQmLsM6SWzANIQ60NWIcD3YPleqPfj7/zmOJvUfLq+Cq
ydkl1OsaQHKuqIfL6YwJLDtAfqqORTzW8txZiPhQnRbS67gAxB5wYHV2eVPRU43K
mio01Ljy2R2OxJW/HBl3/XVogy0pfuFr22mi4w6yfqSPSRW9JX3wU9vVhHiOS0TH
VY6hHGhXgQW9EZF44V3Q
=kmMB
-----END PGP SIGNATURE-----

--GXk5ufetu984H6pr--
