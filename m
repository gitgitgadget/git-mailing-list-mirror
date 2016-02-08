From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 06/15] submodule--helper: die on config error when
 cloning module
Date: Mon, 8 Feb 2016 15:05:51 +0100
Message-ID: <20160208140551.GC697@pks-xps>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
 <1454413916-31984-7-git-send-email-ps@pks.im>
 <CAPig+cSLoXGHFXm96dpfjmkZkpXOFezEFZek-Jry85XkCwOsWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 15:05:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSmRy-00061S-11
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 15:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbcBHOFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 09:05:54 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57703 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751738AbcBHOFx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 09:05:53 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 486E1207E7
	for <git@vger.kernel.org>; Mon,  8 Feb 2016 09:05:53 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 08 Feb 2016 09:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=Fk4IXNNaXbKXWIi6afi5UCImaM8=; b=YwOhu
	yxxpVNpYF8gTv9KiqSRWz4t02OebUaFKc6yU4XxDYo95ftMEPysA7GgKhpNFp8hw
	NoKMRzhLuXBjOgA9ErE7hCw7ph3py8icqXOFWN7qOMhA65I0CGM6Lpu4E92Ci+i9
	fB+TCKmM379rvlXUcwYxclPcomGiLDLRivq+DU=
X-Sasl-enc: kx127GjBBh6dh/OfTsDKX5WtKks3BJdra+yVJuvD9MvE 1454940352
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 98C77C00016;
	Mon,  8 Feb 2016 09:05:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAPig+cSLoXGHFXm96dpfjmkZkpXOFezEFZek-Jry85XkCwOsWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285767>


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2016 at 01:45:50PM -0500, Eric Sunshine wrote:
> On Tue, Feb 2, 2016 at 6:51 AM, Patrick Steinhardt <ps@pks.im> wrote:
> > When setting the 'core.worktree' option for a newly cloned
> > submodule we ignore the return value of `git_config_set_in_file`.
> > As this leaves the submodule in an inconsistent state, we instaed
> > we want to inform the user that something has gone wrong by
>=20
> s/instaed/instead/
>=20
> Also, there are too many "we"s, so dropping one would be a good idea:
> either "we instead" or "instead we".
>=20
> > printing an error and aborting the program.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>

Thanks, fixed now.

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWuKC/AAoJEBF8Z7aeq/EsyXsP/Rxadro/mr9Rmhmz9xnO8Tbz
10wQBhTEOXcEHHWEoQkmiDquMmcAjJ97rgMa9sRbj3wbskZWajCXJsK3j1X+47HL
5n8yd5VaH7gP6iQC6JwucqNhaatR+ZyX/cnpHRq1zSm97/rnog0G7dU67Y5ugFgu
FVa6pVLT0x4rjvQQbxx6lD3TislUE4j+/n65UXTqy57pe7Fa1gksqYzbLB4dZUVy
6qJdEqIlmkLq1gdXCXwieukgJYmOgALL0nzgFO/swo7WSZr/Hykwew1BusTnQf/h
suBfagvb8DMpjJqFJ+NQCUHF/pq+DmmPm2UPIpUbiFJHoHyCg0+l0QbNlAD72Bbg
z7uYtWoMc5616Ij2Rx+dipz65vFB7zZ8W6vKRkGBSKm7O7MqWM0aGL0zdjjvMB//
l4EWcNBHZF1uermn/dBfBrFT1q74f2NEobchKPxh45gCbpxMi/hBBMiHPCsXDYcB
YEsBPPZrC3ihgrbmf6Iop4Kh2rh/F1aMxALT2MF0ushxyOzB3GfMvBECXONYlokV
dDe9pKxmfgtxRekiWWG8plWM0WjOmss7btRk9sLNJXOgOSyEkPqX8srLb5ga8iBo
rpRXuvPcS84/Yuc/rrk5JMGDt04x/S13nx8uGHbdobSUydpwXI9r/FNYbPRNRDJS
lz0VAvlWLg40nlBj6K+u
=Gu4N
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
