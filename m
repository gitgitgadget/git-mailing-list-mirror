From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 00/15] config: make git_config_set die on failure
Date: Thu, 4 Feb 2016 09:56:54 +0100
Message-ID: <20160204085654.GA11303@pks-pc.localdomain>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
 <xmqqpowerfr1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 09:57:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFis-0004zP-Bs
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 09:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbcBDI45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 03:56:57 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37414 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965221AbcBDI44 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 03:56:56 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 2E19220A5E
	for <git@vger.kernel.org>; Thu,  4 Feb 2016 03:56:56 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 04 Feb 2016 03:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=VPSgpSLtfY1IMYs6YkZj0iwEmvQ=; b=DdKcb
	yZ1+tTnvnjU0ZsFJGF5wVFNMNN6DGk4/wLfFodmZiupcF8OrmGr8NDDX9c69oq0e
	F8Xk3lyiNhwzSx806Hsm8WQDdULyEkvn+VfIHMoBZFTk7ic8tls5/Nxqikafs1Id
	zIGHB88pglR76JC7dUWoA41g6aNGAcJ51PJTlc=
X-Sasl-enc: tOVSLuKNZxAlV5guhRSnEAsqDz7VDZJsa2btyLh2isMF 1454576215
Received: from localhost (x55b3bbdc.dyn.telefonica.de [85.179.187.220])
	by mail.messagingengine.com (Postfix) with ESMTPA id B37AA6800B1;
	Thu,  4 Feb 2016 03:56:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <xmqqpowerfr1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285413>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2016 at 12:58:42PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Patrick Steinhardt (15):
> >   config: introduce set_or_die wrappers
> >   branch: die on error in setting up tracking branch
> >   branch: die on config error when unsetting upstream
> >   branch: die on config error when editing branch description
> >   submodule: die on config error when linking modules
> >   submodule--helper: die on config error when cloning module
> >   remote: die on config error when setting URL
> >   remote: die on config error when setting/adding branches
> >   remote: die on config error when manipulating remotes
> >   clone: die on config error in cmd_clone
> >   init-db: die on config errors when initializing empty repo
> >   sequencer: die on config error when saving replay opts
> >   compat: die when unable to set core.precomposeunicode
> >   config: rename git_config_set to git_config_set_gently
> >   config: rename git_config_set_or_die to git_config_set
>=20
> They mostly looked sensible; I commented on things that I noticed,
> but I don't think I spotted anything that needs a huge fix.
>=20
> Thanks.

Thanks for the feedback. Will post v5 next week.

Patrick

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWsxJWAAoJEBF8Z7aeq/Es89YP+wZaNqE/kxhMgRn2LIWa0bLL
51/x/yUf+jO0owzurYcPDYXKpXfxqkS4LR12OIDNX2ElhLT94e7qqxHOPomJAtzK
cBprBXVllUf0WWx6SsGbITXPXsSzVIhoUXcNNs618cETN3BBgL7RHWnPsuImUB/u
mS1Dj1hSTB0pqwaSR/gp40y3PK+7MTkxvMonQvoDAi4I97cHJLW4zf1/Dy00e14V
k1nxQwoIHxkBquxHLgY2p01iTBQvcD6dmMGtG0XQRT+NNroKmYmEGrnIXyQcGUQ5
CG5EqYqKo6dDPt963wnSitfiluvyA6NlgXoQB+Qt041OucrKgWx/6yDZuFEx2Ww3
QbVvbPfaLDhP4UDTX3h5oEWrdv0lmEv9KUWub+yYX88korydwMX9qzTxY1UXgqAh
kiqdjvbH/hLyEcHZldFTV4wGh2XjbJyZinf92uSkBW7aqxfTRfWBXjfrKDLFvXuF
lqaa7wO5uZ3w6q/w7PuE01Gbbc+sE304qH3yWmknBh9SH3wFh8hqnY9a6r7Iee84
D83AV5+RMWmvHPW2sbQ7BjwagWBovnqlWgGSomEWCNiGiw3s52G5ZMcQURZ0NsDu
aHe6qJv8zAcDonK1zf1pMCZrwXQGf3ntry72iwnuflwLA9V1eYFn6ROgrlDytP8Y
bpWw62Kw0zh5gelKd08Q
=y6M1
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
