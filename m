From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Git call graph
Date: Sat, 12 Jul 2008 02:47:14 +0200
Message-ID: <20080712004714.GL10347@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LkL3iLkxWcC48rNm"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 12 02:48:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHTHa-0006rr-JU
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 02:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554AbYGLArQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 20:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755451AbYGLArQ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 20:47:16 -0400
Received: from virgo.iok.hu ([193.202.89.103]:51249 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755394AbYGLArP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 20:47:15 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B3D211B24FA
	for <git@vger.kernel.org>; Sat, 12 Jul 2008 02:47:14 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 54D8E4465E
	for <git@vger.kernel.org>; Sat, 12 Jul 2008 02:12:28 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 27E88177001C; Sat, 12 Jul 2008 02:47:14 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88211>


--LkL3iLkxWcC48rNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I just did this for fun, if you are busy, you can stop reading now,
this mail is not about anything important. :-)

I thought it would worth a try to make a graph about git calls, when a
script calls an other git program. I tracked two types of calls:

- when a bultin calls an other builtin (like git reset calls
  git read-tree)

- when a script calls a builtin (like git merge-resolve calls
  git write-tree)

Here is the result:

http://vmiklos.hu/pic/git-call-graph.png

The code that was used to generate the graph is available at the 'graph'
branch of git://repo.or.cz/git/vmiklos.git.

If you check out that branch, you can simply type 'make' to generate the
picture, or you can read some minimal documentation (README).

And now I should stop playing with it, in fact it took much more time
than I expected. ;-)

--LkL3iLkxWcC48rNm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh3/xIACgkQe81tAgORUJba/wCfesUWxY8FX0vljbicBCXLDXt8
SvYAoJqFsn47kg7twx/yaqJ4zUEuheE7
=2p+C
-----END PGP SIGNATURE-----

--LkL3iLkxWcC48rNm--
