From: "W. Trevor King" <wking@tremily.us>
Subject: Re: git-submodule.sh respects submodule.$name.update in .git/config
 but not .gitmodules
Date: Thu, 12 Dec 2013 11:14:29 -0800
Message-ID: <20131212191429.GI25409@odin.tremily.us>
References: <CABYr9QtSeX=Euf73MZPq6suo+GpVA=f+tH73Ct0tP-3LYogh9w@mail.gmail.com>
 <20131209223506.GF9606@sandbox-ub>
 <xmqqlhztvbi8.fsf@gitster.dls.corp.google.com>
 <52A8E689.80701@web.de>
 <20131211224424.GB25409@odin.tremily.us>
 <7vtxeeuaw7.fsf@alter.siamese.dyndns.org>
 <52AA072F.2000105@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Encpt1P6Mxii2VuT"
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Charlie Dyson <charlie@charliedyson.net>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 12 20:20:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrBoQ-0004Hu-Cb
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 20:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825Ab3LLTUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 14:20:38 -0500
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:43374
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751519Ab3LLTUh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Dec 2013 14:20:37 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Dec 2013 14:20:37 EST
Received: from omta13.westchester.pa.mail.comcast.net ([76.96.62.52])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id 0cqw1n00117dt5G54jEXqa; Thu, 12 Dec 2013 19:14:31 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta13.westchester.pa.mail.comcast.net with comcast
	id 0jEV1n00e152l3L3ZjEW9U; Thu, 12 Dec 2013 19:14:31 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 60DABD62513; Thu, 12 Dec 2013 11:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1386875669; bh=iMpZtU94N9xZil5vgxZx5nALorFUrvYfGPFQjvV95RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iJzJG01y8dUwQf4ljYjW6B0VD2/Li2MGIKeloBuHzjAnhs6Lak2TtPqKiUrpDoy7L
	 IOu7JjcCcdBddAIOkDCGCGoFIq+wPTwaiIyADv62a+TXYHK26eqazxEjmebOBrKAQ/
	 vHMnSANFag+ffBnAButAxr47UhgmWhxjhWRmUQzg=
Content-Disposition: inline
In-Reply-To: <52AA072F.2000105@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1386875671;
	bh=XiBFb8scDpK9hElpQSBWIhNzBbVl/M2aOG4dQqThRPw=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=J/nI/o1SrpxX4QuRiylQj+BdI7ZZOO9s1STkzyc0zyUYD69LD4od2sJbCGERvnGAG
	 qeuFsLHtp6Ygf3JiW+anGg+vHFEiisoP+KyRE6oRSjlFdk5siDL4+GqFnouUF820c/
	 oa0VLgB02Dg7fEDiw1CAbAbblzWn5DBDathc75iKqMrFASDh7WvPnlvK1Vu04JZT0R
	 P1i6Y5J1NrQ6QQjo5NUF3cpvpSak3YRPpSEHMsf6GEYBdp4Sth6j24Rblh4ztixwG5
	 ZP3h3QGqO+uNfwtqHm4chp+FPdc+jCCm0tWl7Eu1VlmINw0CzsttfOUNSY1lXgLOjS
	 hGQGP3TS85t4Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239238>


--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2013 at 07:57:51PM +0100, Jens Lehmann wrote:
> Am 12.12.2013 02:16, schrieb Junio C Hamano:
> > I think the solution we want is to copy only minimum to the config
> > (and that "minimum" may turn out to be "nothing"), and to default
> > keys that are only absolutely safe to .gitmodules file.
>=20
> I agree and will prepare a patch for that.
>=20
> What about teaching "git submodule sync" the "--url", "--update",
> "--fetch", "--ignore", "--branch" and "--all" options to allow the
> user to copy the current settings he wants from .gitmodules to
> .git/config (but only safe values of course)? Trevor, would you be
> ok to issue another command to copy everything to .git/config?

Sounds good to me.  The more stuff I can leave in .gitmodules, the
happier I'll be ;).  My second step will be removing =E2=80=9Cunsafe=E2=80=
=9D values
=66rom .git/config where possible, and I'll trust myself to check
=2Egitmodules after pulls.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqgsTAAoJEKKfehoaNkbtIkoP/0YuWzern5lPVaivVFYuQZoR
h5K0/wKg2oUsPgNmv9Ik9XHtNxukWbnD+nYvkZ9qDuGG3tCuRJGR3imBDmjuSwnu
KkeiduPTh67awbvNuDmmwrJkwdnkftu3sYkEAzboDBLSz+4QMjYubSRq9L6zajxo
t7I2fg82o32GOBzCNQ8X72f4SovjRXj6FYWaJKz+wYxmtcti+PnrWOk9pm6Huoxq
Ky/JU77YgfqQqu9/Q4BWXtg3ydTriQpsJZRyJnflEn7XAtkodTgP6PaimC7vc9oO
jQndJDJJSFAScaP/KoIKKHKhzJWVLNIO3w54i2opNQnEreFPxOCiKGUhZH52PNNu
PSpHHeQsOGQ0OBLEZyRS6XVGg+9oHtnLOyCSqhgaXico59LRWBErDamhatLmC5aY
JYQ4K1NxhY5VLclzlMe1k6s0DhSF0waQRUJ21LV+x42wdXvWcKMvo5oaWStjcjSq
17CCB2/HMwtwwUGZq4CNSpkqRiGPGpNnkElEFPuZAdsfofCuVTuVDttFQr8lztDc
E38mwL02/86wwtCxrXMBWYjKzIXljO1gyaya4l5Lh5PZOBT2wj2KaNBcOGCfTndC
N3LApB10a6hcLtWTIW07AUNUHHfVh14MDH5bjwMhM5dmxotQF5qFml6vLQ4TTQ4K
JR1o69EDZ+XMv7sGAg2E
=6AOZ
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--
