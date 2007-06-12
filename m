From: Simon Hausmann <simon@lst.de>
Subject: Re: git-p4import.py robustness changes
Date: Tue, 12 Jun 2007 23:46:56 +0200
Message-ID: <200706122347.00696.simon@lst.de>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <200706031511.31157.simon@lst.de> <20070604055600.GE4507@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5579789.9tOALITgqj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 23:46:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyECT-0005v7-9J
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 23:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbXFLVqw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 17:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbXFLVqw
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 17:46:52 -0400
Received: from verein.lst.de ([213.95.11.210]:54065 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbXFLVqv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 17:46:51 -0400
Received: from luria.local (172.84-48-121.nextgentel.com [84.48.121.172])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l5CLkgo6013476
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Tue, 12 Jun 2007 23:46:43 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <20070604055600.GE4507@spearce.org>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50003>

--nextPart5579789.9tOALITgqj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 04 June 2007 07:56:00 Shawn O. Pearce wrote:
> Simon Hausmann <simon@lst.de> wrote:
> > On the topic of git integration with perforce, what are the chances of
> > getting git-p4 ( http://repo.or.cz/w/fast-export.git ) into git's
> > contrib/fast-export area? :)
> >
> > git-p4 can do everything git-p4import can do plus a lot more (it can
> > track multiple branches, it's a hell of a lot faster, it can export back
> > to p4 and it also works on Windows!).
>
> I was sort of hoping we could fold the fast-export Git repository
> on repo.or.cz into core Git at some point.  Right now the only
> thing in contrib/fast-export is the import-tars.perl script that
> I maintain in my fastimport repository...  ;-)
>
> Like Junio I don't use Perforce, and can't test against it, but
> if you can maintain git-p4 (and I think the history on repo.or.cz
> shows that you do) then it may be a good idea to add it to core Git.
>
> Send a patch to add it.  Worst that happens is both Junio and I
> decide not to apply it.  Or I apply it, but Junio refuses to pull
> from me afterwards.  ;-)

Ok, I'll give it a try :)

I've used git-filter-branch to rewrite the history in fast-export to includ=
e=20
only changes relevant to git-p4 and at the same time move all files into=20
contrib/fast-import. The result is available as separate branch at

	git://repo.or.cz/fast-export.git git-p4

and technically merges fine into git.git's contrib/fast-import directory wi=
th=20
three files (git-p4, git-p4.txt and git-p4.bat for windows convenience).

Please let me know if there's anything missing or if you prefer a different=
=20
format or so. I also realized that I haven't really used the 'Signed-off-by=
'=20
tags in the past but I'd be happy to adopt it for git inclusion if you pref=
er=20
that :)


_If_ one of you decides to pull then my plan is to discontinue the git-p4=20
branch in the fast-export repository and instead work in a git.git fork on=
=20
repo.or.cz (similar to the fastimport repository).


Simon

--nextPart5579789.9tOALITgqj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGbxRUWXvMThJCpvIRAgfbAKD3RFrLsshwVSSRO5QEvBwtDWZepgCggbT8
O3jIHqxKu1fsLzXMNQW08D4=
=ZbX+
-----END PGP SIGNATURE-----

--nextPart5579789.9tOALITgqj--
