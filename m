From: Andres Freund <andres@anarazel.de>
Subject: Re: Bug?  git svn fetch: "unable to create temporary sha1 filename /home/andres/git/public/crystal.git/objects/96: File exists"
Date: Tue, 30 Sep 2008 02:23:28 +0200
Message-ID: <200809300223.29133.andres@anarazel.de>
References: <200809300210.00285.andres@anarazel.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2973721.T5sVFfhzfJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 02:24:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkT2f-0004Ny-FL
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 02:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbYI3AXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 20:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbYI3AXc
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 20:23:32 -0400
Received: from mail.anarazel.de ([217.115.131.40]:36131 "EHLO smtp.anarazel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbYI3AXb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 20:23:31 -0400
Received: from alap2.localnet (e178198138.adsl.alicedsl.de [85.178.198.138])
	by smtp.anarazel.de (Postfix) with ESMTPSA id 734B6248001
	for <git@vger.kernel.org>; Tue, 30 Sep 2008 02:23:30 +0200 (CEST)
User-Agent: KMail/1.10.1 (Linux/2.6.27-rc7; KDE/4.1.2; x86_64; ; )
In-Reply-To: <200809300210.00285.andres@anarazel.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97062>

--nextPart2973721.T5sVFfhzfJ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 30 September 2008, Andres Freund wrote in "Bug?  git svn fetch:=
=20
"unable to create temporary sha1 filename=20
/home/andres/git/public/crystal.git/objects/96: File exists"":
> First failing svn fetch:
>         M       plugins/cscript/pycore/coremod.cpp
>         M       plugins/cscript/cspython/pytocs.cpp
> error: unable to create temporary sha1 filename
> /home/andres/git/public/crystal.git/objects/96: File exists
>
> fatal: Unable to add /tmp/Git_zIIUG4 to database
> hash-object -w --stdin-paths: command returned error: 128
>
> error closing pipe: Bad file descriptor at
> /usr/local/libexec/git-core/git-svn line 0
> error closing pipe: Bad file descriptor at
> /usr/local/libexec/git-core/git-svn line 0
After repacking the repository the problem is gone. Really rather strange.

Andres

--nextPart2973721.T5sVFfhzfJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjhcYEACgkQporPraT14igSkwCgo0cseOXTqUZ/OCpjkSRU8AEA
thoAn2dNNDTT03t/ZRIRDNO6ZeEXPta3
=39en
-----END PGP SIGNATURE-----

--nextPart2973721.T5sVFfhzfJ--
