From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: error: insufficient permission
Date: Mon, 21 Sep 2009 09:52:21 +0100
Message-ID: <20090921085221.GA4931@bit.office.eurotux.com>
References: <4AB73A07.3020703@bioinf.uni-leipzig.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Cc: git@vger.kernel.org
To: Dominic Rose <dominic@bioinf.uni-leipzig.de>
X-From: git-owner@vger.kernel.org Mon Sep 21 10:59:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpejs-0005rg-Jf
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 10:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537AbZIUI7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 04:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755506AbZIUI7F
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 04:59:05 -0400
Received: from os.eurotux.com ([216.75.63.6]:59708 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755533AbZIUI7E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 04:59:04 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2009 04:59:04 EDT
Received: (qmail 468 invoked from network); 21 Sep 2009 08:52:25 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by 0 with AES128-SHA encrypted SMTP; 21 Sep 2009 08:52:25 -0000
Content-Disposition: inline
In-Reply-To: <4AB73A07.3020703@bioinf.uni-leipzig.de>
User-Agent: Mutt/1.5.20 (2009-08-08)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128871>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2009 at 10:32:07AM +0200, Dominic Rose wrote:
> Hi,
>=20
> may please somebody help me with the following issue. I try to
> checkin changes to a repository I created. Seems like I have some
> permission problems, but I can't figure out whats going wrong:
>=20
> $ git commit -m 'test'
> Created commit 07b3a4a: test
> 1 files changed, 1 insertions(+), 1 deletions(-)
> $ git push
> Counting objects: 8, done.
> Compressing objects: 100% (6/6), done.
> Writing objects: 100% (6/6), 1.56 KiB, done.
> Total 6 (delta 4), reused 0 (delta 0)
> error: insufficient permission for adding an object to repository
> database ./objects
>=20
> fatal: failed to write object
> error: unpack failed: unpacker exited with error code
> To /homes/[...]
> ! [remote rejected] master -> master (n/a (unpacker error))
> error: failed to push some refs to '/homes/[...]'

That's a filesystem permissions problem on the server side. You'll have
to check if your user has permissions to write to the objects subdir of the
repository.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkq3PsUACgkQinSul6a7oB+8VQCfYmNPWivW+KXHypAVOt/nonxV
WD8AoI9m8Mw8mZWxkZ8ZhhXWuwU+L27C
=coUJ
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
