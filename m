From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (Mar 2009, #05; Tue, 17)
Date: Wed, 18 Mar 2009 08:47:34 +0100
Message-ID: <20090318074734.GI3817@genesis.frugalware.org>
References: <7vbprzo0si.fsf@gitster.siamese.dyndns.org> <20090318055222.GA17128@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H88uUF932U8Oj0a6"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 08:49:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjqWb-0001vr-WD
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 08:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbZCRHrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 03:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbZCRHrl
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 03:47:41 -0400
Received: from virgo.iok.hu ([212.40.97.103]:45703 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbZCRHrk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 03:47:40 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id BE808580C8;
	Wed, 18 Mar 2009 08:47:35 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B92A644783;
	Wed, 18 Mar 2009 08:47:34 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 63425153C003; Wed, 18 Mar 2009 08:47:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090318055222.GA17128@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113596>


--H88uUF932U8Oj0a6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2009 at 01:52:22AM -0400, Jeff King <peff@peff.net> wrote:
> I am inclined to leave it as-is. The other sane option would be
> converting it to use NONEG, as Miklos suggested.
>=20
> Doing it right would probably mean adding a "this option is the opposite
> of what we would usually do" flag to parse-options which would display
> the option as "no-<option>" in the usage, and would reverse clearing and
> setting the bit (i.e., --empty-directory would clear the HIDE_DIRECTORY
> bit and --no-empty-directory would set it). But I don't think it is
> worth the work to add a negatable version of an option that has never
> existed before and which nobody has requested to use.

ACK, I'm fine with the current shape of the topic branch.

I did not think about the user confusion regarding usage when I
suggested NONEG.

--H88uUF932U8Oj0a6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknApxYACgkQe81tAgORUJZaawCff7eeo46cnflIVw0Is1DOhkRV
AUoAn2H1TgqDcuq9hOvKJHuKQiMc94uL
=Bpps
-----END PGP SIGNATURE-----

--H88uUF932U8Oj0a6--
