From: Martin Waitz <tali@admingilde.org>
Subject: Re: non-monotonic index when using http://?
Date: Mon, 21 Aug 2006 11:54:20 +0200
Message-ID: <20060821095419.GK30022@admingilde.org>
References: <20060821084606.GI30022@admingilde.org> <7v64gmwil5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8884J15jRwcBTvu"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 11:54:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF6UP-0004yO-J5
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 11:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWHUJyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 05:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWHUJyW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 05:54:22 -0400
Received: from agent.admingilde.org ([213.95.21.5]:62121 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751817AbWHUJyV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 05:54:21 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GF6U8-0007ZD-2c; Mon, 21 Aug 2006 11:54:20 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64gmwil5.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25791>


--n8884J15jRwcBTvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2006 at 02:20:38AM -0700, Junio C Hamano wrote:
> The "non monotonic index" check is to make sure pack .idx file
> is sane, and it appears that you are getting the error before
> you fetch new pack from the server, which means one of your
> local packs is bad.

You are right, the local archive is corrupted, it works with
a fresh clone.

For some reason, I have a
=2Egit/objects/pack/pack-793a9e93286d6c656941977d2e5b49e28566edcd.idx
without the corresponding .pack file.

Has anybody seen something like this before?


Should GIT bail out earlier when it sees this non-monotonic-index
corruption?
At least, it should not SEGV later...

--=20
Martin Waitz

--n8884J15jRwcBTvu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE6YLLj/Eaxd/oD7IRAq/NAJ4knNtoB6u+qdOFZKHeyMVXgprfggCggaW1
cYMHdXSLuus7/hVNnO9HTsg=
=ymfC
-----END PGP SIGNATURE-----

--n8884J15jRwcBTvu--
