From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: why no "git fetch --dry-run" ?
Date: Fri, 21 Nov 2008 23:18:26 +0100
Message-ID: <20081121221826.GM21815@genesis.frugalware.org>
References: <ee2a733e0811211341j1e49fad7o64577605951fa5c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Cc: Git Mailing List <git@vger.kernel.org>
To: Leo Razoumov <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 23:19:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3eLp-0008KV-4o
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 23:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbYKUWS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 17:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbYKUWS3
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 17:18:29 -0500
Received: from virgo.iok.hu ([193.202.89.103]:41228 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbYKUWS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 17:18:29 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1D622580AB;
	Fri, 21 Nov 2008 23:18:27 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C2E0F44698;
	Fri, 21 Nov 2008 23:18:28 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7C9DC119019E; Fri, 21 Nov 2008 23:18:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ee2a733e0811211341j1e49fad7o64577605951fa5c0@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101544>


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 21, 2008 at 04:41:57PM -0500, Leo Razoumov <slonik.az@gmail.com> wrote:
> I am curious why there is "git push --dry-run" and no "git fetch
> --dry-run" nor "git pull --dry-run". It would make sense to keep
> push/pull/fetch as symmetric as possible.
> For example, I just want to see which branches, if any, changed on a
> remote repository since my last fetch. "git fetch -v --dry-run" would
> be handy in this case.

Actually fetch - at a core level - isn't symmetric to push, the protocol
is completely different. I haven't checked the source, but I suppose
that the push protocol has "dry run" support, while the fetch one
doesn't have.

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkknM7IACgkQe81tAgORUJZgiQCgnE6MCF/MY0wXlLuKzLSpIkOf
eQIAoKpVknD9/nw+PyuiULR7xF7HmpEq
=FBnT
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--
