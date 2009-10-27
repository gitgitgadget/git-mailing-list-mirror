From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: date change of commit?
Date: Tue, 27 Oct 2009 13:21:56 +0100
Message-ID: <20091027122156.GD6115@genesis.frugalware.org>
References: <e4a904790910250435p3ff50dcfv5c0c6a86c13d17b@mail.gmail.com>
 <vpq1vkrqttt.fsf@bauges.imag.fr>
 <e4a904790910270241g4a165023o30438c5d000b5de4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EEnv9zyGND1dPpWR"
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Alex K <spaceoutlet@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 13:22:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2l3s-0007NG-Lw
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 13:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbZJ0MVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 08:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbZJ0MVx
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 08:21:53 -0400
Received: from virgo.iok.hu ([212.40.97.103]:53058 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918AbZJ0MVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 08:21:53 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 9729D58055;
	Tue, 27 Oct 2009 13:21:56 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 70AB54493A;
	Tue, 27 Oct 2009 13:21:56 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 69C2E11F002B; Tue, 27 Oct 2009 13:21:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <e4a904790910270241g4a165023o30438c5d000b5de4@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131328>


--EEnv9zyGND1dPpWR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2009 at 10:41:47AM +0100, Alex K <spaceoutlet@gmail.com> wrote:
> Thank you. And how would you use git-filter-branch to create another
> branch with a different time stamp? Is it possible to commit under a
> different time stamp than the one provided by your default local time?

You can set GIT_AUTHOR_DATE and GIT_COMMITTER_DATE. Both expect a format
like: "1112911993 -0700" (unix timestamp + timezone info).

--EEnv9zyGND1dPpWR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrm5eQACgkQe81tAgORUJbligCfeA/PqVua7gFK/3qO+ek2GoZN
i48An1wptktC49raff6sz3iGGy7QPche
=NZ4E
-----END PGP SIGNATURE-----

--EEnv9zyGND1dPpWR--
