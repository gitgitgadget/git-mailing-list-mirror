From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Turn the flags in struct dir_struct into a single
	variable
Date: Mon, 16 Feb 2009 22:47:56 +0100
Message-ID: <20090216214756.GG4371@genesis.frugalware.org>
References: <1234727647-18523-1-git-send-email-vmiklos@frugalware.org> <alpine.DEB.1.00.0902152108370.10279@pacific.mpi-cbg.de> <20090215220706.GB4371@genesis.frugalware.org> <alpine.DEB.1.00.0902161317570.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hUen2UJD5eWDKlb+"
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 22:49:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZBLD-000120-1y
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 22:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbZBPVr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 16:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbZBPVr6
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 16:47:58 -0500
Received: from virgo.iok.hu ([212.40.97.103]:52845 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883AbZBPVr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 16:47:58 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 356455818E;
	Mon, 16 Feb 2009 22:47:58 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B014D446A6;
	Mon, 16 Feb 2009 22:47:56 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 96D0A11B877C; Mon, 16 Feb 2009 22:47:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902161317570.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110250>


--hUen2UJD5eWDKlb+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2009 at 01:20:25PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> By having flags represented as bits in the new member variable 'flags',
> it will be easier to use parse_options when dir_struct is involved.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>=20
> 	On Sun, 15 Feb 2009, Miklos Vajna wrote:
>=20
> 	> On Sun, Feb 15, 2009 at 09:13:42PM +0100, Johannes Schindelin
> 	> <Johannes.Schindelin@gmx.de> wrote:
> 	>
> 	> > Well, in my juvenile folly I dreamt of turning this into a proper=20
> 	> > bitfield...
> 	>=20
> 	> Uhm, I think I haven't got what you mean. ;-)
>=20
> 	I meant this...

Aah. That definitely makes the parseopt code shorter, thanks. :-)

--hUen2UJD5eWDKlb+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmZ3wwACgkQe81tAgORUJbPLwCfWQnyqWutgQWSlKeOifhIgIk5
FpAAn0ZLA11bkNSrzk0FNiT/WPBxUFYQ
=qzsx
-----END PGP SIGNATURE-----

--hUen2UJD5eWDKlb+--
