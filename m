From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Wed, 8 Jan 2014 16:23:28 -0800
Message-ID: <20140109002328.GN29954@odin.tremily.us>
References: <20140106160202.GE27265@t2784.greatnet.de>
 <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
 <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
 <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com>
 <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
 <20140107194503.GA26583@odin.tremily.us>
 <20140107223858.GB10782@sandbox-ub>
 <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com>
 <20140108010504.GE26583@odin.tremily.us>
 <CALas-iiX1=LAJQ_LsayhxB2zQTYVd5jxpVvOLOpdgHBW10ci1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qyHYMwAXsHLOQihY"
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 09 01:23:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W13PO-0002L9-6M
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 01:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881AbaAIAXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 19:23:33 -0500
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:54058
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750839AbaAIAXc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jan 2014 19:23:32 -0500
Received: from omta23.westchester.pa.mail.comcast.net ([76.96.62.74])
	by qmta09.westchester.pa.mail.comcast.net with comcast
	id BZeq1n0031c6gX859cPXh6; Thu, 09 Jan 2014 00:23:31 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta23.westchester.pa.mail.comcast.net with comcast
	id BcPV1n00c152l3L3jcPWdL; Thu, 09 Jan 2014 00:23:31 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id EE103EB4448; Wed,  8 Jan 2014 16:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389227008; bh=SK4kjU46nUyU6G8JbXmpoQs0npXoKDlsCD9v822mPkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=o14vUm8mJLyyoHT8lVoiY0cEJlJ2YU2+Vcw7BUuMM6Pe6S9FgJN9zR5Merr2xUns1
	 12cNsyD0MPVpJagmU3LvjZyzv896FOaB7JOmkuT3HJ99l8m5IHqLKj3Z447V7LWKwX
	 cjeJ2d+S46AlxqPqGsxBFxEOrDsZsWED3yHdEiVU=
Content-Disposition: inline
In-Reply-To: <CALas-iiX1=LAJQ_LsayhxB2zQTYVd5jxpVvOLOpdgHBW10ci1A@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389227011;
	bh=UQBvVqoF9Sv9Su1YvNTX+SGWyRFM6wUITYggiyqLIGg=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=osqi4WDUE3IPwGdmDuH5/KA8k5G6YzbGuqPoLZS2gbyk60Cq5MxAvUEF/oXUU/3C6
	 +oeKcuMRH43sKcnYXN2+wuqWzw2IasjDZyVOYfcxSEu4p2oJMpyVWcgkQrKiCM+ATM
	 iPCQn5+mFVUn7qX9sl7GMKUhksPhK1zeVmJl8vKOF1ii36dOAiGBuMRX9vXHdUQxNX
	 a01wgqfPm9sbjy1XNVnjVbEq1J0xP9Y7tm+NewLt6tVuCb+5Nqs1KiF6PK2p0fht7a
	 SW4q8RueRBxsbYOkKjhWH3Wx1pRjuwP4xrDfXdRNdrIkNMMSJoFzcrw7b98YvJnhrQ
	 6O1w6f6jlSmiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240233>


--qyHYMwAXsHLOQihY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2014 at 12:54:54AM +0100, Francesco Pretto wrote:
> 2) Having 'git checkout', 'git checkout --recurse-submodules' and
> finally 'git submodule checkout' is too much for me.

Agreed.  Since 'git checkout' already exists and 'git checkout
--recurse-submodules' is close [1,2], I think that means we should
drop this and start arguing about adjusting 'git checkout
--recurse-submodules' to checkout branches as well ;).

> Also, in my proposal, 'git submodule [tobedecided] --attach' would
> also merge orphaned commits by default, and 'checkout' is not about
> merge.

And that's good.  Bailing with =E2=80=9Cyou have orphaned commits, which you
should integrate them with $some_integration_command before checking
out a different branch=E2=80=9D is better than having overlapping
responsibilities between the checkout command and the integration
command.

Cheers,
Trevor

[1]: http://thread.gmane.org/gmane.comp.version-control.git/239695
[2]: http://article.gmane.org/gmane.comp.version-control.git/240117

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--qyHYMwAXsHLOQihY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzev/AAoJEKKfehoaNkbtwZcP/RX9vNvt2iYZAQBjKwGy4J0I
jplveH8L1W/eAP4pQBHgqCXm08BiBxwtEKbP7h87tig1L7biO0rCnaeyr8reublt
v1DOPkNwmEfFYteoY7PZzwo+EYSPEA3a+TIWeqZFAY5d4ANkTMQLeuW+TWCsZ7xQ
q29zrQa+ZwSvVHRdlDCeIymnkob7TttIhOR6i5nmAmZVmeuISvztW/m4Yt5kgDbd
73y/Oihdg9mfdSK/Adi9q7CEJnbUeuLxL5WFcrYatqP37nPKK0lnXsitxQY1WRYK
JBsaVJ8QznhpuGfIRT6zq6lQeDABBBjoGQbesY+NYC4DoOsQOe0cvV57lAzN/w8P
Q2j+ejvxrUtGIBBfl2mUUjxlnR0vZl0+4DKpv9+LYO2U3RhU5K+U6fawEOpz2Pde
NJa7qrvjNC4h5CQB/cp2/1Ab4IcPdlxcjL4hoaIF1yKRJX1oqbwJrXwRmFqBPc/n
Pf72ZpDJCBOccVy8j1wHYJCXnyqmI513Fzt9RZtVAiCmxYSvmvFJry61miYs3CKG
wUqDdVzUH7bjDBToT7k1efasr5E0Z/SfSeF+O0GQmTIi+2yDn0FlHY/nn6OGndLT
0F98rj+WDFj5+9JvWnc39savpR8WzTs1m429tNleTv63g0J796VpOq1fGFCo7pPn
uUQZjrQ8mS08bLyZVRlC
=IzGm
-----END PGP SIGNATURE-----

--qyHYMwAXsHLOQihY--
