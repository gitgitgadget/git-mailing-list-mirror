From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v6 1/7] pull: rename pull.rebase to pull.mode
Date: Fri, 2 May 2014 07:13:59 -0700
Message-ID: <20140502141359.GE28634@odin.tremily.us>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
 <1398988808-29678-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 16:14:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgEE6-0004LI-6Z
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 16:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbaEBOOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 10:14:05 -0400
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:48636
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751318AbaEBOOE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 10:14:04 -0400
Received: from omta21.westchester.pa.mail.comcast.net ([76.96.62.72])
	by qmta05.westchester.pa.mail.comcast.net with comcast
	id wzKr1n0021ZXKqc552E2iX; Fri, 02 May 2014 14:14:02 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta21.westchester.pa.mail.comcast.net with comcast
	id x2E01n00J152l3L3h2E1ea; Fri, 02 May 2014 14:14:02 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 67CFA1174034; Fri,  2 May 2014 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1399040039; bh=PhvjsG6Ztj2xB23zyZZZvJ5gauvDr5QEPqWXe9CO9tU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oWEGzaCOMGsNMCxqirBBkK+ZyTgHMeKNFt6B/8CxkFCXgGtm3uewth0CSfci46wuf
	 S2NgPYB9PIr+nTUwuGjLwDXmGjAgh+/qGWGjJ8PzPEeD+Mcy/AaoLgW54EKRisXs1O
	 fVB1u5A/e495iLCyIR3MXcs1YnwuilNMNw5PvsMA=
Content-Disposition: inline
In-Reply-To: <1398988808-29678-2-git-send-email-felipe.contreras@gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1399040042;
	bh=0D+4qkw7vgEJolg3lvY73femIkmFDJASCnnNU312Qgg=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=YHjI7EVP2lXGlA4aOrAodEuBh71stHOvPPcvQ2IsICJxgvME9hJjmOwh3zjWK7dyG
	 kMufTky+4Z69TwbiKaK4Hchgg+pGlPNvEwl8BoP4f3B7veptL//S+AoB5koOOe9GZK
	 WLi+3rddOsJ6nA8jIWM7oEPEpLVfZd3dIrnCd6oxCmdtEaCt8RQdVRo5pcrhanwhz/
	 FRYkkx901sVy/ArB4Hrp9OHBeCx7wd4eoIc2YgX904FqJ1MAfxg+NDnzZ55mlUU7bJ
	 dPo8dQoWC96ipnU5paXHXJo30gbE2CJFqj12rfn/oG5BAATm/lzpkOZUh54PdbiTgR
	 tySEB9ucyajvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247934>


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 07:00:02PM -0500, Felipe Contreras wrote:
> Also 'branch.<name>.rebase' to 'branch.<name>.pullmode'.

Perhaps this has already been hashed out in a previous version of this
series, but we may want to use pull.update and branch.<name>.update to
match the existing submodule.<name>.update.  Both settings are
selecting the default integration style between HEAD and some other
reference (pull's remote branch, the gitlinked commit, or the
submodule's --remote branch).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTY6gkAAoJEKKfehoaNkbt41MP/3dHLprKV83mSrXh0KWQ8PyS
PqSj/4oXZ2j70slGktpMn2HuHqNlxt24oBorVemynK9bUttaez86QQrWJohqQ9Jc
bGeM87nOHHyw8il6oUoCyWbO6E3NPWV1HG+bgXVanqpigBFYAkk4BSPjCNLIfxFZ
LuYb/AtDB6IHykbzdP6HU6i9Nujw3mWu0lfv4z0Lb8MX8p2brjBzjOiTJEZ9QRgD
crAf3KAmqexg2evv0h43oyHnsvYvK5WlPlQ7hZ/wsjmL5aEYW1mG7bnVJ+cH+cig
suW3PktqQWXr1NHRk4EttJKsOGqKXw0N327+l3a+4lJahOpGXRielz1qLIjC4+Ou
5rZh0hUZPbCW6GklBaQHmM3BjCUtcTqvrprvE6oXWTGBK8asfKsn8/1G9KaEUyY8
ZjwZxuFBGv+3vmmCm3wBU9QMJD0bwcRVkO6oD3NOkSDnLMpqItMXLcS+g5XxqfJe
o332sgCdLm3LVGWwFePaUtO9kD3ple7snAsgPqrEoGzV5LZeO7uPngSRRMjDmQx+
qMXQadx4VXHxSzkl9/p8MrDZUvQONU9+rtjYSzaCv+8Jk7+vJzjOGw9pML5pzx5e
2gO0HVayFdBJYDEy2CnDHSK0rVW6j6sznmbh81PqwqSja2WyPf4tNXBS90212x9e
uPikl00iyvhj8qN0AI+p
=c89O
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--
