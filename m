From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Which VCS besides git?
Date: Wed, 3 Mar 2010 13:49:01 +0100
Message-ID: <20100303124901.GM27414@genesis.frugalware.org>
References: <201003021455.52483.karlis.repsons@gmail.com>
 <m3y6ialn3z.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Cc: K?rlis Repsons <karlis.repsons@gmail.com>,
	git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 13:49:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmo0l-0004qU-0h
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 13:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab0CCMtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 07:49:05 -0500
Received: from virgo.iok.hu ([212.40.97.103]:41723 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752781Ab0CCMtE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 07:49:04 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 4BCB558098;
	Wed,  3 Mar 2010 13:49:01 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 28D2242F09;
	Wed,  3 Mar 2010 13:49:01 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7FAA01240003; Wed,  3 Mar 2010 13:49:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3y6ialn3z.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141451>


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 02, 2010 at 08:12:22AM -0800, Jakub Narebski <jnareb@gmail.com> wrote:
> I don't know about Darcs, or BitKeeper, or ClearCase, or Perforce.

Darcs does not have immutable history. It uses hashes instead of integer
versions (because of being distributed), but it computes the hash like
this:

http://progetti.arstecnica.it/tailor/browser/vcpx/repository/darcs/source.py#L495

So basically the commit hash does not use the hash of the commit
contents, only the commit date/author/message/etc.

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuOWr0ACgkQe81tAgORUJY6KgCffhAFpXRXe8u+xtXgrin7adWP
myMAn1YneHRI/4AaCzBoiWjIeenqFAq/
=nuLH
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
