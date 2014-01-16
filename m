From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 6/6] Documentation: Describe 'submodule update' modes
 in detail
Date: Thu, 16 Jan 2014 14:35:19 -0800
Message-ID: <20140116223519.GB2647@odin.tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
 <4a8dca477ed5b190767d6a4619c593a83f86f082.1389837412.git.wking@tremily.us>
 <xmqqeh47znin.fsf@gitster.dls.corp.google.com>
 <777D3478B53C4A3F8B4326A96B3F048E@PhilipOakley>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GlsaLUDw2IYctviq"
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Jan 16 23:35:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3vX5-0000Lo-He
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 23:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbaAPWfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 17:35:24 -0500
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:38821
	"EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751310AbaAPWfW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 17:35:22 -0500
Received: from omta16.westchester.pa.mail.comcast.net ([76.96.62.88])
	by qmta13.westchester.pa.mail.comcast.net with comcast
	id Ek7p1n0061uE5Es5DmbMGZ; Thu, 16 Jan 2014 22:35:21 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta16.westchester.pa.mail.comcast.net with comcast
	id EmbL1n004152l3L3cmbL4z; Thu, 16 Jan 2014 22:35:21 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 98780EFF4D9; Thu, 16 Jan 2014 14:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389911719; bh=+7UV0abytEI7cKXp8oBNoGO9MjI1ti+KoyXxezHP7/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nQW564LZoi/ZlKhO6bDWVnblGXczWsu6WY8scAmM7Viu+7kQZFSZY9+gL6PSdGtrH
	 Cmok91YytwUW3cjv5hqpPRt4Sdom2quX3YTi6B+HosjLOvH6e0zwfkc7cjwglyzPOc
	 QTHRx6X7k3YCXsqDYR607HfWqDTleIN8YgFNP56c=
Content-Disposition: inline
In-Reply-To: <777D3478B53C4A3F8B4326A96B3F048E@PhilipOakley>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389911721;
	bh=CF2IKDOtmADJFmKVzZI/YleKKj24b8CFzw42it5Rpz8=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=DzaOcnunvpphOAWtsKkV9ANyfj7NWsOx80COVFtYzv62aoI7MMe2NOVoVGuf48TfF
	 t4Pq2O3zGJo9yzc0lKOI/acOIA3UjQedBXHzJFfFsFAJ/VQMX49UmJx9kZYYtsema6
	 AS2e4sIwa6jK6NhyvAhlSB4rkUR9LdtQWHvMjsYGNrsWoWqt/pnEkFiV10eO4Q56/o
	 8lR09DiJqOeFeb3rSGQguEnT3GnRzoY/1YZgAsjWIk3YOdQMs4PLogQHwxnrbML1fX
	 luxEyBxiu3UYUHm30HD2ZkuTHngbTNIJfk/PV7sfUShg+xmY9gCcfiQIlVrVL4Ti25
	 1RG86Fa8XQ+5w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240543>


--GlsaLUDw2IYctviq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 10:18:06PM -0000, Philip Oakley wrote:
> From: "Junio C Hamano" <gitster@pobox.com>
> > "W. Trevor King" <wking@tremily.us> writes:
> >> + repository.  The update mode defaults to 'checkout', but be
>=20
> nit:   s/but be/but can be/  ?

Thanks.  Queuing for v5.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--GlsaLUDw2IYctviq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2F6kAAoJEKKfehoaNkbtXGgP/AlrqMTRKfBIZ5bjcqGlRZti
H1uitZDDtzPxOdf9Nj//7aLTr74BBDq8otBy+WhqKSJdpWDeFojiQCXWSB9zjdae
OvzRnErOwI7ot5Bzqd7SCRNVC4oNmsoFepQt+3k+p42zB8hqljmk0VrL7ak+UYKT
IImuUFHBZr3uvrmfAIMxPdxiNcY5LWQ6qTfBHRT/cppJ2Rm5t+cHs7yqTN2JJAAj
7WdCpQI9lqBJ8AthyMrZ9dOdd0avHlPaActdSk1RrSwDIfk8oY0ihugHzQWsNA6v
bKcPtLc69wARFvR1KphYj1tKyvY9FeC5DNYqR5fWHqLvOI5couDbFHoKoPfpdlRK
zvwqJEb2E6zrkahoTkvIVODGn38ksVDeCzXgqVbJFJ9AtsQ0EbiibvRXl3V80iV8
omNjBz9oAs8XhbpbajIaGrEk4g13QdkHfpJa3qrmA2Px7FFzjlYLKSdJxJibPp6x
u46vWDLVgH3UoB2794qEqLpRyOEJAT/HtQlsdoWEaSEYmtO8TZbbDdNzwSddAgi3
Fw9i4StcWTgzdxhnr8yW1m+Dzb0qx3c9PpaxOESRz/mRbHxmQufH+8XAWPenrXtx
fgt6DE9FQzGUGNkgZzGgx/8kvdnoAFA/2r2WiYaeh1gU1iYrV6xIgvfOo5OlFyUx
BefsctnC70h4OS20JKdv
=nbKM
-----END PGP SIGNATURE-----

--GlsaLUDw2IYctviq--
