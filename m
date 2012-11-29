From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v5 0/2] submodule update: add --remote for submodule's
 upstream changes
Date: Thu, 29 Nov 2012 14:13:26 -0500
Message-ID: <20121129191326.GC27409@odin.tremily.us>
References: <CABURp0oSo9ACFKkBEK1_qNu2mEAu1=nUJxnROaRsXiaWvHih=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Git <git@vger.kernel.org>, Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 20:13:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te9YU-0000qK-Hr
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 20:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306Ab2K2TNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 14:13:35 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:65230 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab2K2TNe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 14:13:34 -0500
Received: from odin.tremily.us ([unknown] [72.68.95.230])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME900K0VK2FMQ50@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 29 Nov 2012 13:13:28 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id DFE586E24E4; Thu,
 29 Nov 2012 14:13:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354216406; bh=IsfcNNmqMHQLpBS6kegm/MzRWz7I1JMvCSgG9WZM87M=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=fvE3MgOSKfJvXLH+DOgZuOHx00WGSQcORif9EIx9mYSkvCUCfx+lqSf+vwimpL8Ki
 uVvl5v2A2z7mhwQW6ywSHQtCvjH+/Qr325hT3m79h1L0jsLKA6lIGYQZJkd5Tbyuk7
 PPgl5rRF6gDeZ0otx1RDdVap4S8WOfcLTDW/8qc0=
Content-disposition: inline
In-reply-to: <CABURp0oSo9ACFKkBEK1_qNu2mEAu1=nUJxnROaRsXiaWvHih=w@mail.gmail.com>
 <cover.1354130656.git.wking@tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210867>


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Thu, Nov 29, 2012 at 01:29:12PM -0500, Phil Hord wrote:
> On Fri, Nov 23, 2012 at 12:54 PM, W. Trevor King <wking@tremily.us> wrote:
> > [snip initial thoughts leading to the update --remote v5]
>
> I was thinking the same thing, but reading this whole thread a couple of
> weeks late.  Thanks for noticing.
>=20
> Moreover, I think that 'git submodule update --pull' is also the wrong way
> to spell this action.   Maybe you are misled from the outset by your
> current workflow:

Did you see my v5 (add --remote) series?

> For that reason, I don't like the --pull switch since it implies a
> fetch, but I will not always want to do a fetch.

  $ git submodule update --remote --no-fetch

will not fetch the submodule remotes.

> I don't know which remote I should be tracking, though.  I suppose
> it is 'origin' for now, but maybe it is just whatever
> $superproject's HEAD's remote-tracking branch indicates.

With the --remote series, I always use "origin" because that's what
`submodule add` should be setting up.  If people want to change that
up by hand, we may need a submodule.<name>.remote configuration
option.

> I am not sure I want the gitlinks in superproject to update automatically
> in the index, but I definitely do not want to automatically create a comm=
it
> for them.

Commits are dissabled by default (see my recent --commit RFC for how
they would be enabled).

> But I really don't want to figure out how to handle submodule
> collisions during a merge (or rebase!) of my superproject with changes th=
at
> someone else auto-committed in his local $superproject as he and I
> arbitrarily floated up the upstream independently.  There is nothing but
> loathing down that path.

This is true.  I'm not sure how gitlink collisions are currently
handled=E2=80=A6

Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQt7PUAAoJEEUbTsx0l5OMlkAP/0ZJc/ZA5rychVqeGU598MZ8
aMnm76NdM6bg+msxE8/8R0y7+dglwmfyGw9PxDSEDK7sEqWbC90eH8PxXbU6rrvF
lFwFOsruDD5vzBD8lrQWhWPcDG+pvyHO6geCV2qzmJFAAVd/3oRwYZAgNPbzRxu1
MwoBQf+d1oU9ys9N3PzFov15DqdhQiL08Qh60IGFoCDYGFLahYlvEnuMRWBQ6/Pu
vkEC1C7fDrFsklFicnrl7CokO7up8HmjayZaAetdpyHTcfosjWwSbK0gyvqWtCKB
JqnFD3BFKfqs17+Pqj4bTyKQ7n+wOsE6DlLoVlRZjemkvp0+5N1DgUSkHBITPgxW
QsxbOuysiLJukfKkR4niZtlBfIZ9oMyGDNLBUGVcNykG5f9w834X22YGPPg7TQRG
l9ylaFuHI/fNXs+5kX4PCaZRI2oyFrf3n9lW2SC6Kji/EIzuD1voMFJgxY5pxBOs
umBa+4TBAsvpG0jUb1aJLiBsH/W8DZ/y9gaNcnrlDKUvIkMCg0iALJcT2VLlJ3+g
ywXXiVWueTTTcEP/HuPnjIOGP7gi644ZASM/nCqiE254k0xsKYJHyRvSNEy+o+/c
6HKA3JHM0HXwxi9y5wQ9ocaOyPBXqW10/JEFCJkRqpuBxN3d5pqcgy03TYIO40BY
LjFkj/M8ijvU3pLOr4RE
=Tn2j
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
