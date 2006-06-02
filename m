From: Keith Packard <keithp@keithp.com>
Subject: Re: Importing Mozilla CVS into git
Date: Thu, 01 Jun 2006 20:39:53 -0700
Message-ID: <1149219593.5521.34.camel@neko.keithp.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149204044.27695.38.camel@neko.keithp.com>
	 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
	 <1149214075.5521.31.camel@neko.keithp.com>
	 <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UZ1KWnRgbiuqeV9MQY0q"
Cc: keithp@keithp.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 05:40:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm0WL-00078J-CW
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 05:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWFBDkM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 23:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWFBDkL
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 23:40:11 -0400
Received: from home.keithp.com ([63.227.221.253]:39944 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751194AbWFBDkJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jun 2006 23:40:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 8D166130023;
	Thu,  1 Jun 2006 20:40:07 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 24738-01-2; Thu, 1 Jun 2006 20:40:07 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 468C013001E; Thu,  1 Jun 2006 20:40:07 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 3FA8114001;
	Thu,  1 Jun 2006 20:40:07 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 9E525542C0; Thu,  1 Jun 2006 20:39:54 -0700 (PDT)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21138>


--=-UZ1KWnRgbiuqeV9MQY0q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-06-01 at 22:36 -0400, Jon Smirl wrote:

> Did I see that you can use CVS client tools to manipulate a git
> repository? Mozilla has a lot of users on other OSes besides Linux. It
> would be nice to change the core server over to git and leave these
> other users running their existing tools.

It's possible, but I would not encourage people to use this for anything
other than passive monitoring of the code; CVS semantics are really too
weak to express the capabilities of the git repository, so changes made
through CVS will lose information.

Git runs fine on Windows these days; asking people to use reasonable
tools to contribute to the project doesn't seem crazy to me.

--=20
keith.packard@intel.com

--=-UZ1KWnRgbiuqeV9MQY0q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEf7MJQp8BWwlsTdMRAuuwAKCKOifKxeSEWOQEJkcdGU6+PPMzzACfQJwP
P59uj3uzWr+IR3FCGy7nQa4=
=fsG5
-----END PGP SIGNATURE-----

--=-UZ1KWnRgbiuqeV9MQY0q--
