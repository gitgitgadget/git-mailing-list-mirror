From: Pierre Habouzit <madcoder@artemis.madism.org>
Subject: Re: [PATCH] bundle, fast-import: detect write failure
Date: Thu, 10 Jan 2008 19:18:38 +0100
Message-ID: <20080110181838.GC27808@artemis.madism.org>
References: <874pdmhxha.fsf@rho.meyering.net> <alpine.LSU.1.00.0801101204120.31053@racer.site> <87myrdhnn5.fsf@rho.meyering.net> <alpine.LSU.1.00.0801101234580.31053@racer.site> <87hchlhm3k.fsf@rho.meyering.net> <20080110162526.GB27808@artemis.madism.org> <87lk6xftdn.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ALfTUftag+2gvp1h";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 19:19:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD1zi-0002aI-2L
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 19:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbYAJSSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 13:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754225AbYAJSSl
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 13:18:41 -0500
Received: from pan.madism.org ([88.191.52.104]:48763 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212AbYAJSSk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 13:18:40 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6198E233;
	Thu, 10 Jan 2008 19:18:39 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 86A57D33F; Thu, 10 Jan 2008 19:18:38 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@artemis.madism.org>,
	Jim Meyering <jim@meyering.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87lk6xftdn.fsf@rho.meyering.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70078>


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2008 at 06:05:56PM +0000, Jim Meyering wrote:
> Pierre Habouzit <madcoder@artemis.madism.org> wrote:
> ....
> >> On the other hand, if that write failure is truly ignorable,
> >> a mindless minimalist :-) might argue that it's best just to
> >> omit the syscall.
> >
> >   And leak a file descriptor :)
>=20
> Not that mindless.
> The *write* syscall, not the close.
> I would never suggest eliminating the close.

  oh *oops*
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHhmF+vGr7W6HudhwRApKPAJ9BVM1B93N2K4F7NHOAPMN3RYVywwCfUbFy
USedK3WQfKfAbRQAVU1cjV8=
=SGI4
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
