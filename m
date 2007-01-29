From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: More precise tag following
Date: Mon, 29 Jan 2007 19:07:45 +0100
Message-ID: <45BE37F1.9090409@fs.ei.tum.de>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org> <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org> <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <20070129061807.GA4634@spearce.org> <Pine.LNX.4.64.0701290759570.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig46C4D3550BC290D2F51EABF0"
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 29 19:08:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBavA-0002S0-G6
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 19:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbXA2SH5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 13:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbXA2SH5
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 13:07:57 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:60032 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbXA2SH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 13:07:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 5C9BF2822F;
	Mon, 29 Jan 2007 19:07:54 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 67Fsnn7sCpZc; Mon, 29 Jan 2007 19:07:53 +0100 (CET)
Received: from [62.216.202.244] (ppp-62-216-202-244.dynamic.mnet-online.de [62.216.202.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 84C6628086;
	Mon, 29 Jan 2007 19:07:53 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <Pine.LNX.4.64.0701290759570.3611@woody.linux-foundation.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38088>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig46C4D3550BC290D2F51EABF0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> (Yes, from a technical standpoint making the annotation data bigger is =
a=20
> good thign: git simply has more useful information than CVS does. But t=
he=20
> lack of information in CVS actually makes the "stupid interface" better=
,=20
> if only because you don't waste as much space on it).

I absolutely agree.  My primary workflow around cvs annotate is about thi=
s:  I read code and would like to know why this one snippet was introduce=
d in the first place (or changed).  So I go cvs annotate in my browser, a=
nd in parallel I display the cvs log, to actually see the commit message.=
  Then I retrieve the diff output to see what happened, maybe starting th=
e cycle again with an older version.

What I want to illustrate is:  No matter how much information you show in=
 one line, you won't be able to fit all possible information.  So my drea=
m interface is a display which shows which runs of lines were changed tog=
ether, and in which order the runs were changed.  A temporary numbering o=
f commits might help here (in CVS it is clear).  Now when I identify a ru=
n, i'd like to have an easy way to retrieve the git log -p output.  An ad=
ditional blame should work on the parent of the commit associated with th=
e current line (so that I can see how the line looked before this commit,=
 and when this was changed).

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig46C4D3550BC290D2F51EABF0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFvjf0r5S+dk6z85oRAsPHAKCCAnb827RcOmCnDSr9EtGHIc5TZQCgycPj
zFsbhdRbzfuCBK9R5dXJp7A=
=oCUy
-----END PGP SIGNATURE-----

--------------enig46C4D3550BC290D2F51EABF0--
