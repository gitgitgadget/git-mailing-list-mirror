From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Guided merge with override
Date: Mon, 16 Jun 2008 11:25:54 +0200
Message-ID: <20080616092554.GB29404@genesis.frugalware.org>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jEKRgRXzaQ2Iuat/"
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 11:26:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8AzD-0007v5-9W
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 11:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757457AbYFPJZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 05:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758264AbYFPJZ4
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 05:25:56 -0400
Received: from virgo.iok.hu ([193.202.89.103]:52180 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756967AbYFPJZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 05:25:56 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5D97A1B2502;
	Mon, 16 Jun 2008 11:25:54 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 78866446A0;
	Mon, 16 Jun 2008 11:05:36 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 1DB8711901DE; Mon, 16 Jun 2008 11:25:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85169>


--jEKRgRXzaQ2Iuat/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2008 at 01:46:38PM +0930, Geoff Russell <geoffrey.russell@gmail.com> wrote:
> I have a two repositories A and B.  B is a tiny subset of the files in
> A and all have been
> modified.   If I do a "git pull B" into A, I get conflicts. I always
> want to resolve these
> by accepting the version from B. Is there a magic "override" switch to
> let me do this?

There was a thread about this:

http://thread.gmane.org/gmane.comp.version-control.git/84047

and then you can do a git pull -s theirs B.

--jEKRgRXzaQ2Iuat/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhWMaIACgkQe81tAgORUJbPNQCgmXAMih7jcXlWz0S7UuO/zkIU
JuEAnipYxfJ8aJcoxiS4RcSzpzo2IymH
=k2Mt
-----END PGP SIGNATURE-----

--jEKRgRXzaQ2Iuat/--
