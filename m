From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 01 Nov 2008 02:06:20 +0100
Message-ID: <20081101010620.GD29036@artemis.corp>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <7viqr873x7.fsf@gitster.siamese.dyndns.org> <20081031234115.GD14786@spearce.org> <alpine.DEB.1.10.0810311738100.5851@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="RYJh/3oyKhIjGcML";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat Nov 01 02:07:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw4xl-0000nn-LH
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 02:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbYKABGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 21:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbYKABGY
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 21:06:24 -0400
Received: from pan.madism.org ([88.191.52.104]:38454 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521AbYKABGY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 21:06:24 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 7066D40105;
	Sat,  1 Nov 2008 02:06:22 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id F207F5EE245; Sat,  1 Nov 2008 02:06:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0810311738100.5851@asgard.lang.hm>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99697>


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2008 at 12:41:22AM +0000, david@lang.hm wrote:
> On Fri, 31 Oct 2008, Shawn O. Pearce wrote:
>=20
> >Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >>
> >>I.e. use the supplied custom function to do proprietary magic, such as
> >>reading the object lazily from elsewhere over the network.  And we will
> >>never get that magic bit back.
> >
> >As a maintainer I'd never accept such a patch.  I'd ask for the
> >code under read_object_custom, or toss the patch on the floor.
> >But that doesn't stop them from distributing the patched sources
> >like above, keeping the fun bits in the closed source portion of
> >the executable they distribute.
> >
> >Maybe I just think too highly of the other guy, but I'd hope that
> >anyone patching libgit2 like above would try to avoid it, because
> >they'd face merge issues in the future.
>=20
> the issue that I see is that libgit2 will be (on most systems) a shared=
=20
> library.
>=20
> what's to stop someone from taking the libgit2 code, adding the magic=20
> proprietary piece, and selling a new libgit2 library binary 'just replace=
=20
> your existing shared library with this new one and all your git related=
=20
> programs gain this feature'

Its license. GPL even with GCC exception would not allow you to do that.
Though they could propose a fork of the library patched, with the patch
distributed. The downside would be that their code would not be binary
compatible with the "true" libgit2, so they would probably have to
change the name to avoid namespace clashes, or overwrite the "real"
library.

But yes, it's theoretically feasible. I'm not sure it would be worth the
hassle, and if they respect the license (if they don't they can already
do that with the current git anyway) then the fact that someone would
want to do something like that would be known fact, probably not
avoided, but known.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLq4wACgkQvGr7W6HudhyKCACgmSgaoEDKUQfRwI/fxclUoBII
vKkAoJEZ2xrOdSShFNRvTKl3obKgM7pB
=VXMY
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
