From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] Fix sloppy Getopt::Long.
Date: Fri, 8 May 2009 11:28:14 -0700
Message-ID: <robbat2.20090508T182516.673117391Z@orbis-terrarum.net>
References: <1241547374-6737-1-git-send-email-robbat2@gentoo.org> <7vljpazuyg.fsf@alter.siamese.dyndns.org> <20090506064949.GB29479@dcvr.yhbt.net> <20090506161309.GC10702@curie-int> <7v63gew3dp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 20:28:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2UoI-0004fE-2j
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 20:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667AbZEHS2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 14:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759876AbZEHS2U
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 14:28:20 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:39575 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762054AbZEHS2T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 14:28:19 -0400
Received: (qmail 19522 invoked from network); 8 May 2009 18:28:17 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Fri, 08 May 2009 18:28:17 +0000
Received: (qmail 32475 invoked by uid 10000); 8 May 2009 11:28:14 -0700
Content-Disposition: inline
In-Reply-To: <7v63gew3dp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118624>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2009 at 10:24:50AM -0700, Junio C Hamano wrote:
> >> +			{ '' =3D> \$_stdin, 'stdin' =3D> \$_stdin,
> >> +			  %cmt_opts, %fc_opts, } ],
> > I confirm that it does correctly set the $_stdin variable (tested
> > briefly).
> Wait a minute.  Do you mean we would also need the above "explicit empty
> argument sets $_stdin"?  Wasn't it your earlier analysis/claim that the
> caller already takes care of a lone "-"?
I'd originally considered a single '-' as an argument not an option,
meaning stdin, not being processed within the getopt framework, but
instead being handled later.

> Or do you mean "yes it would also work but it is not necessary"?
Using Eric's change makes it explicit what is expected: Passing
'--stdin' is the same as passing '-'.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkoEeb4ACgkQPpIsIjIzwizdFwCgkCmDNfXzeukAo60Xpx9KHmgu
pyMAoOxu6XyPLVAWv3fUJ5f8t1a4F2Ln
=z3yO
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
