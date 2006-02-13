From: Eduardo Pereira Habkost <ehabkost@mandriva.com>
Subject: git-svnimport -d and -D options (was Re: [PATCH] Use a relative path for SVN importing)
Date: Mon, 13 Feb 2006 18:52:43 -0200
Message-ID: <20060213205243.GF4323@duckman.conectiva>
References: <1139672651713-git-send-email-cbiesinger@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Mon Feb 13 21:47:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8kbF-0003L7-UT
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 21:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWBMUrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 15:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWBMUrG
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 15:47:06 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:47489 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964864AbWBMUrF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 15:47:05 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id D051736D29;
	Mon, 13 Feb 2006 18:47:03 -0200 (BRST)
Received: from perninha.conectiva.com.br ([127.0.0.1])
 by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01233-05; Mon, 13 Feb 2006 18:47:03 -0200 (BRST)
Received: from duckman.conectiva.com.br (duckman.conectiva [10.0.2.193])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 05BDA36D25;
	Mon, 13 Feb 2006 18:47:02 -0200 (BRST)
Received: by duckman.conectiva.com.br (Postfix, from userid 500)
	id 81FE63FB7; Mon, 13 Feb 2006 18:52:43 -0200 (BRST)
To: Christian Biesinger <cbiesinger@web.de>
Content-Disposition: inline
In-Reply-To: <1139672651713-git-send-email-cbiesinger@web.de>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new at conectiva.com.br
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16080>


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 11, 2006 at 04:44:11PM +0100, Christian Biesinger wrote:
> The absolute path (with the leading slash) breaks SVN importing, because =
it then
> looks for /trunk/... instead of /svn/trunk/... (in my case, the repositor=
y URL
> was https://servername/svn/)

I've hit this bug today, and fortunately I've found the fix from
Christian. Thanks! :)

I am wondering if this bug was the initial reason why the -d and -D
options where added to git-svnimport.

Is there another real reason why the -d and -D options exist in
git-svnimport?

The documentation for the options say that the "wrong" option will die
with 40x, but the commit message[1] says something about "internal server
error". I don't know which one is right.

Mathias, couldn't be the errors you described in the commit message
related to this bug?

[1] http://www.kernel.org/git/?p=3Dgit/git.git;a=3Dcommit;h=3D25f6f325d7a8f=
7cb686a9ffd9fa2c00b3aa85a60

--=20
Eduardo

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD8PGbcaRJ66w1lWgRAlDVAKCjT4uG/6XCWFckRYKF0+tc2L5dDwCfZNcB
PXvOb9g1aiADyZSlbMYZbjU=
=2Puh
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
