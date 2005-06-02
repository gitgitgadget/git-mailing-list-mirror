From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: Re: cg-push protocol proposal [update]
Date: Thu, 02 Jun 2005 11:00:28 -0400
Message-ID: <1117724429.32257.46.camel@jmcmullan.timesys>
References: <1117716883.32257.42.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="=-00yULeFdWYOlBAprIJyi";
	micalg=pgp-sha1;
	protocol="application/pgp-signature"
X-From: git-owner@vger.kernel.org Thu Jun 02 16:59:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddr8g-0002MW-Av
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 16:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVFBPAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 11:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVFBPAj
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 11:00:39 -0400
Received: from mail.timesys.com ([65.117.135.102]:30224 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261166AbVFBPAa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 11:00:30 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Received: from jmcmullan by owa.timesys.com; 02 Jun 2005 11:00:29 -0400
In-Reply-To: <1117716883.32257.42.camel@jmcmullan.timesys>
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
X-Mailer: Evolution 2.0.4-3mdk 
Date: Thu, 2 Jun 2005 10:53:40 -0400
Message-ID: <1117724429.32257.46.camel@jmcmullan.timesys>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: cg-push protocol proposal [update]
thread-index: AcVngt1oQut617a/QL2OSXrq2Mr5Fw==
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-00yULeFdWYOlBAprIJyi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-06-02 at 08:47 -0400, McMullan, Jason wrote:
I'd like to propose the following protocol for 'pushes'. Assume that a
'git-daemon' is the 'server', and is talking on stdin/stdout.


If you want to only do cmp-xchg style head updates, just 'send' the
commit object first (the protocol will request any missing pieces),
then do the 'head <head-id> <old-sha1> <new-sha1>'.=20



--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-00yULeFdWYOlBAprIJyi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCnx8M8/0vJ5szK6kRAr2+AKCm3dBg43636n34WPOYj5c+7Pfz7ACdE+kx
PcwC0WI2mD+iTdBY9bqLRLo=
=BgWc
-----END PGP SIGNATURE-----

--=-00yULeFdWYOlBAprIJyi--
