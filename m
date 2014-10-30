From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Joining historical repository using grafts or replace
Date: Thu, 30 Oct 2014 08:44:26 -0700
Message-ID: <20141030154426.GU15443@odin.tremily.us>
References: <CA+POfmvCiNBF=P-OvQBTROVhaLtOdgNTDgPNyS=97bupSGk=4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eEYjL7b2m+/uQ8dh"
Cc: git@vger.kernel.org
To: Dmitry Oksenchuk <oksenchuk89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 16:52:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xjs1l-0004as-3k
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 16:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933837AbaJ3Pwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 11:52:41 -0400
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:46958 "EHLO
	resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751426AbaJ3Pwk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Oct 2014 11:52:40 -0400
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Oct 2014 11:52:40 EDT
Received: from resomta-ch2-09v.sys.comcast.net ([69.252.207.105])
	by resqmta-ch2-05v.sys.comcast.net with comcast
	id 9Tj01p0062GyhjZ01TkTiW; Thu, 30 Oct 2014 15:44:27 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by resomta-ch2-09v.sys.comcast.net with comcast
	id 9TkS1p00J152l3L01TkS91; Thu, 30 Oct 2014 15:44:27 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 37687143E993; Thu, 30 Oct 2014 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1414683866; bh=3AGabMazjG1clGKvM8UJUDtIOvw8WbfeJvrDxz6Xl0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=seuKMxLIbOh9fPb8+3h26IcFn2TK7mWjyyEuJnzF7yL8thD9LXQUmecXAIrXdh/m6
	 dK2Prmd9fM22JjAKmbCdeJpKqltLMhf3nHxC+RXUPBwJXrJiEIykh/rB9lh1l1i46H
	 HuuadTMpPF3fFZtL4a3geab4N3wlI71rMvP16lGo=
Content-Disposition: inline
In-Reply-To: <CA+POfmvCiNBF=P-OvQBTROVhaLtOdgNTDgPNyS=97bupSGk=4g@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1414683867;
	bh=3AGabMazjG1clGKvM8UJUDtIOvw8WbfeJvrDxz6Xl0c=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=NjFkTPCi2DnScdd8N1sTTHjpizYdldFWFS+dLY929KulIQLEqUEopfgjKWH4K9ot0
	 pIYQ4iWqsXGugNK3FWAinkQjWRq1SLvU8zQxNV9yZb+kCX2+6nSnk4ghqyWOfOJkyT
	 ygTAGRywT5hoUrO6GXS0Ne+nPdxnwk/0Q36xXHhPC/vLR4g98ZRiw2Flxg6mxknTlR
	 nn2ekppc6kItkwy2welw2II+iH932EmrMuVR3KCHimcyw9QWc4tBYg8+JsVB9Nyupn
	 96ln43EznI4H2hETpe9eBMrBJ3oF8UwG+BfC6Wj0T3sTzzsPZ+dHWReSjtjB2puT9v
	 ZJ/zRh6T5Kbdw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eEYjL7b2m+/uQ8dh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 06:39:56PM +0300, Dmitry Oksenchuk wrote:
> We're in the middle of conversion of a large CVS repository (20
> years, 70K commits, 1K branches, 10K tags) to Git and considering
> two separate Git repositories: "historical" with CVS history and
> "working" created without history from heads of active branches (10
> active branches). This allows us to have small fast "working"
> repository for developers who don't want to have full history
> locally and ability to rewrite history in "historical" repository
> (for example, to add parents to merge commits or to fix conversion
> mistakes) without affecting commit hashes in "working" repository
> (the hashes can be stored in bug tracker or in the code).

A number of projects have done something like this (e.g. Linux).
Modern Gits have good support for shallow repositories though, so I'd
just make one full repository and leave it to developers to decide how
deep they want their local copy to be.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--eEYjL7b2m+/uQ8dh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUUlzXAAoJEG8/JgBt8ol8MDAQAIZxOCkW27X/iVGyLkqPKbF6
42VdZAWCnTOpTTNnKl9/BeHi9BLXRIzJwp7EpAdFbVsHnFmTylsVfvgsT3wfGi8c
LPStD/1NVtHNLKig1x3uNDf1racAzd383ptmqd2T6j/KsB2IazT+OxleEygkLGxn
cTWY48u7zGpz/opcrXyjyX0vldQn9Ih+l4cQdRKgg3ZKNQSWzAGH9e8ppgoJIP7J
MC2PneufYtLX1hlfupR9Z6w7xKmyr6VFt8NmSMJXHwxfuaQ3bU8he0YuKCmPJf6q
tZRKtkixMkxCl15iHSHANH6swF3xawebcxqevuXiCnnriLIC0Q6PBHo/UmdoXIEv
78jyziVHk3n93uyOj7Wv8MLdmMKzvLNIkx1nXm2qXPsVmO+yMkfxC/CmUnqCpr1q
OCtSBQj3ppZh4nJYzQm8M66g7XEgoLHmIB5jmAkgd1HKHN+iIw7vPud01ZV1T4D7
QoXIHNNhY9dJj5l8CrbLi+alyKq6l9+5nJOcTlfX3YC0O0lRXZQ2CT6rq3pd3nRN
lGpHujwDXQxyvnmZSuXKm1Aw/M3AivQiUF7t+AuMMwN2pk4qZDAQKAhDcM6JIDRu
W+JPG/llwhIaTGQjz8zcfS+Ns1GbF13iVH0sK1FJRt1X+Qnzkk2lMOLB0RoPOiKq
DGBPwZandG4J4o8YYEBt
=0pPC
-----END PGP SIGNATURE-----

--eEYjL7b2m+/uQ8dh--
