From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Documentation - pt-BR.
Date: Tue, 6 Oct 2009 11:47:01 +0200
Message-ID: <20091006094701.GG32702@genesis.frugalware.org>
References: <1253730339-11146-1-git-send-email-tfransosi@gmail.com>
 <7vhbuek3ma.fsf@alter.siamese.dyndns.org>
 <20091005100910.GA866@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AMEHvcA7tHoZVye7"
Cc: Junio C Hamano <gitster@pobox.com>,
	Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 06 11:50:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv6g4-0004ij-3f
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 11:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780AbZJFJrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 05:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756727AbZJFJrk
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 05:47:40 -0400
Received: from virgo.iok.hu ([212.40.97.103]:43668 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756503AbZJFJrj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 05:47:39 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F2FBC58083;
	Tue,  6 Oct 2009 11:47:01 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7C5CB44906;
	Tue,  6 Oct 2009 11:47:01 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 9B0F711F0028; Tue,  6 Oct 2009 11:47:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20091005100910.GA866@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129617>


--AMEHvcA7tHoZVye7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2009 at 06:09:10AM -0400, Jeff King <peff@peff.net> wrote:
> > Has anybody actually tried to format this document, either before or af=
ter
> > your patch?
>=20
> No, I didn't, and I should have when I picked up the patch in the first
> place. You are right, asciidoc barfs (both for html and xml generation):
>=20
>   ERROR: gittutorial.txt: line 5: first section must be named NAME
>   ERROR: gittutorial.txt: line 9: second section must be named SYNOPSIS

Ah, there is no language config for pt_BR.

$ ls -1 /etc/asciidoc/lang-*
/etc/asciidoc/lang-de.conf
/etc/asciidoc/lang-en.conf
/etc/asciidoc/lang-es.conf
/etc/asciidoc/lang-fr.conf
/etc/asciidoc/lang-hu.conf
/etc/asciidoc/lang-ru.conf

Once asciidoc will have a lang-pt_BR.conf, we could just use -a
lang=3Dpt_BR and it would happily accept this input.

Thiago, could you make a lang-pt_BR.conf? It's less than 100 lines, so
it should be easy for you. (If you can send it to the asciidoc list
directly, it's even better.)

--AMEHvcA7tHoZVye7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrLEhUACgkQe81tAgORUJaoUwCfcEMtRVh6BzcIDKeIVZgl7Oho
O1YAoJ5sF1nutYXWGVthbQUDVIiAD3HG
=mRyK
-----END PGP SIGNATURE-----

--AMEHvcA7tHoZVye7--
