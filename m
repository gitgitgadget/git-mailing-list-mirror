From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: shared GIT repos
Date: Tue, 27 Sep 2005 13:59:03 +0400
Message-ID: <20050927135903.6b20a76b.vsu@altlinux.ru>
References: <20050925163201.GA29198@tumblerings.org>
	<4d4586301dca616f42880612fae01492@cream.org>
	<20050926133204.GB21019@pasky.or.cz>
	<pan.2005.09.27.06.35.35.834134@smurf.noris.de>
	<7vu0g70yqg.fsf_-_@assigned-by-dhcp.cox.net>
	<20050927084513.GU31276@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__27_Sep_2005_13_59_03_+0400_hrIVpi31JkH8QguC"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 12:00:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKCF6-0004fA-G6
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 11:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVI0J7S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 05:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVI0J7S
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 05:59:18 -0400
Received: from mivlgu.ru ([81.18.140.87]:38588 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S964887AbVI0J7R (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 05:59:17 -0400
Received: from master.mivlgu.local (master.mivlgu.local [192.168.1.230])
	by mail.mivlgu.ru (Postfix) with SMTP
	id A25928185B; Tue, 27 Sep 2005 13:59:08 +0400 (MSD)
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20050927084513.GU31276@kiste.smurf.noris.de>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9386>

--Signature=_Tue__27_Sep_2005_13_59_03_+0400_hrIVpi31JkH8QguC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 27 Sep 2005 10:45:13 +0200 Matthias Urlichs wrote:

> > If one has commit privileges, then one can already do enough
> > harm to the project without being able to remove objects nor
> > updating a ref with non-fast-forward ref.
> 
> But in that case it's traceable what happened and whodunit.

Don't forget that the user who has rights to invoke git-receive-pack
can set the "author" and "committer" fields in his commits to anything
he wants - unless you check these fields in hooks/update.

--Signature=_Tue__27_Sep_2005_13_59_03_+0400_hrIVpi31JkH8QguC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDORfsW82GfkQfsqIRAuBBAJ9E0aSChGZHJrmIuIVBEuOd5fgMSwCePr18
HLzYz5PVf2bYHoYXVExmqVQ=
=Xlrd
-----END PGP SIGNATURE-----

--Signature=_Tue__27_Sep_2005_13_59_03_+0400_hrIVpi31JkH8QguC--
