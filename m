From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git checkout does not warn about tags without corresponding
	commits
Date: Fri, 2 Jan 2009 16:04:37 +0100
Message-ID: <20090102150437.GN21154@genesis.frugalware.org>
References: <200901021325.58049.henrik@austad.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T2TLPR1GNug0LD4g"
Cc: git@vger.kernel.org
To: Henrik Austad <henrik@austad.us>
X-From: git-owner@vger.kernel.org Fri Jan 02 16:06:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIlb9-0004fs-Lg
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 16:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906AbZABPEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 10:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752414AbZABPEm
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 10:04:42 -0500
Received: from virgo.iok.hu ([212.40.97.103]:34612 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbZABPEl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 10:04:41 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0B91958104;
	Fri,  2 Jan 2009 16:04:39 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id BBFAB4465E;
	Fri,  2 Jan 2009 16:04:37 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 6507D11B8630; Fri,  2 Jan 2009 16:04:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200901021325.58049.henrik@austad.us>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104382>


--T2TLPR1GNug0LD4g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2009 at 01:25:57PM +0100, Henrik Austad <henrik@austad.us> =
wrote:
> I can see that there's no commit for this, but, when there's a tag. I tho=
ught=20
> that a tag was just a commit-sha1 with a name attached, along with some t=
ag=20
> info and a signature. Can you really create a tag without a commit?

Sure, you can tag any object type (blob, tree, commit or tag), but
usually only commits are tagged.

See for example the 'junio-gpg-pub' tag in git.git which tags a blob.

--T2TLPR1GNug0LD4g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkleLQUACgkQe81tAgORUJYLQACgju8pGtZBf2wa28UJ+3m2PZ4J
eZQAn04VpXO5njbuQB6O3rN75DKVOp+s
=oLyY
-----END PGP SIGNATURE-----

--T2TLPR1GNug0LD4g--
