From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: Compile fix for SCO OPenServer
Date: Wed, 30 Jul 2008 19:44:55 -0400
Message-ID: <20080730234455.GN10399@yugib.highrise.ca>
References: <20071205172125.GF12636@yugib.highrise.ca> <20080730184956.GF10399@yugib.highrise.ca> <7vtze73zwg.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0807301403360.13032@xenau.zenez.com> <20080730204339.GJ10399@yugib.highrise.ca> <alpine.LNX.1.10.0807301522140.13032@xenau.zenez.com> <20080730225635.GM10399@yugib.highrise.ca> <alpine.LNX.1.10.0807301700500.13032@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j3olVFx0FsM75XyV"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 01:46:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOLN2-0007tZ-51
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 01:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735AbYG3Xo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 19:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754033AbYG3Xo5
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 19:44:57 -0400
Received: from yugib.highrise.ca ([205.150.199.213]:42936 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753500AbYG3Xo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 19:44:56 -0400
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id 92EE7111E39;
	Wed, 30 Jul 2008 19:44:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0807301700500.13032@xenau.zenez.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90875>


--j3olVFx0FsM75XyV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Boyd Lynn Gerber <gerberb@zenez.com> [080730 19:30]:
 
> I have m4-1.4.3 at 
> 
> ftp://ftp.zenez.com/pub/zenez/prgms/m4-1.4.3-osr6-all.tar.gz
> 
> I really have to be able to use configure for most of my OpenSource 
> Projects for SCO OS's.
> 
> I made the changes so that most things work with the auto tools.  

I'm not a SCO guru by any means...

I'm just a user on someone else's SCO machine, just trying to make sure
that the software I write is "fairly portable"...

I'm willing to carry a good and useful tool (like git) in my home
directory in that endeavour, but I'm not carrying all of the GNU stack
in my home directory so I can run configure git is a bit much ;-)

> I did a VM install of OpenServer 6 to try things out.  I was able to get 
> your -Wall failure, but once I ran the CC=cc CXX=CC ./configure I was able 
> to run gmake without any errors. I did have to install the M4 from above 
> to get configure to work.  So, the straight out of the box install has to 
> have gnu m4 to run configure. 

So configure.ac must have some magic in it that allows configure to
notice -Wall doesn't work.  You can see what it choose in
config.mak.autogen I think.  But I'm pretty glad for the kbuild style
Makefile in git not requiring autoconf/automake/etc.
 
> -g and -O2 are mutually exclusive.  You can have either one but not both.

Yes, and I think the default to cc matches -g, not -O2, hence my
failures unless setting -O2.

> I do have tcl and tk

I'm sure... I might even find it burried somewhere on this machine too,
but I have no real need for it.

a.

-- 
Aidan Van Dyk                                             Create like a god,
aidan@highrise.ca                                       command like a king,
http://www.highrise.ca/                                   work like a slave.

--j3olVFx0FsM75XyV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFIkPz3uVxNPsxNPScRAqixAKCzT2EzcpVcBZdxNvp8OyYHBYZuLwCggBLM
WXznJvOkKRWPkjdniajj4gE=
=7XoZ
-----END PGP SIGNATURE-----

--j3olVFx0FsM75XyV--
