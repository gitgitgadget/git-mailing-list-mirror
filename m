From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: How does Git know which files no longer needed during upgrade?
Date: Wed, 4 Mar 2009 00:30:58 +0100
Message-ID: <20090303233058.GE4371@genesis.frugalware.org>
References: <22318714.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sbic9+IwCnOfztd0"
Cc: git@vger.kernel.org
To: dealmaker <vinkhc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 00:32:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lee6H-0007wc-OS
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 00:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854AbZCCXbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 18:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754745AbZCCXbD
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 18:31:03 -0500
Received: from virgo.iok.hu ([212.40.97.103]:58032 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754177AbZCCXbB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 18:31:01 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0653358110;
	Wed,  4 Mar 2009 00:31:00 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id F1B02446E6;
	Wed,  4 Mar 2009 00:30:58 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id DFA7511B877E; Wed,  4 Mar 2009 00:30:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <22318714.post@talk.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112173>


--sbic9+IwCnOfztd0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2009 at 01:51:14PM -0800, dealmaker <vinkhc@gmail.com> wrote:
>   I am going to upgrade software to a newer version in my main trunk, I
> decide to download the newer version and checkout the main trunk and  copy
> it over to my main trunk.

Do you mean the 'master' branch by 'main trunk'? Trunk is not in Git's
terminology.

> If the older version has some files that are no
> longer in the newer version, how does git determine whether to keep those
> files or not?  Does it even notify me that those files are no longer needed?

First, I think storing upstream code (that you will never touch) in
version control is a horrible idea, but if you really do it, I would do
something like:

cd /path/to/copy
rm -rf *
cp -a /path/to/new/version/* .
git add -A
git commit -m 'update foo to 2.0'

That will add/update/delete files as you would expect.

--sbic9+IwCnOfztd0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmtvbIACgkQe81tAgORUJZKnQCeKkk7m2Zc+LlHCTx1PzKV8grp
oWIAn30r93KDc+CUHXs7LDd/Ej2nEcH0
=ifxr
-----END PGP SIGNATURE-----

--sbic9+IwCnOfztd0--
