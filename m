From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] allow commands to be executed in submodules
Date: Sun, 20 May 2007 23:08:27 +0200
Message-ID: <20070520210827.GI5412@admingilde.org>
References: <20070520153908.GF5412@admingilde.org> <20070520181433.GA19668@steel.home> <7vhcq7mjxn.fsf@assigned-by-dhcp.cox.net> <20070520204801.GH5412@admingilde.org> <20070520205933.GD25462@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 23:08:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpsdm-00034m-6t
	for gcvg-git@gmane.org; Sun, 20 May 2007 23:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586AbXETVI3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 17:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756621AbXETVI3
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 17:08:29 -0400
Received: from mail.admingilde.org ([213.95.32.147]:50444 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756586AbXETVI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 17:08:28 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hpsdf-0005ox-Fn; Sun, 20 May 2007 23:08:27 +0200
Content-Disposition: inline
In-Reply-To: <20070520205933.GD25462@steel.home>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47918>


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, May 20, 2007 at 10:59:33PM +0200, Alex Riesen wrote:
> Is there multiple places? Is it hard to create a specific function out
> of a generic one? (which can be used from other places and your
> specific can't and we would need the generic one anyway).

you can add a specific new function for submodules, dropping the
nice property of child_process that you only have to initialize a few
fields and then can run the command.

> "Generic" is not about "multiple places". Generic is about "general"
> as opposite to "specific". Gives you flexibility and wider application
> range.

Generic code and abstractions only make sense when they are _useful_.
Lets not overengineer it.  If we later see that we need more, then
so be it.  KISS.

But now lets go on and don't discuss about such details.
I'm happy if I can run commands in submodules and don't care about the
actual code.

--=20
Martin Waitz

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGULjLj/Eaxd/oD7IRAhWkAJ4kXUbufNfv5cHTx2Iwzn7OtkMsCACfcq1j
kBbfVEam4tTMRfC3dFqRkbA=
=vx4/
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
