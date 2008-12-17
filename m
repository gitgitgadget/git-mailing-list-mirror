From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: How do I..?
Date: Thu, 18 Dec 2008 00:49:27 +0100
Message-ID: <20081217234927.GM5691@genesis.frugalware.org>
References: <e1a4c7f60812171516h7b7bb1fem35dfc6f30747a740@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rMBvpMIlSQ3hWZ0K"
Cc: git@vger.kernel.org
To: Dylan Martin <dmartin@sccd.ctc.edu>
X-From: git-owner@vger.kernel.org Thu Dec 18 00:51:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD6AO-0007do-Rb
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 00:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbYLQXta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 18:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbYLQXta
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 18:49:30 -0500
Received: from virgo.iok.hu ([212.40.97.103]:46377 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352AbYLQXt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 18:49:29 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 778E05809C;
	Thu, 18 Dec 2008 00:49:28 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 521EA4465E;
	Thu, 18 Dec 2008 00:49:27 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 05CDF11B862F; Thu, 18 Dec 2008 00:49:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <e1a4c7f60812171516h7b7bb1fem35dfc6f30747a740@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103414>


--rMBvpMIlSQ3hWZ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2008 at 03:16:59PM -0800, Dylan Martin <dmartin@sccd.ctc.ed=
u> wrote:
> Sorry if this is a dumb question.  I've poked around the docs and
> tried the google searches I could think of, but I don't even know what
> kind of search terms one would use in trying to answer this.
>=20
> I'm a sysadmin and I've got a big monolithic git repo of all my
> scripts, documents, etc...  It used to be a CVS repo but I converted
> it to git a while ago.
> Before I switched to git, I played around with SVN a bit, and started
> a few tiny SVN repos for various scripts I was working on.  So, I know
> have one git repo with %90 of my stuff and a handful of SVN repos.
> I'd like to be able to add the SVN repos as subdirectories inside my
> git repo.  I've found lots of pages describing how to convert an SVN
> repo into a _new_ git repo, but I haven't found anything yet about
> importing the contents of an SVN repo as a subdirectory of an
> _existing_ git repo.

I would convert each repo to git, then merge them using subtree merge.
See Documentation/howto/using-merge-subtree.txt.

--rMBvpMIlSQ3hWZ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklJkAcACgkQe81tAgORUJbtMgCfXZlrRHYLvR2aVkJJY7/SOFoe
zb4AnjSWGH9IWBGs+yq0DTrPpDCSfXbr
=Bmrk
-----END PGP SIGNATURE-----

--rMBvpMIlSQ3hWZ0K--
