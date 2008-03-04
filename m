From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Make builtin-reset.c use parse_options.
Date: Tue, 04 Mar 2008 10:45:28 +0100
Message-ID: <20080304094527.GB32019@artemis.madism.org>
References: <47C98472.8000002@gmail.com> <7vir05x2di.fsf@gitster.siamese.dyndns.org> <1b46aba20803020437p2a5128a5wfee3e98c32c1a610@mail.gmail.com> <7vbq5xqetq.fsf@gitster.siamese.dyndns.org> <1b46aba20803030607v726a6ba1y49ca8524e09c6eae@mail.gmail.com> <20080303170706.GA23210@artemis.madism.org> <7vwsojfn2v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="p4qYPpj5QlsIQJ0K";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 10:46:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWTis-0002Y9-DP
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 10:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbYCDJpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 04:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbYCDJpb
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 04:45:31 -0500
Received: from pan.madism.org ([88.191.52.104]:33823 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753167AbYCDJpa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 04:45:30 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 22D262F8C4;
	Tue,  4 Mar 2008 10:45:29 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 608B02BEB49; Tue,  4 Mar 2008 10:45:28 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwsojfn2v.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76057>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2008 at 10:40:40PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > On Mon, Mar 03, 2008 at 02:07:57PM +0000, Carlos Rica wrote:
> >> On Sun, Mar 2, 2008 at 5:18 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> >> >  Although "--h" still favors "--hard" over "--help":
> >> >
> >> >         $ ./git-reset --h
> >> >         HEAD is now at c149184...
> >> >
> >>=20
> >> Pierre, is there a way to give preference to --help over --hard
> >> when someone uses --h in command line?
> >
> >   The problem is that --help (and --help-all for the matter) are "magic"
> > arguments that parse-options is not aware of when it deals with
> > abbreviations.
>=20
> Yeah, I do not know if this really matters in real life, though.

  I'm not sure either, that's why I didn't really bothered to _write_
the patch, I just mentioned how to do that if someone cares enough.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHzRo3vGr7W6HudhwRAkEiAJ91nMmtJAe4UHd+KwDx9OyzWdWeGwCdEFVS
fu4uCbsMmWCjwXM+YI4evhE=
=ZZQF
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
