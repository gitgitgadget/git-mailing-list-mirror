From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: git-submodule.sh respects submodule.$name.update in
 .git/config but not .gitmodules
Date: Wed, 11 Dec 2013 14:44:24 -0800
Message-ID: <20131211224424.GB25409@odin.tremily.us>
References: <CABYr9QtSeX=Euf73MZPq6suo+GpVA=f+tH73Ct0tP-3LYogh9w@mail.gmail.com>
 <20131209223506.GF9606@sandbox-ub>
 <xmqqlhztvbi8.fsf@gitster.dls.corp.google.com>
 <52A8E689.80701@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Charlie Dyson <charlie@charliedyson.net>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 11 23:50:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vqsc1-0005zj-F1
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 23:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084Ab3LKWud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 17:50:33 -0500
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:53281
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750873Ab3LKWuc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Dec 2013 17:50:32 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Dec 2013 17:50:32 EST
Received: from omta18.westchester.pa.mail.comcast.net ([76.96.62.90])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id 0Jqa1n0031wpRvQ5BNkTFA; Wed, 11 Dec 2013 22:44:27 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta18.westchester.pa.mail.comcast.net with comcast
	id 0NkR1n00R152l3L3eNkRur; Wed, 11 Dec 2013 22:44:27 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id D8CB6D5FA74; Wed, 11 Dec 2013 14:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1386801864; bh=eboQDa3kwM085zAh4FOOFX8sWjjB9xA/tcFrlYkXAQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TKHwkhgTZ1Xfs4MWVQPfPzgcsTuV7vLWDf/rQg9ThvSHg9+5ZPWHbYC9S3PcvrMSU
	 vqUyGZB3dMSPRp4EU2ZCBEoXJ6VaB7wNslRAZRYY8EHsK7Zx1p/mxsdg0MUgv30Ci1
	 QmFZv7yZVk4AgjhzroFw8g29V8ZkBakEkVNZXS6A=
Content-Disposition: inline
In-Reply-To: <52A8E689.80701@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1386801867;
	bh=M5P+kVAlAztSkA0uNVQE1wsMxULPX/3pAuh066ZHMP0=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=PVyacTPbufu89wrf7ydAOoc1HfkbquF/R9zDCsATy6WWirF2ZEJ8k3j8JEXjER2sr
	 5eKatosbApObwWEN+V7uoLYCrdJONK/3JwPSSP7wNYJkeh2TQ6HNaEOrGTex/VlvdK
	 3GebmMyxxqx7nre22ngshGtSj1Mk+CTDptUNKRvPEkS/e62CoiaZsGXjBmKpO6eFvU
	 rH6II2RIEHhgJeTL98x6cnf0UEc7j0pFAnIxTQLDPziVmTQ6046G7Rv+OBPeEgzhw5
	 pFSfTOC9FrNx5P+IVQ//6UenzkdEQDPfJzLS30Tdd5B4B4av6MdIEIa4/tk3Ugbxcy
	 H5Vpd8+y+/rDQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239214>


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2013 at 11:26:17PM +0100, Jens Lehmann wrote:
> Am 10.12.2013 00:40, schrieb Junio C Hamano:
> > Heiko Voigt <hvoigt@hvoigt.net> writes:
> >> This notion has changed in a way that only the url (by that the
> >> name) should be copied on init. The default for everything else
> >> should come from .gitmodules or gits own default.
> >=20
> > I think you need to be a bit careful here.  I do not think
> > everything should blindly default to .gitmodules (otherwise there
> > are obvious security implications as well as usability ones).
>=20
> I believe everything except the URL should default to .gitmodules,
> for the same reasons we already do that for fetch and ignore [1].
> But it should not do so blindly and take precautions that this only
> happens for safe values.

I think the "safety of .git/config vs. convenience of .gitmodules"
balance is going to break down differently for different folks.
That's why I proposed get_submodule_config() [1] and
submodule.<name>.active as an activation marker [2,3].  Then users can
move as much or as little of the submodule config from .gitmodules
into .git/config to strike the balance they feel is appropriate.  For
safety, maybe the default `init` should copy *everything* into
=2Egit/config, after which users can remove stuff they'd like to
delegate to .gitmodules.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/210930
[2]: http://article.gmane.org/gmane.comp.version-control.git/211014
[3]: http://article.gmane.org/gmane.comp.version-control.git/211042

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqOrGAAoJEKKfehoaNkbtjtwQALR2TedKMeVnsAisDbvGESAQ
kuFTNoNG97oNyMXmHqwlTrKeLTG2qJVopbyR1sDEol1717yz/X4AivJ70pwggZ3s
GIqmei9c0er599yU/FlbE1Cn5gJoZZBMYkxRK2h0t3mbezWKZu8ZFlwLrIILhkyf
QJslAibCbAs3qARMkY9hGMq5WHHmaNVd22ueAcq6y8+2TiCcH+TLSIrX4Di8yCfK
GYn0vGdFoYv0V35YTBnHlyBsKi9hBqAIVFWew4z35u6nfe2upgYPXl9BenWnGyLq
Uqv/fj49GB58DTyFoMBDwZy5E89q+xiJdS2to8PWyRsNztNTilOBIBkWcxBEX0rp
DUH6RuAvlRkW+fw+oK3M6Ubm3nnD8E8yOHY/f7P3YCoMjBCettO1+ry2TqLK67w2
SJQNFvlL/mbClGB9PY2dJi8oAhI8d8rLyBuERBdZb95ONpr0x28Vg9JB22PbJKAB
7xME5Vm6HvMUiOFOcCHKzTGTvBFtDzlXz1BkPIgsLzOBd8X+0qaR2HkwsHH6gLAk
TgFz9ah5a5u/CqbNqIn/XI1QdnfZ5ZzImqOGe8UoILG8UVpicjytzZQg/WX7yvyT
Wmor7tqesM63m8QcfYIcbxYnpsRFUOB+NYZrBGRWMX16siZjG8176i5mzLBd0Q+S
+jSGZMrTpY6zJoMInx/3
=dQbf
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
