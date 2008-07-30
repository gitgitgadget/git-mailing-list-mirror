From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: [PATCH] Add NO_RSYNC to allow building without rsync
Date: Wed, 30 Jul 2008 16:49:48 -0400
Message-ID: <20080730204948.GK10399@yugib.highrise.ca>
References: <20080730185225.GG10399@yugib.highrise.ca> <7vod4f3zfu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sl5MdczEF/OU2Miu"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 22:50:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOIdG-0007Su-FX
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 22:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbYG3Utt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 16:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbYG3Utt
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 16:49:49 -0400
Received: from yugib.highrise.ca ([205.150.199.213]:41006 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbYG3Uts (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 16:49:48 -0400
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id 6CDEE111E39;
	Wed, 30 Jul 2008 16:49:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vod4f3zfu.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90851>


--sl5MdczEF/OU2Miu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Junio C Hamano <gitster@pobox.com> [080730 16:11]:

> > I came about this because SCO OpenServer doesnt' have mkdtemp.  But I never use
> > rsync, so making it optional was an easy fix.
> 
> Perhaps "make NO_MKDTEMP=YesPlease" is a much better fix for your
> particular environment?

Yes, I found that out after...

> The patch is seriously whitespace damaged, in any case.

Ooops... copy-n-paste from git-format-patch|more on some crappy sco terminal
through a screen session...  I guess someone in there translated tabs to
spaces...

a.

-- 
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--sl5MdczEF/OU2Miu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFIkNPsuVxNPsxNPScRAja6AJsH2NswKx2Gq+WuzIraic9Y3ABGFACgm7Eh
GXglndKTn1QkpGbtfRHy7y0=
=xnQu
-----END PGP SIGNATURE-----

--sl5MdczEF/OU2Miu--
