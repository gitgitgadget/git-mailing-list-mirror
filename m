From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [RFD] Gitweb: Source configuration from file separate from the
 CGI script
Date: Fri, 18 Mar 2011 10:51:47 -0400
Message-ID: <20110318145147.GA26236@inocybe.localdomain>
References: <1300285582.28805.25.camel@drew-northup.unet.maine.edu>
 <m3lj0e59ps.fsf@localhost.localdomain>
 <1300361067.3010.1.camel@drew-northup.unet.maine.edu>
 <201103171641.29021.jnareb@gmail.com>
 <1300457243.12245.13.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="CV9g7MldeTA+KTr7"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Mar 18 16:06:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0bFq-0007OX-Mr
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 16:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787Ab1CRPGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 11:06:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756784Ab1CRPGH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 11:06:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CFAF26CD;
	Fri, 18 Mar 2011 10:51:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=JNCylRVn1rNswcZq8Siw0U2CxBc=; b=gI0HU6Y
	Olu94YIqE/ghRrmMu4xMxEYb0X6FHgAO+v1lUty5aCbaKhP6CK9nWtiQc2WSLQmQ
	N0zRHfYC92gmkfNAImkYYm+7g+rgwlDMBe8KuB78+mN1zBRKrH022SyeirPcNeoG
	hdlBL9fgtQWg4R8wXoDCX8ZN1F/j2IqsLZbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=lAlSvBChk0T5s8WOvR+88jL32oXeJfUZE
	GKNYvouI12X1wWRLIdFVMTOupyvxrHxO7lsAIdYJuszfddrPdgMlxmCHc6aMhfBi
	ctjlXv5i1KEFNhr8e6481yjLeJXbu0k1W+/zhSX9YdNxfjXZCTuqFvVTVNEgPaYU
	6TW9HdzOcU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58D3426CC;
	Fri, 18 Mar 2011 10:51:51 -0400 (EDT)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD5CE26C8; Fri, 18 Mar 2011
 10:51:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1300457243.12245.13.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Pobox-Relay-ID: 4211E074-516F-11E0-97F2-C1F4E168B6F2-09356542!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169331>


--CV9g7MldeTA+KTr7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Drew,

Drew Northup wrote:
> At the very least I'm considering making a man page for the
> configuration file. I don't know off-hand how much that will be
> seemingly repetitive of the README, but I suspect I'm not the only
> one who often finds monolithic files tucked away in /usr/share/doc
> (/usr/doc for some systems) a daunting reading prospect
[...]

FWIW, with git-1.7.4.1 in EPEL we now include a commented
/etc/gitweb.conf in the package.  This wasn't present in the very old
1.5.5.6 we had in EPEL until recently.  This config file doesn't list
all the available options, but it does point to the README and INSTALL
files for further help.

(Also worth noting is that the package was in the epel-testing
repository for 3 weeks and was announced on both epel-devel and
epel-announce to try and get testing from folks before pushing it
stable.  Sadly, very few folks do so, and issues are sometimes not
caught.)

Sorry if the update caused you trouble.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Curiosity killed the cat, but for awhile I was a suspect.
    -- Steven Wright


--CV9g7MldeTA+KTr7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJNg3F9JhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjZQgH/3X0aJtC4x5me+YC8drjSVyVrR8G+5OckMsZ
2aAWzbC/xFhM1MG9b0/LmgBce4EZQqE4OTUQe/g7bohGObYDXj1Ax3vRaAAOU8ZJ
0EEqCNls7fXGz+05hlGECR6OH3qD3EsuE+FIp/vQS9DY78PoWsrAoB5kaDDesAdo
9vTnQ6xT7mZ9p34JPGr78WtoA2v4uo0KRwetyD8vuiF97qJZU8+Zpwxb+jsv8fmA
uXoW+ry5W5Z4sGGbDYm/wMcKA71/hv/rqDqo+19SgpIDEskwr7/BhvfdULnQ+2YY
WXdrhSnp6gFT3lKr+87hWOSC32XuarwrwLcmQXd4nu08/NNc8Xo=
=R9G4
-----END PGP SIGNATURE-----

--CV9g7MldeTA+KTr7--
