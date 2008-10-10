From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC PATCH] describe: Make --tags and --all match lightweight tags  more often
Date: Fri, 10 Oct 2008 19:12:17 +0200
Message-ID: <20081010171217.GB29028@artemis.corp>
References: <20080930083940.GA11453@artemis.corp> <20081010165952.GI8203@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="0eh6TmSyL6TZE2Uz";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Erez Zilber <erezzi.list@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 19:15:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoLYT-0001JE-Ep
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 19:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758273AbYJJRMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 13:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758056AbYJJRMV
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 13:12:21 -0400
Received: from pan.madism.org ([88.191.52.104]:39800 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757864AbYJJRMU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 13:12:20 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 8520C3CB8B;
	Fri, 10 Oct 2008 19:12:18 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6F6542A24F; Fri, 10 Oct 2008 19:12:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081010165952.GI8203@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97950>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2008 at 04:59:52PM +0000, Shawn O. Pearce wrote:
> If the caller supplies --tags they want the lightweight, unannotated
> tags to be searched for a match.  If a lightweight tag is closer
> in the history, it should be matched, even if an annotated tag is
> reachable further back in the commit chain.
>=20
> The same applies with --all when matching any other type of ref.
>=20
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>=20
>  This come out of the discussions earlier last week, where folks
>  were confused about the meaning of --tags and wanted to see it
>  behave as they expected, which was to match the nearest tag,
>  no matter its "type".
>=20
>  The code is unchanged from what I sent out before, but now it has
>  updated test vectors and a commit message.
>=20
>  Thoughts?

I would like to see an enhanced information in the documentation so that
people remember that lightweight tags are not meant to be constant over
time and that's a bad idea to use them.

What the discussion showed, is that the people don't know about
annotated tags, and git-describe should have a stub of documentation
that points to git-tag(1) so that people learn about it.

Apart from that, it feels fine.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjvjPEACgkQvGr7W6Hudhzs+gCfQGIE1L2mVvLrxA9b8gi9TcQO
ErkAoJl6II237Uq8BCuUltPWv8UFhh5D
=FLR1
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
