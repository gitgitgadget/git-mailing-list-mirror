From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [ANNOUNCE] Git homepage change
Date: Mon, 5 Jan 2009 20:03:25 +0100
Message-ID: <20090105190325.GW21154@genesis.frugalware.org>
References: <d411cc4a0812151007n1be9ce95h92c8c11592ea5f9d@mail.gmail.com> <20081216114138.GM12856@machine.or.cz> <d411cc4a0901011040h4ab97aag20de54a6e138a4ec@mail.gmail.com> <20090105164001.GA12275@machine.or.cz> <20090105185737.GV21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ujdcy72QwKYdVeZs"
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 20:06:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJulB-0003Vo-GG
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 20:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbZAETD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 14:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023AbZAETD2
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 14:03:28 -0500
Received: from virgo.iok.hu ([212.40.97.103]:49248 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbZAETD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 14:03:27 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id D0126580CA;
	Mon,  5 Jan 2009 20:03:26 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 6AB0C4465E;
	Mon,  5 Jan 2009 20:03:25 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 68B0211B8630; Mon,  5 Jan 2009 20:03:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090105185737.GV21154@genesis.frugalware.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104593>


--Ujdcy72QwKYdVeZs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2009 at 07:57:37PM +0100, Miklos Vajna <vmiklos@frugalware.org> wrote:
> --- a/script/get_authors.sh
> +++ b/script/get_authors.sh
> @@ -1,3 +1,3 @@
>  export GIT_DIR=/Users/schacon/projects/git/.git
>  cd /Users/schacon/projects/git
> -git log --pretty=short --no-merges | git shortlog -n | grep -v -e '^ ' | grep ':' > ../gitscm/config/authors.txt
> +git shortlog -s -n > ../gitscm/config/authors.txt

Err, --no-merges still makes sense, so probably this one would be
better:

diff --git a/script/get_authors.sh b/script/get_authors.sh
index 9aa8c6b..1656da4 100755
--- a/script/get_authors.sh
+++ b/script/get_authors.sh
@@ -1,3 +1,3 @@
 export GIT_DIR=/Users/schacon/projects/git/.git
 cd /Users/schacon/projects/git
-git log --pretty=short --no-merges | git shortlog -n | grep -v -e '^ ' | grep ':' > ../gitscm/config/authors.txt
+git shortlog --no-merges -s -n > ../gitscm/config/authors.txt

--Ujdcy72QwKYdVeZs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkliWX0ACgkQe81tAgORUJag/ACfZRGUQ2dhEGxNOT8LQUs2TXhi
nKkAoKMI2JlbNaaJys4eTdF03L8OYSE/
=HImn
-----END PGP SIGNATURE-----

--Ujdcy72QwKYdVeZs--
