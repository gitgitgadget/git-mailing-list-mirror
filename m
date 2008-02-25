From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-email automatic --to detection?
Date: Mon, 25 Feb 2008 21:50:46 +0100
Message-ID: <20080225205046.GX31441@genesis.frugalware.org>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org> <20080225143959.GS31441@genesis.frugalware.org> <200802250908.21182.jgoerzen@complete.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kgh2FNDOY+603hGA"
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:52:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTkIp-0000Zy-Dh
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 21:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759258AbYBYUut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 15:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759160AbYBYUut
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 15:50:49 -0500
Received: from virgo.iok.hu ([193.202.89.103]:10763 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759067AbYBYUus (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 15:50:48 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0F9741B2524;
	Mon, 25 Feb 2008 21:50:47 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7EDCB44668;
	Mon, 25 Feb 2008 21:48:16 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5DBF411901F5; Mon, 25 Feb 2008 21:50:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200802250908.21182.jgoerzen@complete.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75066>


--Kgh2FNDOY+603hGA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2008 at 09:08:20AM -0600, John Goerzen <jgoerzen@complete.o=
rg> wrote:
> But that must be applied locally.  It is not pulling that down from the=
=20
> remote repo before the send, which is the point of all this.

right. this is a pro and a con: you can't run darcs send -a while you're
offline but you can do a git format-patch while offline. and of course
_once_ you have to configure sendemail.to manually.

- VMiklos

--Kgh2FNDOY+603hGA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHwyome81tAgORUJYRAt5bAKCpP1x0Sjlyso50a+84fs26w64yOwCffMM3
hOVN7Irbe+fV4opJ6N1GxVQ=
=veEA
-----END PGP SIGNATURE-----

--Kgh2FNDOY+603hGA--
