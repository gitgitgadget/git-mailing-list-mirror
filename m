From: martin f krafft <madduck@madduck.net>
Subject: Re: git-push [--all] and tags
Date: Sun, 7 Oct 2007 10:36:36 +0100
Message-ID: <20071007093636.GA3568@lapse.madduck.net>
References: <20071006160506.GA28238@lapse.madduck.net> <47083035.7070904@vilain.net> <alpine.LFD.0.999.0710061814310.23684@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Vilain <sam@vilain.net>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 11:37:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeSZP-0003ym-Hu
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 11:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbXJGJgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 05:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbXJGJgv
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 05:36:51 -0400
Received: from clegg.madduck.net ([82.197.162.59]:38058 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbXJGJgu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 05:36:50 -0400
Received: from lapse.madduck.net (213-202-149-158.bas503.dsl.esat.net [213.202.149.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 1F54EBE88;
	Sun,  7 Oct 2007 11:36:38 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id CDA484FD44; Sun,  7 Oct 2007 10:36:36 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710061814310.23684@woody.linux-foundation.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4491/Sun Oct  7 04:29:59 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60173>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Linus Torvalds <torvalds@linux-foundation.org> [2007.10.07.0226=
 +0100]:
> Well, I agrewe with Martin, and I think you missed his point.

(he did)

> Hmm? I do agree with "git push" as it now stands has a lot of warts,=20
> although I don't really agree with the people who want to change the=20
> default behavior.

So am I right if I say that all the logic should really be happening
in send-pack and that push is really just an interface when it comes
to selecting the refs to push, so it should basically feed through
the options and refs, meaning that send-pack should get --tags and
--shared as well?

Or should push enumerate all refs needed and pass them directly to
send-pack, effectively making send-pack's --all option obsolete?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"time flies like an arrow. fruit flies like a banana."
                                                       -- groucho marx
(panda eats shoots and leaves)
=20
spamtraps: madduck.bogus@madduck.net

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHCKikIgvIgzMMSnURAm1zAKCE+pBIzF//DKWz/PfEaC2FR02wxgCfRcr7
xPslZzqOvSgankh2zPooR2U=
=P2Kc
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
