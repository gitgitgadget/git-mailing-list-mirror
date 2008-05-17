From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add color.diff.{header,message} formats
Date: Sat, 17 May 2008 20:34:19 +0200
Message-ID: <20080517183419.GC16746@artemis.madism.org>
References: <1209980316-7340-1-git-send-email-madcoder@debian.org> <20080517130739.GA2326@artemis.madism.org> <7vej80dcdc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="p2kqVDKq5asng8Dg";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 20:35:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxRFS-0004tQ-4d
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 20:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbYEQSeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 14:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbYEQSeX
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 14:34:23 -0400
Received: from pan.madism.org ([88.191.52.104]:36325 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbYEQSeW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 14:34:22 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B5F7B3738D;
	Sat, 17 May 2008 20:34:20 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 64DB63995; Sat, 17 May 2008 20:34:19 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vej80dcdc.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82356>


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 17, 2008 at 06:17:03PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   Hmmm it seems this patch has been somehow lost somewhere, is there
> > anything wrong with it ?
>=20
> It may not break anything, and I did not hear anybody on the list who said
> this breaks soemthing.  But I did not hear anybody on the list who wanted
> to have this except you, either.  At this stage of development, the
> question we should be asking is not if there is anything wrong with it,
> but if there is anything _good_ with it.

  Well the thing is that I (and the few people that made me write the
patch) find git log -p hard to read, because my eyes tend to not see the
separations between two commits. Having a different color for commit
messages help a lot.

> It looks rather widespread compared to a perceived benefit.  Perhaps after
> a refactoring to make the parameter to pretty-print-commit a bit more
> easily extensible, the patch might start looking more promising.  I dunno.

  Fair enough, I wrote the patch for others, I use it on my git, but I'm
not really into doing that amount of work to push it in git.git either =E2=
=80=A6

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBILyUrvGr7W6HudhwRAmFvAJ9lL4MxShMncsrHJNgUnp5uz0L9uwCcDEzq
KPP7Z38i3uyu+pmJ8KRlJH4=
=S4R2
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
