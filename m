From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: [PATCH] git-grep: Add ability to limit directory recursion
Date: Tue, 6 May 2008 20:47:19 -0400
Message-ID: <20080507004719.GJ18081@yugib.highrise.ca>
References: <1210094304-2450-1-git-send-email-aidan@highrise.ca> <m3iqxr54uy.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 02:48:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtXpL-0005lz-GM
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 02:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbYEGArX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 20:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbYEGArX
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 20:47:23 -0400
Received: from yugib.highrise.ca ([205.150.199.213]:59558 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbYEGArW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 20:47:22 -0400
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id 892BA111E39;
	Tue,  6 May 2008 20:47:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <m3iqxr54uy.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81395>


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Jakub Narebski <jnareb@gmail.com> [080506 20:34]:
> Aidan Van Dyk <aidan@highrise.ca> writes:
> 
> > This add a -R <limit> option to git-grep which will limit the depth of the
> > directories recursed when git is doing a grep.
> > 
> > This allows you to do something like:
> >         git grep -R 1 <pattern>
> > and see only the results of the grep on files in the current directory.
> > 
> > It defaults to a limit of "0" which disables the limiting.
> 
> Nice idea, although I'm not sure if we shouldn't borrow "-maxdepth"
> option from GNU find and friends...

Good idea - I hadn't thought of that, but I like it better.

a.
-- 
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFIIPwXuVxNPsxNPScRAghNAJ4zuwb8R6ANJCUDMluBccuir1/IXACgtcE1
+yRFkM7Kzq+JJiBiQY3wEiw=
=IeRs
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--
