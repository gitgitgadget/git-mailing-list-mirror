From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [BUG] git archive formats and dashdash
Date: Thu, 10 Dec 2009 23:22:58 +0100
Message-ID: <20091210222258.GQ4114@genesis.frugalware.org>
References: <20091210212636.GA27722@Knoppix>
 <7v1vj2a3ik.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 23:23:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIrPc-00055F-Lf
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 23:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761901AbZLJWWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 17:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761900AbZLJWWx
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 17:22:53 -0500
Received: from virgo.iok.hu ([212.40.97.103]:48859 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761859AbZLJWWw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 17:22:52 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0889358084;
	Thu, 10 Dec 2009 23:22:59 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 0B52942F0A;
	Thu, 10 Dec 2009 23:22:58 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 561191240014; Thu, 10 Dec 2009 23:22:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v1vj2a3ik.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135044>


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2009 at 02:05:39PM -0800, Junio C Hamano <gitster@pobox.com=
> wrote:
> Good catch.  Is this a regression between 1.6.5 and the current code?

Ah, you version is much shorter. :)

I think it was introduced by 0f4b377c (git-archive: infer output format
=66rom filename when unspecified, 2009-09-14), so it was introduced
before 1.6.5.

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkshdMIACgkQe81tAgORUJZyeQCgqaIZ2DX+t8GQmfYCe3Krwp90
dhQAnAvnsuIp8lt5zR9gPpPsPUZLH9GH
=eSjx
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
