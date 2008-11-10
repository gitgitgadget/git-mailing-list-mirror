From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Install issues
Date: Mon, 10 Nov 2008 18:51:23 +0100
Message-ID: <20081110175123.GV24201@genesis.frugalware.org>
References: <20081110121739.15f77a01@pc09.procura.nl> <20081110113924.GR24201@genesis.frugalware.org> <20081110173101.3d76613b@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GOnUD/NgUx2c77Ud"
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Nov 10 18:52:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzawL-0006c9-Fu
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 18:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202AbYKJRv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 12:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbYKJRv0
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 12:51:26 -0500
Received: from virgo.iok.hu ([193.202.89.103]:45678 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753934AbYKJRv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 12:51:26 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 764C458095;
	Mon, 10 Nov 2008 18:51:24 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5CB454465E;
	Mon, 10 Nov 2008 18:51:24 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 205F2119019E; Mon, 10 Nov 2008 18:51:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081110173101.3d76613b@pc09.procura.nl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100535>


--GOnUD/NgUx2c77Ud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2008 at 05:31:01PM +0100, "H.Merijn Brand" <h.m.brand@xs4al=
l.nl> wrote:
> --- Makefile.org	2008-11-10 17:29:53.000000000 +0100
> +++ Makefile	2008-11-10 17:29:39.000000000 +0100
> @@ -1329,6 +1329,10 @@ check-sha1:: test-sha1$X
>  	./test-sha1.sh
> =20
>  check: common-cmds.h
> +	@`sparse </dev/null 2>/dev/null` || (\
> +	    echo "The 'sparse' command is not available, so I cannot make the '=
check' target" ;\
> +	    echo "Did you mean 'make test' instead?" ;\
> +	    exit 1 )
>  	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done

Please read Documentation/SubmittingPatches, your patch lacks a signoff
and a commit message.

Thanks.

--GOnUD/NgUx2c77Ud
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkYdJsACgkQe81tAgORUJZMqgCgoKldWxQ3Y9hIIu0PeIYjObQx
6ioAnjdBlR2tqzn5577gobhaIiBEM8hs
=a9G0
-----END PGP SIGNATURE-----

--GOnUD/NgUx2c77Ud--
