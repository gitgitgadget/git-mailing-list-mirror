From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] parse-opt: migrate fmt-merge-msg.
Date: Tue, 30 Sep 2008 23:16:45 +0200
Message-ID: <20080930211643.GA16879@artemis.corp>
References: <1222595139-32087-1-git-send-email-madcoder@debian.org> <1222595139-32087-2-git-send-email-madcoder@debian.org> <20080929163523.GC18340@spearce.org> <20080930084019.GB11453@artemis.corp> <20080930191014.GH21310@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="a8Wt8u1KmwUX3Y2C";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 23:18:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkmc2-0003kc-JE
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 23:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026AbYI3VQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 17:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754304AbYI3VQy
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 17:16:54 -0400
Received: from pan.madism.org ([88.191.52.104]:33918 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754273AbYI3VQw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 17:16:52 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 106A63B8B9;
	Tue, 30 Sep 2008 23:16:50 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 243F794A270; Tue, 30 Sep 2008 23:16:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080930191014.GH21310@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97163>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2008 at 07:10:14PM +0000, Shawn O. Pearce wrote:
> Pierre Habouzit <madcoder@debian.org> wrote:
> > On Mon, Sep 29, 2008 at 04:35:23PM +0000, Shawn O. Pearce wrote:
> > > Pierre Habouzit <madcoder@debian.org> wrote:
> > > > Also fix an inefficient printf("%s", ...) where we can use write_in=
_full.
> > >=20
> > > Near as I can tell, this is based upon a merge commit in next.
> >=20
> > Hmm I've always sent my patches this way, and I believe you can git am
> > -3 them on top of master easily. I can send you the updated series if
> > you want.
>=20
> I'd appreciate an updated series if you can send it.  am -3 isn't
> "easily" applying it.  Here I define "easy" as "the patch applies
> without me needing to resolve conflicts":
>=20
>  $ git co -b ph/parseopt master
>  $ git am -3 -s X
>  Applying: parse-opt: migrate fmt-merge-msg.
>  error: patch failed: builtin-fmt-merge-msg.c:5
>  error: builtin-fmt-merge-msg.c: patch does not apply
>  Using index info to reconstruct a base tree...
>  Falling back to patching base and 3-way merge...
>  CONFLICT (content): Merge conflict in builtin-fmt-merge-msg.c
>  Recorded preimage for 'builtin-fmt-merge-msg.c'
>  Failed to merge in the changes.
>  Patch failed at 0001.
>  When you have resolved this problem run "git am -3 --resolved".
>  If you would prefer to skip this patch, instead run "git am -3 --skip".
>  To restore the original branch and stop patching run "git am -3 --abort".

Okay, I will then, but FWIW it means that when you'll try to merge this
in next it'll conflict at that time, so I'm not sure there's a huge win
for you at that point.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjilzoACgkQvGr7W6Hudhx1HwCfQ2nTxGpPl/vSWIBGo8ezsT+8
VYUAnRLSS0g8V9CT+jQRMiO0IGnjWIP/
=yt/h
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
