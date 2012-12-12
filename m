From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2] submodule: add 'deinit' command
Date: Wed, 12 Dec 2012 18:09:26 -0500
Message-ID: <20121212230926.GC7729@odin.tremily.us>
References: <50BA3412.60309@web.de> <7vy5hhmcwp.fsf@alter.siamese.dyndns.org>
 <50BBB22A.7050901@web.de> <7vhao31s9e.fsf@alter.siamese.dyndns.org>
 <50BE6FB9.70301@web.de> <50C89DF3.20303@drmicha.warpmail.net>
 <50C8BD6B.9010702@web.de> <7vr4mv3w2x.fsf@alter.siamese.dyndns.org>
 <50C90469.8080303@web.de> <7vlid23nnc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=xesSdrSSBC0PokLI
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 00:10:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TivR6-0003hs-6l
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 00:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab2LLXJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 18:09:39 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:58712 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754915Ab2LLXJj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 18:09:39 -0500
Received: from odin.tremily.us ([unknown] [72.68.110.234])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEX00A6NXNQQ780@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 12 Dec 2012 17:09:28 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 3A26F71CC78; Wed,
 12 Dec 2012 18:09:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1355353766; bh=eLJ5upLXImERgIbDG8jqYdTXDShn6upRel9gX2CrpR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZhwHyRmotZq+gQjFdRT3dHmDqZ1cGwnNdUaflpg/VMJFO6PaR9C0d9w63sWvFpkzB
 tpPbgY6RP3/zX7x8t+h8a0rD8wz5V/xnp/2G5CpWIEUnsLBbkt2S5f7Kg3AFPvrC4Q
 grBJFHGTfhD9kxu8Kr6OwGOaI6tc0U8tugvXiEMM=
Content-disposition: inline
In-reply-to: <7vlid23nnc.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211414>


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2012 at 02:34:47PM -0800, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>=20
> > So unless people agree that deinit should also remove the work
> > tree I'll prepare some patches teaching all git commands to
> > consistently ignore deinitialized submodules. Opinions?
>=20
> While I agree that consistency is good, "deinit" that does not
> remove the working tree of the submodule the user explicitly said he
> no longer wants to have the checkout for is a bug, and I think these
> two are orthogonal issues.

Should `deinit` remove the submodule checkout, replace it with the
original gitlink, and clear the .git/config information then?  That
would restore the user to the state they'd be in if they were never
interested in the submodule.

Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQyQ6lAAoJEEUbTsx0l5OMtmgP/iq0CScG37GI8cK4P1kkfbnv
D10Ly79KhafEOPi9D3gylAsLbYdJw4DcGc7TqU0vW2lHyKSsfBtmD785ybA67USU
vcbGFxDmeR6iQYKlahtK1xH4FbDaykRQJTAOuVJuG3K+PRRfEtXssHHEkndIMFFR
+3oblf2eCoG4HV/yijhNSC5ntF1FTR4iWkko/CokKMwR+lgEXL2n8PLviM7nfznQ
NLQ3CplhVE5SVqRhFr6Q33TnGRpjFodX30pFY/M7bwNajPpsm7xgT2TbafjxVuVk
CjehbwGOzCL8AbP2AfGnoxBuuTa06gsulopbT6l/r0ioyFcVID1Dn/ZUKpnf+RnV
lwgeXqHZ7+3SmtIpvc7By3GI8ETyGJmGAooe4ctqbO4rKOntxk2N9BwmCCLl5qNE
kZgmPuMa2XJ1FiNnQ5UDmqFU23gRBJ7uEJkUtPmAnqhVYVaw0G8kz6TSTAAlCN4I
rf+a0j6X12QIQeZ/H7rikNX0N15zuBxlUMNWDlI6VWTqYSfixC/29o0SgNGrdEjy
dcwjEAgKIjn5Skj8AO72J6jUM8up48uBGdHt4fQPRCgoUq3zZXmRKYPGReQOUJUp
MyMF+UNadMCFLoVZ+c9i5/V6lHlFrEXaQEUrKnVbkgPadYJ9tRrJs/UP4LrYLLlh
2qZtL4YIAhZixpQZxUmt
=oALV
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
