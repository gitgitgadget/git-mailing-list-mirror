From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 01 Nov 2008 02:08:24 +0100
Message-ID: <20081101010824.GE29036@artemis.corp>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <7viqr873x7.fsf@gitster.siamese.dyndns.org> <20081031234115.GD14786@spearce.org> <alpine.DEB.1.10.0810311738100.5851@asgard.lang.hm> <20081101010011.GG14786@spearce.org> <alpine.DEB.1.10.0810311802360.5851@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="gDGSpKKIBgtShtf+";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat Nov 01 02:09:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw4zk-0001Eg-GT
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 02:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbYKABI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 21:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbYKABI1
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 21:08:27 -0400
Received: from pan.madism.org ([88.191.52.104]:38465 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbYKABI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 21:08:27 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id DF32240105;
	Sat,  1 Nov 2008 02:08:25 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 5B1485EE245; Sat,  1 Nov 2008 02:08:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0810311802360.5851@asgard.lang.hm>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99698>


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2008 at 01:04:50AM +0000, david@lang.hm wrote:
> On Fri, 31 Oct 2008, Shawn O. Pearce wrote:
>=20
> >david@lang.hm wrote:
> >>On Fri, 31 Oct 2008, Shawn O. Pearce wrote:
> >>>Junio C Hamano <gitster@pobox.com> wrote:
> >>>>
> >>>>I.e. use the supplied custom function to do proprietary magic, such=
=20
> >>>>as
> >>>>reading the object lazily from elsewhere over the network.  And we=20
> >>>>will
> >>>>never get that magic bit back.
> >>>
> >>>Maybe I just think too highly of the other guy, but I'd hope that
> >>>anyone patching libgit2 like above would try to avoid it, because
> >>>they'd face merge issues in the future.
> >>
> >>the issue that I see is that libgit2 will be (on most systems) a shared
> >>library.
> >>
> >>what's to stop someone from taking the libgit2 code, adding the magic
> >>proprietary piece, and selling a new libgit2 library binary 'just=20
> >>replace
> >>your existing shared library with this new one and all your git related
> >>programs gain this feature'
> >
> >True.  The only thing that prevents that is the normal GPL. The
> >LGPL and GPL+"gcc exception" allow this sort of mean behavior.
> >I doubt there's enough of a market for that; replacing a library
> >is something of a pain and if the feature really is interesting or
> >useful someone will write a clean-room re-implementation and submit
> >patches to do the same thing.
>=20
> how would the LGPL of GPL+gcc extention allow this? if they modify the=20
> code in the library and then distribute the modified library wouldn't=20
> they be required to distribute the changes to that library?

See junio's example. It's rather easy to add hooks into the library to
implement a feature outside of it. It's even possible to do it while
preserving the ABI fully IMHO (by being a strict superset of it).

The patch would be so trivial, that I see no reason why they wouldn't
provide it. Though the real implementation of the feature that would be
delegated through it would be in their closed source stuff.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLrAgACgkQvGr7W6Hudhy68ACdEL6UdaN8XtwRtjWyoymuBvU3
rQcAn2Ly/PtjXr1pU/4p4xg/Q9jcoIMD
=/L9J
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
