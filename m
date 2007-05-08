From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] remove unnecessary loop
Date: Tue, 8 May 2007 11:39:02 +0200
Message-ID: <20070508093902.GB9007@efreet.light.src>
References: <463FEC07.8080605@gmail.com> <4640015F.1080407@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Cc: git@vger.kernel.org
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 11:39:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlMAI-0001C3-A4
	for gcvg-git@gmane.org; Tue, 08 May 2007 11:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934631AbXEHJjU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 05:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934646AbXEHJjU
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 05:39:20 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:4464 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934631AbXEHJjU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 05:39:20 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.67239;
	Tue, 08 May 2007 11:39:02 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HlM9u-0002Vo-NX; Tue, 08 May 2007 11:39:02 +0200
Content-Disposition: inline
In-Reply-To: <4640015F.1080407@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46556>


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2007 at 12:49:35 +0800, Liu Yubao wrote:
> +#ifdef __CYGWIN__
> +		/*
> +		 * On cygwin, lstat("hello", &st) returns 0 when
> +		 * "hello.exe" exists, so test with open() again.
> +		 */
> +		if (lstat(match, &st) && -1 !=3D (fd =3D open(match, O_RDONLY))) {
> +			struct dir_entry *ent;
> +			close(fd);
> +#else
>  		if (!lstat(match, &st)) {
>  			struct dir_entry *ent;
> -
> +#endif

You seem to have reversed the sense of the test.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQEU2Rel1vVwhjGURAmveAKCh117g+RJjIm+/KA45nhsjVKCuoQCZAQaX
wB3O0usRkkyNlFSplIh0yNs=
=1rnp
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
