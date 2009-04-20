From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Add support for writing/appending .gitignore file
Date: Mon, 20 Apr 2009 19:09:38 +0200
Message-ID: <200904201909.38766.robin.rosenberg.lists@dewire.com>
References: <AFFAB806-28F7-4D48-B603-B7B96052B0F3@gmail.com> <200904200832.28361.robin.rosenberg.lists@dewire.com> <4D1840C4-B04C-4D75-9A01-BDCDC40D0A29@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Alex Blewitt <alex.blewitt@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 19:47:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvxa7-0002Se-GJ
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 19:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508AbZDTRpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 13:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbZDTRpN
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 13:45:13 -0400
Received: from mail.dewire.com ([83.140.172.130]:1278 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753508AbZDTRpM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 13:45:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 202CF1491671;
	Mon, 20 Apr 2009 19:45:06 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S5vKCMvOnu3k; Mon, 20 Apr 2009 19:45:05 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 9220C149166E;
	Mon, 20 Apr 2009 19:45:05 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <4D1840C4-B04C-4D75-9A01-BDCDC40D0A29@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117011>

m=E5ndag 20 april 2009 09:55:54 skrev Alex Blewitt <alex.blewitt@gmail.=
com>:
>=20
> On 20 Apr 2009, at 07:32, Robin Rosenberg wrote:
>=20
> > m=E5ndag 20 april 2009 04:40:42 skrev Alex Blewitt <alex.blewitt@gm=
ail.com=20
> > >:
> >> On Sun, Apr 19, 2009 at 10:50 PM, Robin Rosenberg
> >> <robin.rosenberg.lists@dewire.com> wrote:
> >> One advantage of attaching issues is you don't have MUA problems :=
-)
> >> I'll try and get a patch to work via git-send-email later.
> >
> > The problem is review. With e-mail I can just hit reply and comment=
 =20
> > on your
> > patch. Did your try the SMTP interface to gmail? I think e-mailing =
=20
> > inlined patches is
> > a nearly perfect. Inline-attachment is ok with me. That makes it =20
> > possible to
> > comment on them like any email in my mail program.
>=20
> Right, but the same approach is possible in a bug tracking system - =20
> just comment. And people get a notification that a change has =20
I haven't seen that. Obviously a bugtracker could cite the patch, but
I don't know any that do.

> apple:egit alex$ git status
> # On branch master
> # Your branch is ahead of 'origin/master' by 9 commits.
> #
> nothing to commit (working directory clean)
>=20
> apple:egit alex$ git rebase -i origin/master
> Working tree is dirty
> apple:egit alex$ git rebase -i d0fd6f96b9311b972c6bffa8680544607d7e3c=
56
> Working tree is dirty
> apple:egit alex$
>=20
> I'm probably doing something obviously wrong here, but I don't know =20
> how to understand the difference between 'working tree is dirty' and =
=20
> 'working directory clean', especially since git status (or git commit=
 -=20
> a) doesn't show any differences.

"obviously" isn't the right word here, or status and rebase would agree
on the cleanliness. If you are using bash I strong suggest you enable
the nice bash prompt with some status information. It's in <gIt>/contri=
b/completion
if you have the Git source. In a packaged version  you can probably can
source /etc/bash_completion. It will tell you what branch you are on an=
d
state-information, like whether a rebase is in progress or not (you wou=
ld
get a different message from rebase/status if that was the case).

> Please excuse me whilst I figure out how to get comfortable working =20
> with git ...

It took me only ten minutes to find a bug the first time I used git :)

-- robin
