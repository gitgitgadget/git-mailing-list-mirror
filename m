From: Sebastian Harl <sh@tokkee.org>
Subject: Re: git local repo export
Date: Sun, 8 Jun 2008 15:59:49 +0200
Message-ID: <20080608135949.GE19777@albany.tokkee.org>
References: <20080608134601.GA7020@cvg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LSp5EJdfMPwZcMS1"
Cc: git@vger.kernel.org
To: Cyrill Gorcunov <gorcunov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 16:01:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5LSW-0003Xd-1n
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 16:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbYFHN7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 09:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYFHN7v
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 09:59:51 -0400
Received: from mail.tokkee.org ([212.114.247.92]:33072 "EHLO albany.tokkee.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752536AbYFHN7v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 09:59:51 -0400
Received: by albany.tokkee.org (Postfix, from userid 1000)
	id 2763C364001; Sun,  8 Jun 2008 15:59:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080608134601.GA7020@cvg>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84267>


--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Cyrill,

On Sun, Jun 08, 2008 at 05:46:01PM +0400, Cyrill Gorcunov wrote:
> could someone say me if there is a way to pack git repo in a single
> file somehow?  I mean - sometime I have to move _whole_ git database
> by some media without net access so I can't fetch it. Usually I just
> create tar.gz for .git directory and copy it to some media then unpack
> it in place where I need. But maybe there is some other more elegant
> way exist to do the same?

Imho, that's a fairly elegant way to do that.

You might want to have a look at git-bundle as well. However, that's not
suited for moving the whole repository, but rather to exchange patches
without being able to use any network based protocols.

HTH,
Sebastian

--=20
Sebastian "tokkee" Harl +++ GnuPG-ID: 0x8501C7FC +++ http://tokkee.org/

Those who would give up Essential Liberty to purchase a little Temporary
Safety, deserve neither Liberty nor Safety.         -- Benjamin Franklin


--LSp5EJdfMPwZcMS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIS+XVEFEKc4UBx/wRAvdrAJ9MUFg9d8QfFRMu+jWU8srZuv8+1ACgj0gL
D8EW6NQ6PzKf7uBpnt3j/Qo=
=cTaX
-----END PGP SIGNATURE-----

--LSp5EJdfMPwZcMS1--
