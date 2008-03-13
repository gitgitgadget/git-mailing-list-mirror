From: martin f krafft <madduck@madduck.net>
Subject: Re: git-svn clone duplicates content
Date: Thu, 13 Mar 2008 12:36:21 +0100
Message-ID: <20080313113621.GA13221@piper.oerlikon.madduck.net>
References: <20080313095215.GA22241@piper.oerlikon.madduck.net> <20080313113013.GA31522@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 13 12:37:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZlkD-0005qW-0W
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 12:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbYCMLga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 07:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbYCMLga
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 07:36:30 -0400
Received: from clegg.madduck.net ([82.197.162.59]:45125 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbYCMLg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 07:36:29 -0400
Received: from wall.oerlikon.madduck.net (84-75-158-163.dclient.hispeed.ch [84.75.158.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id A5D1DA8305;
	Thu, 13 Mar 2008 12:36:22 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 6257C9F18E;
	Thu, 13 Mar 2008 12:36:21 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 169614430; Thu, 13 Mar 2008 12:36:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080313113013.GA31522@atjola.homenet>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.91.2/6221/Thu Mar 13 11:10:51 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77062>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> [2008.03.13.1230 +0100=
]:
> The "fetch" part of git-svn will create a master branch if it
> doesn't exist(*) and makes it point to whatever branch was last
> fetched. In your case, it seems that the last change on the svn
> side was to create tag 0.4-5, so master pointed to that one.

That makes sense.

> As things are, a "git reset --hard remotes/trunk" (or wherever you
> want your master to descend from) is pretty mandatory after git
> svn clone. The example in the man page "kind of" mentions that.
> ;-)

I saw that a bit later too. Thanks for the explanation regardless!

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"and if the cloud bursts, thunder in your ear
 you shout and no one seems to hear
 and if the band you're in starts playing different tunes
 i'll see you on the dark side of the moon."
                                                   -- pink floyd, 1972
=20
spamtraps: madduck.bogus@madduck.net

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH2RG1IgvIgzMMSnURAjAGAJ95dF3BqhiUrB4uihxH3YGM0w6TsgCfRyEK
eDMY1SPiv1a3+wc0vGDrpJQ=
=/aq0
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
