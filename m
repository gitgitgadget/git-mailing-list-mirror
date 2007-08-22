From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] Clarify role of init command in git-submodules
	documentation
Date: Wed, 22 Aug 2007 15:48:25 +0200
Message-ID: <20070822134825.GA14589@piper.oerlikon.madduck.net>
References: <20070817103652.GK1070MdfPADPa@greensroom.kotnet.org> <11875937841178-git-send-email-madduck@madduck.net> <7vd4xhsybm.fsf@gitster.siamese.dyndns.org> <20070817103652.GK1070MdfPADPa@greensroom.kotnet.org> <11875937841178-git-send-email-madduck@madduck.net> <20070820075459.GY1070MdfPADPa@greensroom.kotnet.org> <20070821180218.GA14739@piper.oerlikon.madduck.net> <20070821202516.GL1070MdfPADPa@greensroom.kotnet.org> <20070821210349.GA16702@piper.oerlikon.madduck.net> <20070822083032.GN1070MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
To: Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org,
	hjemli@gmail.com, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 15:48:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INqZV-00046J-AP
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 15:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756890AbXHVNsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 09:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756869AbXHVNsa
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 09:48:30 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:44278 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581AbXHVNs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 09:48:29 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 57015895F54;
	Wed, 22 Aug 2007 15:48:27 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 00771-07; Wed, 22 Aug 2007 15:48:27 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 9DC7B895D92;
	Wed, 22 Aug 2007 15:48:26 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 0A3599F16A;
	Wed, 22 Aug 2007 15:48:26 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id CC88343F4; Wed, 22 Aug 2007 15:48:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070822083032.GN1070MdfPADPa@greensroom.kotnet.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56380>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Sven Verdoolaege <skimo@kotnet.org> [2007.08.22.1030 +0200]:
> > > I suppose this is implicit in the git submodule man page,
> > > but this is only true if you actually want to use git submodule to
> > > work with the submodules.
> >
> I meant that the rest of my sentence could probably be
> implicitly understood.

Ah. Okay, well, I'd say since this is the git-submodule manpage, we
can assume that they want to work with git-submodule.

> > Is it? I tried this and after cloning a repo with submodules, it
> > created the submodule directories alright, but it did not
> > actually check them out/populate them, so they were empty.
>=20
> Some people have been doing this manually or have homegrown
> scripts. Not that you should mention those options here.

Ok.

> > You're missing something like "... unless the submodule is already
> > registered, in which case it won't be overwritten", right?
>=20
> Something like that, yes.

Consider it done. Patch forthcoming, though probably not tonight,
I also want to give others more time to comment.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"of course the music is a great difficulty.
 you see, if one plays good music, people don't listen,
 and if one plays bad music people don't talk."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGzD6pIgvIgzMMSnURApAxAJ9GwQUHuG8exlgkv9iTqcpkR8bXhgCfcHgi
ndc9L5YFpQvnsQxRUuFbBSQ=
=AaWV
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
