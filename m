From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: symbolic link management in git-archive
Date: Thu, 27 Mar 2008 12:40:24 +0100
Message-ID: <20080327114024.GR14567@genesis.frugalware.org>
References: <loom.20080327T112740-539@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BeJB7u2HmcNo1GIz"
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 12:41:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeqTi-0001ht-Mt
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 12:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068AbYC0Lk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 07:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758320AbYC0Lk2
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 07:40:28 -0400
Received: from virgo.iok.hu ([193.202.89.103]:43894 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754231AbYC0Lk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 07:40:27 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0B4951B25FF;
	Thu, 27 Mar 2008 12:40:25 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E5FD844697;
	Thu, 27 Mar 2008 12:37:20 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B50681190543; Thu, 27 Mar 2008 12:40:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <loom.20080327T112740-539@post.gmane.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78345>


--BeJB7u2HmcNo1GIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 27, 2008 at 11:29:28AM +0000, Sergio Callegari <sergio.callegari@gmail.com> wrote:
> I guess the answer is "no" or "not yet", but is there a way to tell the zip
> backend of git-archive to follow symbolic links rather than to store them?

how would that handle a '. -> foo' symlink? following such a recursion
would lead to an infinite loop, i guess.

--BeJB7u2HmcNo1GIz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFH64eoe81tAgORUJYRApoVAJ9HBQd8iWX4S1lEuih+ynaPrWkgQgCgqZvM
8vowKTsev6ydcShMhKW6lg8=
=R1MN
-----END PGP SIGNATURE-----

--BeJB7u2HmcNo1GIz--
