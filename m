From: <ncrfgs@tin.it>
Subject: extracting the history of a single file as a new project [Was: Re:
 making a branch with just one file and keeping its whole]
Date: Tue, 22 Jul 2008 04:14:57 +0200
Message-ID: <20080722041457.52120c2f@mail.tin.it>
References: <20080721061804.223f7801@mail.tin.it>	<loom.20080721T161926-61@post.gmane.org>	<alpine.DEB.1.00.0807211907270.8986@racer>	<279b37b20807211122w3a1e0687wc84693bd95689326@mail.gmail.com>	<alpine.DEB.1.00.0807211937390.8986@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2zfIFiAZJZXwsx0fGuDjtRV";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: madewokherd@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 04:16:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL7Q2-0000oW-JA
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 04:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbYGVCPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 22:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754524AbYGVCPB
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 22:15:01 -0400
Received: from vsmtp4.tin.it ([212.216.176.224]:42487 "EHLO vsmtp4.tin.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125AbYGVCPA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 22:15:00 -0400
Received: from mail.tin.it (82.51.73.70) by vsmtp4.tin.it (8.0.016.5)
        id 485F5E75016797D4; Tue, 22 Jul 2008 04:14:58 +0200
In-Reply-To: <alpine.DEB.1.00.0807211937390.8986@racer>
References: <20080721061804.223f7801@mail.tin.it>	<loom.20080721T161926-61@post.gmane.org>	<alpine.DEB.1.00.0807211907270.8986@racer>	<279b37b20807211122w3a1e0687wc84693bd95689326@mail.gmail.com>	<alpine.DEB.1.00.0807211937390.8986@racer>
In-Reply-To: <alpine.DEB.1.00.0807211937390.8986@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89423>

--Sig_/2zfIFiAZJZXwsx0fGuDjtRV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Jul 2008 20:39:45 +0200
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> However, I think that the OP was talking about something completely=20
> different: extracting the history of a single file as a new branch.

Exactly, but rather than a new branch I'd like to start a new project.

I've just realized the original subject name could have been a bit
misleading; I took it from the description a guy on #git@freenode has
given of what he thought I wanted to do, but probably I didn't explain
myself properly at that time.


> This will not start a new branch, which is what I presume you want to
> do. The "correct" (as in: probably the best) way to do it is to make a
> new directory, initialize a new git repository in it, and when you
> have something, push that branch into the other repository.

As far as I could understand, that screencast demonstrates how to create
empty branches in Git; in other words branches that are not derivatives
of your main branches, but entirely new projects.

In my case I don't want to start an entirely new project, but rather
start a new project from a file of an existing project and keeping his
history.


In the screencast, the author creates an empty branch to store the
website code in for my project, so he doesn't have to store it as a
subdirectory of his main project.

What I want to do, I think, is kinda different.


Let's say we are at commit #3000, I have this content I want to start a
new project from, which has been put in three different files:

path1/filename1 from commit 1 to commit 1000
path2/filename1 from commit 1001 to commit 2000
path2/filename2 from commit 2001 to commit 3000

In the meanwhile path1/filename1 has been created on commit 2500 with
path1/filename1 having nothing to do with the new project I'd like to
start.


My first idea to accomplish what I'd like to do, was to use the ouput of
`git-log -p --follow path2/filename2` with another git command; on
#git@freenode I've been suggested to use git-clone and
git-filter-branch.

Both from search results on the web and from the man pages, I've found
examples of git-filter-branch usage which aim to delete just one file
(or a small group of files) from the existing project's history.

What I'd like to do instead is to keep just one file which has been
renamed a couple of time.


On #git I've been also told to use also another combination of commands
which included git-commit-tree but I haven't managed to understand what
they meant. Another combination of commands included git-am instead.


Any suggestion is welcome. :)

--Sig_/2zfIFiAZJZXwsx0fGuDjtRV
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkiFQqEACgkQ8UJozN0kXhlDbACfWvWTCPNyATmRcM1L9oA69Kdv
4igAoPaidnTIhif1iJDxDO7g7kfkuExt
=FLH3
-----END PGP SIGNATURE-----

--Sig_/2zfIFiAZJZXwsx0fGuDjtRV--
