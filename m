From: martin f krafft <madduck@madduck.net>
Subject: Re: inconsistent detached worktree handling: several bugs
Date: Wed, 7 May 2008 20:32:39 +0100
Message-ID: <20080507193239.GA5588@lapse.madduck.net>
References: <20080505160643.GA28318@lapse.madduck.net> <8aa486160805070115k676b03a6s59d3a74d48d44254@mail.gmail.com> <20080507180637.GA2282@lapse.madduck.net> <8aa486160805071220v50026bf9ga5a8ae4314bffadc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 07 21:33:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtpOP-0000Qv-SF
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 21:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759330AbYEGTco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 15:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760453AbYEGTcn
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 15:32:43 -0400
Received: from clegg.madduck.net ([82.197.162.59]:57847 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931AbYEGTcm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 15:32:42 -0400
Received: from lapse.madduck.net (chiu.ifi.unizh.ch [130.60.75.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id C2B87A8420;
	Wed,  7 May 2008 21:32:34 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id CA2374FD87; Wed,  7 May 2008 20:32:39 +0100 (IST)
Content-Disposition: inline
In-Reply-To: <8aa486160805071220v50026bf9ga5a8ae4314bffadc@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/7050/Wed May  7 20:48:51 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81474>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Santi B=E9jar <sbejar@gmail.com> [2008.05.07.2020 +0100]:
> So it is run inside the worktree ( $workingdir/.fgits/zsh ) and the
> repository is inside the worktree.

Doh, I should engage brain more often. :)

So this makes sense. What does not make sense is that git-diff
doesn't appear to work with any of this...

> I read it in this list but I don't find it now. Maybe because of
> the special handling of .git does not apply to an arbitrary path.

I think it actually does. But in my case, it's also .gitignored in
addition.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
it is better to have loft and lost
than to never have loft at all.
                                                       -- groucho marx
=20
spamtraps: madduck.bogus@madduck.net

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIIgPXIgvIgzMMSnURAmIMAJ9q1yJaM/8hiYqdZOUsEjlwVjy4hQCfe57s
YP1EKXakC8SGhDDln9maWBA=
=vsp/
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
