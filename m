From: VMiklos <vmiklos@frugalware.org>
Subject: Re: question about git-submodule
Date: Sun, 15 Jul 2007 17:40:28 +0200
Message-ID: <20070715154028.GI7106@genesis.frugalware.org>
References: <20070715083959.GC999MdfPADPa@greensroom.kotnet.org> <20070715104712.GF2568@steel.home> <20070715105450.GD7106@genesis.frugalware.org> <20070715135057.GI2568@steel.home> <20070715135453.GE7106@genesis.frugalware.org> <20070715140244.GF999MdfPADPa@greensroom.kotnet.org> <20070715142624.GF7106@genesis.frugalware.org> <20070715144835.GI999MdfPADPa@greensroom.kotnet.org> <20070715150540.GH7106@genesis.frugalware.org> <20070715152101.GJ999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jul 15 17:40:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA6DC-0006yl-G5
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 17:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758936AbXGOPkj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 11:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758873AbXGOPkj
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 11:40:39 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:53421 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758711AbXGOPki (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 11:40:38 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IA6D3-0006DX-Cv
	from <vmiklos@frugalware.org>; Sun, 15 Jul 2007 17:40:36 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C1E95176813C; Sun, 15 Jul 2007 17:40:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070715152101.GJ999MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.1
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.1 required=5.9 tests=BAYES_50,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4861]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52566>


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Na Sun, Jul 15, 2007 at 05:21:01PM +0200, Sven Verdoolaege <skimo@kotnet.or=
g> pisal(a):
> > vmiklos@vmobile:~/git/test/client/main$ git submodule add ../../server/=
libfoo/ libfoo
>=20
> Here you add a submodule in the copy of the superproject in client.

correct

> > vmiklos@vmobile:~/git/test/client/main$ git submodule update
> >=20
> > at the end of it, git submodule update does not pull anything, while
> > there are changes both in the main and in the libfoo repo, too
>=20
> The last time you told the superproject about any changes
> in the subprojects was when you added the subproject (in client),
> so as far as the superproject is concerned nothing happened
> in any submodule.  The submodules don't even exist in server.

okay, let me continue the example, then:

vmiklos@vmobile:~/git/test/client2$ git clone ../client/main
Initialized empty Git repository in /home/vmiklos/git/test/client2/main/.gi=
t/
remote: Generating pack...
remote: Done counting 11 objects.
remote: Deltifying 11 objects...
remote:  100% (11/11) done
Indexing 11 objects...
 100% (11/11) done
Resolving 2 deltas...
 100% (2/2) done
remote: Total 11 (delta 2), reused 3 (delta 0)
vmiklos@vmobile:~/git/test/client2$ ls
main/
vmiklos@vmobile:~/git/test/client2$ cd ../client/main/
vmiklos@vmobile:~/git/test/client/main$ git pull
Already up-to-date.
vmiklos@vmobile:~/git/test/client/main$ cd libfoo
vmiklos@vmobile:~/git/test/client/main/libfoo$ git pull
remote: Generating pack...
remote: Done counting 5 objects.
Result has 3 objects.
remote: Deltifying 3 objects...
 100% (3/3) done
Total 3 (delta 0), reused 0 (delta remote: 0)
Unpacking 3 objects...
 100% (3/3) done
* refs/remotes/origin/master: fast forward to branch 'master' of /home/vmik=
los/git/test/server/libfoo/
  old..new: 5979d36..07ceadb
Updating 5979d36..07ceadb
Fast forward
 libfoo.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
vmiklos@vmobile:~/git/test/client/main/libfoo$ cd ../../../client2/main
vmiklos@vmobile:~/git/test/client2/main$ git submodule update

so the submodule exists now on the server and there would be something,
to update in the submodule, but git submodule update seem not to do
anything

thanks,
- VMiklos

--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGmj/se81tAgORUJYRApgVAJ0auk6/jaC6doWrgT7F3/xDOto9mQCfTVmm
rWgIm2H2ftGpDRoAnbKT+S0=
=D7Vc
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--
