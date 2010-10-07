From: Christian Dietrich <stettberger@dokucode.de>
Subject: [ANNOUNCE] metagit 0.1.2
Date: Thu, 07 Oct 2010 22:20:09 +0200
Message-ID: <86k4lteow6.fsf@peer.zerties.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 22:25:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3x1f-0004KZ-4f
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 22:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102Ab0JGUZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 16:25:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:36606 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098Ab0JGUZH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 16:25:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P3x1U-0004Gx-7m
	for git@vger.kernel.org; Thu, 07 Oct 2010 22:25:04 +0200
Received: from peer.zerties.org ([188.40.33.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 22:25:04 +0200
Received: from stettberger by peer.zerties.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 22:25:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: peer.zerties.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:tv7ouOwOrf+PcHVzbjiveEtaejI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158452>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,
I wanted to announce my project metagit[1], which I started a few weeks
ago. It is a python program, which allows you to manage many scm
repositories at once, e.g. pull all repositories, that are matched by a
given regex. Before you can use it you have to define a set of
repositories. This can either be accomplished by defining them one by
one, or you can use a repo lister.=20

One good example of a repo lister is the SSHDir lister. It performs a
find on a remote server within a given directory and adds all the
repositories there to your repo set. There is also a lister to get all
your github repos (or gitorious).

But metagit isn't narrowed to git as scm. At this point it also gives
you the possibility to use mercurial as scm backend and you can clone
your damned fucked SVN repo with git-svn (with the externals, if you wish).

The configuration is just a python script, where you can use the power
of python to define your repositories, and no package is used that isn't
shipped with python (at minimum python 2.5 (it workes perfectly with
debian stable)).=20

You can also define policies which of your defined repos (or listers)
show up on a machine (this is done by a regex against the fqdn).

If you have any wish what metagit should also be able to do, write me a
mail, write a issue at github or fork it :-)

greetz didi

[1] http://github.com/stettberger/metagit
=2D-=20
(=CE=BB x . x x) (=CE=BB x . x x) -- See how beatiful the lambda is
No documentation is better than bad documentation
=2D- Das Ausdrucken dieser Mail wird urheberrechtlich verfolgt.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJMrit6AAoJEBQksfbRvb+ahVwP/AijeWDZ0TiAAMukz8pIOxSi
bIUxEssO8M6uPmy7fJgqNer+nhx2m3vhBgppMBcWHnbGZvTf+hq+I2EPa5H0Gi5G
bhwjoChPgyilXu7O6dCEuhztR0+UVoAhOZQbQ8PZ1rTNvAZTOgd3GFx/Pe1D9QOs
nK+1Eviik5JHhV0A2XHHOw4zGEIbKA/YYMqRqnOQHfYHN9pAzkwdTVeEIg01iLs4
UIkcedzzpDMxQimDMyZAq+mzUPJu7GjzZ5hyALCu7QhRB/5OQjkE4wbNgPdjLM1y
5QyIHa+sdGCTCJYlPxP3VNUyHlyOpcmEgcAW2N0ZcUa6ksDATM5ziaQXIBwtUKhf
kHoAIGWCaNBG5c7R2wHipK2lX/CItA8HWfntoqWmm261k7h66r75PwB0dv71YHDz
V2qCPUJmklghinYdqYipGI4I6LMPAgTMHxL32nEI2jyl2Ef7jLdQhKgW3/96cFXZ
Te0ZAKBSYgBiYa3Qzb8Kezge3X0TwA07v+/Fo4GgF+d1fVP7SmfoqrtRQckJPaHa
wwW1wqkA+PEQNLikvliA6sSawm5/hAbYZ37/IW3nsP0r1TcJMc/z92y8LE9Nyed9
Wiw/YDGCuGk8L+z938u+i4aGuoNNhwJumxPhGjSCvlgGXsB8txZ3uXSDX0ZZVelM
vWY9jellYj505ysXrGZl
=YpeT
-----END PGP SIGNATURE-----
--=-=-=--
