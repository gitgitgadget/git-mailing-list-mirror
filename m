From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: Compile fix for SCO OPenServer
Date: Wed, 30 Jul 2008 20:11:12 -0400
Message-ID: <20080731001112.GP10399@yugib.highrise.ca>
References: <20071205172125.GF12636@yugib.highrise.ca> <20080730184956.GF10399@yugib.highrise.ca> <7vtze73zwg.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0807301403360.13032@xenau.zenez.com> <20080730204339.GJ10399@yugib.highrise.ca> <alpine.LNX.1.10.0807301522140.13032@xenau.zenez.com> <20080730225635.GM10399@yugib.highrise.ca> <alpine.LNX.1.10.0807301700500.13032@xenau.zenez.com> <20080730234455.GN10399@yugib.highrise.ca> <alpine.LNX.1.10.0807301747160.13032@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KCXyoJ//PRyfzsc9"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 02:12:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOLmG-00061c-3d
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 02:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760988AbYGaALO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 20:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762093AbYGaALO
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 20:11:14 -0400
Received: from yugib.highrise.ca ([205.150.199.213]:43232 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762053AbYGaALN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 20:11:13 -0400
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id 1EC18111E39;
	Wed, 30 Jul 2008 20:11:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0807301747160.13032@xenau.zenez.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90882>


--KCXyoJ//PRyfzsc9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Boyd Lynn Gerber <gerberb@zenez.com> [080730 20:00]:
 
> So what do you think we need to have.  I really do not see the need for 
> __OPENSERVER__.  Do you?

No, I think I saw that long ago, when I said:
> Sorry, a bit premature on my end...    

With SNPRINTF_RETURNS_BOGUS and NO_MKDTEMP and CFLAGS set for make, I
don't need any source code changes to compile on SCO.

And as long as I have GNU bash and diff available, the test suite passes
as well.  Well, all except for t9500-gitweb-standalone-no-errors.sh:
	[Thu Jul 31 00:08:46 2008] gitweb.perl: -T and -B not implemented on filehandles at /u/aidan/git/t/trash directory/../../gitweb/gitweb.perl line 2444.

Perl claims:
	This is perl, v5.8.8 built for i586-pc-sysv5

But again, I don't plan on running gitweb on this SCO box either...


a.
-- 
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--KCXyoJ//PRyfzsc9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFIkQMfuVxNPsxNPScRAlZiAKCZRN0ovGPN/L79EKTT8ASTr2m2JwCfYEu3
h/Po6Oa8tAZjnMRzgBm4isA=
=ZhDn
-----END PGP SIGNATURE-----

--KCXyoJ//PRyfzsc9--
