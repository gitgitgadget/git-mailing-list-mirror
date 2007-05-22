From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] rename dirlink to gitlink.
Date: Tue, 22 May 2007 07:59:39 +0200
Message-ID: <20070522055939.GG5412@admingilde.org>
References: <20070521200828.GC5412@admingilde.org> <e7bda7770705211612w3ce1b7dew8d48f1ddeb7d100e@mail.gmail.com> <7vodkdbvmk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JoJCGVnM/36AiBh+"
Cc: Torgil Svensson <torgil.svensson@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 07:59:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqNPR-0000uR-7X
	for gcvg-git@gmane.org; Tue, 22 May 2007 07:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431AbXEVF7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 01:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756420AbXEVF7n
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 01:59:43 -0400
Received: from mail.admingilde.org ([213.95.32.147]:35061 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242AbXEVF7k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 01:59:40 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HqNPH-0000FT-KU; Tue, 22 May 2007 07:59:39 +0200
Content-Disposition: inline
In-Reply-To: <7vodkdbvmk.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48070>


--JoJCGVnM/36AiBh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 21, 2007 at 04:32:51PM -0700, Junio C Hamano wrote:
> As an internal symbol, S_IFDIRLNK makes _much_ more sense than
> S_IFGITLINK, exactly because it is a mixture of S_IFDIR and
> S_IFLNK.

But then we also should be consequent and rename the entire
low-level plumbing to dirlink.  I don't see a reason to keep
both.

For me the S_ macro names are about the file type which is represented
by them.  The fact that dirlinks/gitlinks are represented as
DIR + LNK is nice but not so important that we have to name the
macro that way.

--=20
Martin Waitz

--JoJCGVnM/36AiBh+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUobLj/Eaxd/oD7IRAsEmAJwLDOLd4UYHgQGV7HyJp/3oAVvpygCfeVBQ
UB829yIvO3pZ/Twx9be+TH4=
=TqYL
-----END PGP SIGNATURE-----

--JoJCGVnM/36AiBh+--
