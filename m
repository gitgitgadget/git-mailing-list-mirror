From: Simon Hausmann <simon@lst.de>
Subject: Re: git-p4import.py robustness changes
Date: Thu, 14 Jun 2007 23:44:25 +0200
Message-ID: <200706142344.29089.simon@lst.de>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <200706122347.00696.simon@lst.de> <20070614053538.GA6073@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1952889.ptKhQtExBd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 23:44:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyx73-0004Ft-07
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 23:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbXFNVoQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 17:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbXFNVoQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 17:44:16 -0400
Received: from verein.lst.de ([213.95.11.210]:54140 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637AbXFNVoP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 17:44:15 -0400
Received: from luria.local (172.84-48-121.nextgentel.com [84.48.121.172])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l5ELi4o6010310
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Thu, 14 Jun 2007 23:44:06 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <20070614053538.GA6073@spearce.org>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50222>

--nextPart1952889.ptKhQtExBd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 14 June 2007 07:35:38 Shawn O. Pearce wrote:
> Simon Hausmann <simon@lst.de> wrote:
> > I've used git-filter-branch to rewrite the history in fast-export to
> > include only changes relevant to git-p4 and at the same time move all
> > files into contrib/fast-import. The result is available as separate
> > branch at
> >
> > 	git://repo.or.cz/fast-export.git git-p4
> >
> > and technically merges fine into git.git's contrib/fast-import directory
> > with three files (git-p4, git-p4.txt and git-p4.bat for windows
> > convenience).
> >
> > Please let me know if there's anything missing or if you prefer a
> > different format or so. I also realized that I haven't really used the
> > 'Signed-off-by' tags in the past but I'd be happy to adopt it for git
> > inclusion if you prefer that :)
>
> Yes.  The SBO line is your assertion that you own the rights to the
> code and can release it under the license you are offering it under.
> One of the issues I have with this git-p4 history you have built
> is the lack of the SBO line on all 255 commits.
>
> Of course an SBO line doesn't carry that much weight, its just a line
> after all, but according to Git's project standards it should be there
> if you are agreeing to release it.  See Documentation/SubmittingPatches
> for details.
>
> My other problem with this history is a commit like b79112 "a
> little bit more convenience" (and there are many such commits).
> This message is insanely short, doesn't really talk at all about
> what a little bit is, how it is more convenient, or who it is more
> convenient for.
>
> Think about how that oneline (and the others) would look in Junio's
> "What's new in git.git" emails, or in gitweb.  There is not enough
> detail here to be of any value to the reader.  Expanding out to the
> full message offers nothing additional either, because that is all
> there is in the entire commit message body.
>
> I do appreciate you taking the time to use filter-branch to try to
> cleanup this history a bit.  I really had originally planned on
> pulling your tree through to my fastimport tree and then talking
> Junio into merging with me.  But after reading through this history I
> don't want do that, because of the oneline summaries I just pointed
> out above, and because of the missing SBO.

=46irst of all thanks for looking at the branch. I agree with your concerns=
 and=20
I do admit that I've been a bit too sloppy with the log messages.

I have started cleaning up the history even more by reworking the log messa=
ges=20
of my commits (git-p4-enhanced-logs branch in fast-export, starting at the=
=20
last page). Once that is done (I expect that to take a few days) I'll add t=
he=20
missing SOB lines with git-filter-branch and see if I can get an agreement=
=20
from Han-Wen and Marius for doing the same with their commits (adding the=20
missing lines).

Would you be willing to reevaluate the situation regarding a merge once tha=
t's=20
done?


Simon

--nextPart1952889.ptKhQtExBd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGcba9WXvMThJCpvIRAhFnAJ43VyOAgK6Cz24GmaoiF2UTuqD8WACfcjmf
kZVm8N6r1oM3SACZy5VjR6Q=
=r2h+
-----END PGP SIGNATURE-----

--nextPart1952889.ptKhQtExBd--
