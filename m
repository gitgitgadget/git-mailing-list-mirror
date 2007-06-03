From: Simon Hausmann <simon@lst.de>
Subject: Re: git-p4import.py robustness changes
Date: Sun, 3 Jun 2007 15:11:27 +0200
Message-ID: <200706031511.31157.simon@lst.de>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <0EDF1E14-3682-4B1E-A7D2-F82388F752AA@slamb.org> <7vzm3inisa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1267630.EBWRK5EZod";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 15:11:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hups4-0000to-RJ
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 15:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761462AbXFCNLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 09:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761836AbXFCNLk
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 09:11:40 -0400
Received: from verein.lst.de ([213.95.11.210]:37252 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761462AbXFCNLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 09:11:37 -0400
Received: from luria.lan (p57bb3950.dip0.t-ipconnect.de [87.187.57.80])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l53DBVo6021920
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Sun, 3 Jun 2007 15:11:32 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <7vzm3inisa.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48989>

--nextPart1267630.EBWRK5EZod
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 02 June 2007 23:33:25 Junio C Hamano wrote:
> Scott Lamb <slamb@slamb.org> writes:
> > On May 31, 2007, at 4:53 PM, Junio C Hamano wrote:
> >> Actually, my preference is to have a "patch 0" before all of the
> >> above, that demotes git-p4import to contrib/ hierarchy.  Having
> >> no access to p4 managed repositories (nor much inclination to
> >> get one), I can never test nor maintain it myself, so it is just
> >> crazy for me to be the maintainer for it.
> >
> > Will do. What does that mean for Documentation/git-p4import.txt and
> > the git-p4 rpm (defined in git.spec.in)? Should I move them with it?
> > (Seems nothing else in the main tree references contrib.) If so,
> > maybe I should set up a common "Documentation/asciidoc.mak" or
> > something for building the man/html pages rather than duplicating all
> > that Makefile logic.
>
> A much more preferable alternative is for you to say "Hey, don't
> say you want to demote it.  I'll keep it maintained, I regularly
> use p4 and have a strong incentive to keep it working".  Then we
> do not have to do the "patch 0" ;-)

On the topic of git integration with perforce, what are the chances of gett=
ing=20
git-p4 ( http://repo.or.cz/w/fast-export.git ) into git's contrib/fast-expo=
rt=20
area? :)

git-p4 can do everything git-p4import can do plus a lot more (it can track=
=20
multiple branches, it's a hell of a lot faster, it can export back to p4 an=
d=20
it also works on Windows!).


Simon

--nextPart1267630.EBWRK5EZod
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGYr4DWXvMThJCpvIRAvp8AKDIyWPmjLXKouq8ZA7TOo23EF4zKgCfelVh
EZuBycbbCftfY4vaWkpllqs=
=u3Pu
-----END PGP SIGNATURE-----

--nextPart1267630.EBWRK5EZod--
