From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Thu, 06 Apr 2006 15:19:28 -0700
Message-ID: <1144361968.2303.288.camel@neko.keithp.com>
References: <20060405174247.GA29758@blackbean.org>
	 <1144262498.2303.231.camel@neko.keithp.com>
	 <20060406181502.GA15741@blackbean.org>
	 <1144354356.2303.270.camel@neko.keithp.com>
	 <46a038f90604061451m4522e3f3qceae2331751a307c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eO7XC2MYexaMWY+G0ndV"
Cc: keithp@keithp.com, Jim Radford <radford@blackbean.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 07 00:27:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRcwe-0004Yw-0v
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 00:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWDFW1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 18:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWDFW1N
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 18:27:13 -0400
Received: from home.keithp.com ([63.227.221.253]:17681 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S932193AbWDFW1M (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 18:27:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 72E44130020;
	Thu,  6 Apr 2006 15:27:11 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 19104-05; Thu, 6 Apr 2006 15:27:11 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id EC78913001F; Thu,  6 Apr 2006 15:27:10 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 76B0514001;
	Thu,  6 Apr 2006 15:27:10 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 75CBD6B428C; Thu,  6 Apr 2006 15:19:29 -0700 (PDT)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90604061451m4522e3f3qceae2331751a307c@mail.gmail.com>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18485>


--=-eO7XC2MYexaMWY+G0ndV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-04-07 at 09:51 +1200, Martin Langhoff wrote:

>  - file additions were recorded with one-commit-per-file. I am not
> sure how rcs is recording these, but hte user does enter a common
> message at "commit" time. Perhaps the file addition action could be
> ignored then?

If the log message is identical, and the dates are in-range, parsecvs
"should" put the adds in the same commit.=20

>  - some tags made on a branch show up in HEAD. This may be due to
> partial-tree branches, but I am not sure.

Finding branch points is not perfect; it's complicated by bizzarre
behaviour when adding files and casual CVS changes which make precise
branch points hard to detect. Can I get at this repository to play with?
I'd like to see if we can't get the branch point detection more
accurate.

--=20
keith.packard@intel.com

--=-eO7XC2MYexaMWY+G0ndV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBENZPwQp8BWwlsTdMRAqpsAKCb8cwKx2v96KczFeieN4wX+GVR7gCgjGlF
Sj4XJiWZ6yoPtZBGV/3yIck=
=YrJ5
-----END PGP SIGNATURE-----

--=-eO7XC2MYexaMWY+G0ndV--
