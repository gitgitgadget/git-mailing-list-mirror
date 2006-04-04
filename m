From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Mon, 03 Apr 2006 19:07:39 -0700
Message-ID: <1144116459.2303.129.camel@neko.keithp.com>
References: <1143956188.2303.39.camel@neko.keithp.com>
	 <46a038f90604031538x3c94d86ap9f1400427513a3a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JmtGti3QwEmlGgsO5JsX"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 04 04:08:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQaxv-0000oX-Oa
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 04:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWDDCIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 22:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWDDCIF
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 22:08:05 -0400
Received: from home.keithp.com ([63.227.221.253]:46602 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751572AbWDDCIE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 22:08:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 5E48313001F;
	Mon,  3 Apr 2006 19:08:03 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 08155-02; Mon, 3 Apr 2006 19:08:03 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 0487E13001E; Mon,  3 Apr 2006 19:08:02 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id EEDB314001;
	Mon,  3 Apr 2006 19:08:02 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id CEE9A6B4208; Mon,  3 Apr 2006 19:07:39 -0700 (PDT)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90604031538x3c94d86ap9f1400427513a3a7@mail.gmail.com>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18369>


--=-JmtGti3QwEmlGgsO5JsX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-04-04 at 10:38 +1200, Martin Langhoff wrote:

> Looks nifty. Though I thought you'd go for writing a smarter cvsps, so
> that git-cvsimport could take advantage of it.

Once I had the change set information sitting in memory, it was far
easier to just generate the appropriate git commands than attempt to
recreate the cvsps output format...

> Looks like I'll have to brush up on my C to get to play... :-(

Trust me, it wasn't because I wanted to replace git-cvsimport; it's
solely that cvsps was generating complete garbage for most of my
repositories.

My new tool isn't perfect yet; it isn't getting exactly the expected
answers for the postgresql repository, but it's working perfectly for my
X server one.

--=20
keith.packard@intel.com

--=-JmtGti3QwEmlGgsO5JsX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEMdTrQp8BWwlsTdMRAg9bAKCbkAAOxxIv5XZHMjQcSZm76HcRJQCePAOA
vSav8TO/SvlMZnBgRk7RdUU=
=T2Zk
-----END PGP SIGNATURE-----

--=-JmtGti3QwEmlGgsO5JsX--
