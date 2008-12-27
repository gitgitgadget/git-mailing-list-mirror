From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Fix commit message after push?
Date: Sat, 27 Dec 2008 22:19:44 +0100
Message-ID: <20081227211944.GZ21154@genesis.frugalware.org>
References: <2729632a0812271313l74e9bb85l857a3ad3a3f0d8d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SR0DFWOzPg+ymaCV"
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sat Dec 27 22:21:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGgap-00027t-DN
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 22:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbYL0VTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 16:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbYL0VTq
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 16:19:46 -0500
Received: from virgo.iok.hu ([212.40.97.103]:44515 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbYL0VTp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 16:19:45 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 88F555808C;
	Sat, 27 Dec 2008 22:19:44 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 300FB4465E;
	Sat, 27 Dec 2008 22:19:44 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4A12911B8630; Sat, 27 Dec 2008 22:19:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2729632a0812271313l74e9bb85l857a3ad3a3f0d8d8@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104019>


--SR0DFWOzPg+ymaCV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 27, 2008 at 01:13:46PM -0800, skillzero@gmail.com wrote:
> Is there a way to fix a commit message after the commit has already
> pushed to someone else? I typed the wrong commit message then I pushed
> to the remote repository before realizing it. I tried git commit
> --amend to fix it in my local repository, but it rejects the
> subsequent push. I somewhat understand why it's rejecting it (my
> --amend rewrote history and now they are out-of-sync), but I was
> wondering if there is a general way to handle situations like this
> with git.

git push -f

http://git.or.cz/gitwiki/GitFaq#head-c1dc263aca199d347f28872249e6c1f5d519a2df

--SR0DFWOzPg+ymaCV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklWm/AACgkQe81tAgORUJZ/vQCfcJwoTlnnfMzqvrbfkIC6Blr3
Ry8AnRkzz6alFvJosk9BjIQ1HnPy2xWk
=TODL
-----END PGP SIGNATURE-----

--SR0DFWOzPg+ymaCV--
