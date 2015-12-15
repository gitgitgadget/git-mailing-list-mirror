From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/2] push: add '-d' as shorthand for '--delete'
Date: Tue, 15 Dec 2015 10:22:06 +0100
Message-ID: <20151215092206.GA1209@pks-xps.elego.de>
References: <1450106584-22313-1-git-send-email-ps@pks.im>
 <1450106584-22313-2-git-send-email-ps@pks.im>
 <xmqqegeokfet.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 10:22:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8loK-0007ph-9h
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 10:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933383AbbLOJWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 04:22:11 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55250 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933212AbbLOJWJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Dec 2015 04:22:09 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 0CE4B21B85
	for <git@vger.kernel.org>; Tue, 15 Dec 2015 04:22:09 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 15 Dec 2015 04:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=/UIhYv0rjL8FQNmfGrgbwcjcyJk=; b=GfC0f
	xqGb1FCajZouARF+0pfaSJX+KMUam+BmvqmuDN25df1uK+nx41X3ALowhrTFSsTo
	dW9wLTp2tcW0hpUiYRFwgQD+cafbkKH/I7Q5t4zWPUoVXC/7yPboHp4zjTrWGJZT
	dZBd/mTM46GpoI/FVpD1ry0rUfN/RLIaqZMD9w=
X-Sasl-enc: flI0MWKiBMQVqd5yp9wYL2byMhAK6s8vRDpl8d/aJSar 1450171328
Received: from localhost (i59f7870a.versanet.de [89.247.135.10])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5ABACC016C4;
	Tue, 15 Dec 2015 04:22:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <xmqqegeokfet.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282467>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 14, 2015 at 11:18:18AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > It is only possible to delete branches on remotes by specifying
> > the long '--delete' flag.
>=20
> Not really.  "git push origin :unnecessary-branch" should just work
> with out "--delete" or "-d".

Well, sure, didn't think about this when phrasing the commit
message. Still I think my point stands that it is more convenient
for users to also have the '-d' shorthand, as is also in use for
branch deletion in `git-branch`. I'll resend this patch with a
corrected message.

Patrick

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWb9u+AAoJEBF8Z7aeq/EskygQALFDqhGF5d/UiCrKfabCkn8C
/ij2mgNNjj+VHMPfhq3I2LgnGZk+zofcNoA6/uqh22FQ8P3fJdwaPaiGE55AHruG
dRCbVHIeGtcCx3I2iaHa2yTtbRbapqNpuazbbf4azDevKDw31pX1attbw5j+VHgn
yUFLUbivVSRwqZSOFE6R4r1hBftuChN4qlxHWoppim/YQc2ObJQ70e46ZGQShde/
F7HoHUySj0Fl62p0wG45HJEGzwpJmf0Q9LGelfNTK3auKsczRU3ZXIwnkSjRnXUI
Ohfin+vzouD0tP9tC477JMCGmtXcEtYxEYGeyNBwzmQ52EYD5O6KXd7mTTuvpgnj
CbsIh5+Wl6meMXuAFAKmmmeROmkei2y7Ua+bF6rOpCrYsXze8+CWo9Pg3OWncLTm
CNIe1ycRORaLdhnrb4WQTR5ETdUgmw/j/aWWWoL8aPPXJmG7CHuti3VaehJwXEXB
b7pczSI2cGuaS2mv1bqUieDBQM5DImJwX1M1S3aFd+jrntupi7U4he2eC1AmAXt9
MnHdasjvl9c61T7hFLJjtki3j7jZchFAKagvygrWTx8p/bpn8Z7NvEJFaHbFB95O
x5YTKLsHKcFynTl6HDPkOhGlBs7QeoGI803D8cheF3GR1kxiwrv6FFk8/u+xI7oH
zqEd+/IS5zY/zdCUdH7I
=jbk7
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
