From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 11/15] Add strbuf_vaddf(), use it in strbuf_addf(), and
	add strbuf_initf()
Date: Sat, 28 Jun 2008 04:33:55 +0200
Message-ID: <20080628023355.GH2058@genesis.frugalware.org>
References: <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org> <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org> <25a8ffde9783638080d2b998d8f2579e6ed6c8e7.1214581610.git.vmiklos@frugalware.org> <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org> <d600b25cb1d8f3b6bce12b2a479d4b68b1935dfd.1214581610.git.vmiklos@frugalware.org> <a01223ac1d530522b383fc3e9590ac1a2a5d66ed.1214581610.git.vmiklos@frugalware.org> <67035c91a933887c7cc97fa6d3dda9462594d611.1214581610.git.vmiklos@frugalware.org> <cover.1214581610.git.vmiklos@frugalware.org> <7ea320cd49601de0e331777f82528876101fd946.1214581610.git.vmiklos@frugalware.org> <7vk5gal3my.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EDJsL2R9iCFAt7IV"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 04:34:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCQHA-0008Ow-8z
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 04:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbYF1Cd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 22:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbYF1Cd6
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 22:33:58 -0400
Received: from virgo.iok.hu ([193.202.89.103]:37380 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbYF1Cd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 22:33:57 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 71C911B24FD;
	Sat, 28 Jun 2008 04:33:56 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 80EBF44668;
	Sat, 28 Jun 2008 04:07:02 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id CF2841778012; Sat, 28 Jun 2008 04:33:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk5gal3my.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86693>


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 27, 2008 at 07:00:53PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Do you really think these two patches belong to the series, I seriously
> have to wonder?

Well, no. I was suggested to include it there, but you have reason about
it should be a different series.

> Other than that, I did not see anything obviously wrong in the diff
> between the previous round and this series.

OK, I'll send the main patch without the strbuf_initf() calls, and then
you can just fetch from git/vmiklos.git or drop Dscho's two patches from
my topic branch.

Thanks.

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhloxMACgkQe81tAgORUJaQQQCcDYD4mr4sasFJOocYFwJQ+OkT
5RoAnj+jp0P0pmxvoV7Puy/mwI8nu2K6
=ynR+
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--
