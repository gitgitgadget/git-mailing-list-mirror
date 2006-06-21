From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Wed, 21 Jun 2006 22:35:53 +0200
Message-ID: <200606212235.53586.Josef.Weidendorfer@gmx.de>
References: <e79921$u0e$1@sea.gmane.org> <200606211802.41071.Josef.Weidendorfer@gmx.de> <200606211838.50864.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 22:36:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft9Qd-0008BY-Od
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 22:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWFUUf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 21 Jun 2006 16:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWFUUf4
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 16:35:56 -0400
Received: from mail.gmx.net ([213.165.64.21]:60608 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030266AbWFUUf4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 16:35:56 -0400
Received: (qmail invoked by alias); 21 Jun 2006 20:35:54 -0000
Received: from p5496B485.dip0.t-ipconnect.de (EHLO linux) [84.150.180.133]
  by mail.gmx.net (mp043) with SMTP; 21 Jun 2006 22:35:54 +0200
X-Authenticated: #352111
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <200606211838.50864.jnareb@gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22286>

On Wednesday 21 June 2006 18:38, you wrote:
> Josef Weidendorfer wrote:
> > Let's see. A think a mixture between current history and log...
> > Currently, it looks like this
> >=20
> > =A0http://git.kernel.org/git/?p=3Dgit/git.git;a=3Dhistory;f=3DDocum=
entation
> >=20
> > gives you the history of subdirectory Documentation/ of git
> > (unfortunately only reachable via changing the URL...).
> >=20
> > And it could look as attached (I did a little copy/paste of
> > HTML). I only modified 2 commits of the list...
>=20
> It probably didn't get to mailing list (at least to archives) due=20
> to having attachement.

Yes; the mailing list regarded as spam because of the attachment.

> I thought you wanted to enhance tree view,

That wasn't me ;-)

> e.g. adding to the view like in=20
>=20
>   http://git.kernel.org/git/?p=3Dgit/git.git;a=3Dtree;f=3DDocumentati=
on
>=20
> columns 'Changed by' or 'Author', 'Age' or 'Last changed', 'Commit'=20
> (i.e. abbreviated sha1 id of a commit), and perhaps shortened commit
> message (short description of changes, a la shortlog but shorther).

Yes, sometimes this could be interesting. However, as said above,
I find myself often looking for date sorting with such views.

> In other words 'blame'/'annotate' for directory. Which would need new=
 git
> command I think.

Hmmm... wouldn't "git-log --summary", and building up a map from files =
names
to commits be enough? You would probably need to parse the full history=
 before
sending any output, so it is potentially heavy.=20

> Adding filtered list of files modified by commit in log and history v=
iews=20
> should be fairly easy...

Yes. If I get some time, I'll send a patch.

Josef
