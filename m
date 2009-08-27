From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Thu, 27 Aug 2009 22:56:05 +0000
Message-ID: <robbat2-20090827T225507-944514463Z@orbis-terrarum.net>
References: <1250579093-40706-1-git-send-email-tom@mojombo.com>
 <12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com>
 <20090825184525.GC23731@coredump.intra.peff.net>
 <7vprajmp16.fsf@alter.siamese.dyndns.org>
 <7v1vmycfhd.fsf@alter.siamese.dyndns.org>
 <7vy6p69j6a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 28 01:03:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgnzf-0000NU-My
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 01:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbZH0XCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 19:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbZH0XCu
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 19:02:50 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:48357 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751300AbZH0XCu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 19:02:50 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Aug 2009 19:02:49 EDT
Received: (qmail 21448 invoked from network); 27 Aug 2009 22:56:10 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (CAMELLIA256-SHA encrypted) ESMTPS; Thu, 27 Aug 2009 22:56:10 +0000
Received: (qmail 27418 invoked by uid 10000); 27 Aug 2009 22:56:05 -0000
Content-Disposition: inline
In-Reply-To: <7vy6p69j6a.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127231>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2009 at 05:47:41PM -0700, Junio C Hamano wrote:
> After upload-pack successfully finishes its operation, post-upload-pack
> hook can be called for logging purposes.
+1 from me.

I'm actually going to scrap my previous pre-upload-pack hook and rebase
it off this, because I see a lot of commonality (I was passing in
have/want via stdin too).

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkqXDwUACgkQPpIsIjIzwiwyuACg/eE5L0L+OFewOblNxPuxFyXc
/U8AoOK49U38nUgIiDeyEL1RJxKxODUI
=UOTj
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
