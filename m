From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [ANNOUNCE] Git homepage change
Date: Mon, 5 Jan 2009 19:57:37 +0100
Message-ID: <20090105185737.GV21154@genesis.frugalware.org>
References: <d411cc4a0812151007n1be9ce95h92c8c11592ea5f9d@mail.gmail.com> <20081216114138.GM12856@machine.or.cz> <d411cc4a0901011040h4ab97aag20de54a6e138a4ec@mail.gmail.com> <20090105164001.GA12275@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xluWKNDh2/FEVhBx"
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 19:59:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJufH-0001ay-4m
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 19:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbZAES5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 13:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbZAES5m
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 13:57:42 -0500
Received: from virgo.iok.hu ([212.40.97.103]:43911 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754699AbZAES5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 13:57:40 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 30EE3580CA;
	Mon,  5 Jan 2009 19:57:39 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 71B864465E;
	Mon,  5 Jan 2009 19:57:37 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 78FEF11B8630; Mon,  5 Jan 2009 19:57:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090105164001.GA12275@machine.or.cz>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104591>


--xluWKNDh2/FEVhBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2009 at 05:40:01PM +0100, Petr Baudis <pasky@suse.cz> wrote:
>   Based on the previous feedback of other developers and my last review
> of git-scm.com, I have changed git.or.cz to redirect to git-scm.com.

Just wondering, why don't you use the -s option of git shortlog in
./script/get_authors.sh?

I mean:

diff --git a/script/get_authors.sh b/script/get_authors.sh
index 9aa8c6b..89948e2 100755
--- a/script/get_authors.sh
+++ b/script/get_authors.sh
@@ -1,3 +1,3 @@
 export GIT_DIR=/Users/schacon/projects/git/.git
 cd /Users/schacon/projects/git
-git log --pretty=short --no-merges | git shortlog -n | grep -v -e '^ ' | grep ':' > ../gitscm/config/authors.txt
+git shortlog -s -n > ../gitscm/config/authors.txt

I suppose fixing up the ruby part after this is not that hard, sadly I
don't speak Ruby myself, so I have no idea where and what to touch. ;-)

--xluWKNDh2/FEVhBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkliWCEACgkQe81tAgORUJaVaQCdGvumlnFhb+fq5FM5onEYmjxD
rVIAoJghp4yRJgRtFNEvWg97J5bIwH+d
=a6dt
-----END PGP SIGNATURE-----

--xluWKNDh2/FEVhBx--
