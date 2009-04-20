From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Add support for writing/appending .gitignore file
Date: Mon, 20 Apr 2009 08:32:27 +0200
Message-ID: <200904200832.28361.robin.rosenberg.lists@dewire.com>
References: <AFFAB806-28F7-4D48-B603-B7B96052B0F3@gmail.com> <200904192350.56348.robin.rosenberg.lists@dewire.com> <636fd28e0904191940t3476b016qc76c0e1e624f7b37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Alex Blewitt <alex.blewitt@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 09:44:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvoB3-0000ri-CR
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 09:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbZDTHmP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 03:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbZDTHmP
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 03:42:15 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:42997 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752189AbZDTHmO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 03:42:14 -0400
X-Greylist: delayed 4142 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Apr 2009 03:42:14 EDT
Received: from sleipner.localnet (90.232.93.96) by pne-smtpout1-sn1.fre.skanova.net (7.3.129)
        id 49CCDA070031A638; Mon, 20 Apr 2009 08:32:38 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <636fd28e0904191940t3476b016qc76c0e1e624f7b37@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116941>

m=E5ndag 20 april 2009 04:40:42 skrev Alex Blewitt <alex.blewitt@gmail.=
com>:
> On Sun, Apr 19, 2009 at 10:50 PM, Robin Rosenberg
> <robin.rosenberg.lists@dewire.com> wrote:
> >
> > First, Ferry Huberts is also working on a solution for ignore See
> > http://thread.gmane.org/gmane.comp.version-control.git/114825 thoug=
h you
> > focus on different aspects.
>=20
> Yup, saw the issue 32. I'll keep an eye on that and hopefully I can
> leverage what that does when it's ready.
>=20
> > This patch is whitespace damaged. =C2 Pasting into gmail won't work=
=2E Gmail
> > has authenticated SMTP on port 25 and 465 (SSL) so git-send-email s=
hould work that way.
>=20
> One advantage of attaching issues is you don't have MUA problems :-)
> I'll try and get a patch to work via git-send-email later.

The problem is review. With e-mail I can just hit reply and comment on =
your
patch. Did your try the SMTP interface to gmail? I think e-mailing inli=
ned patches is
a nearly perfect. Inline-attachment is ok with me. That makes it possib=
le to
comment on them like any email in my mail program.

> I've been incrementally committing to my local git copy. Whenever I d=
o
> git format-patch <since> it spews out individual patchettes. How can =
I
> use git to generate one patch? I could git diff <since>, but that's
> not following the SUBMITTING_PATCHES, is it?

Often, after a long session, you end up with a "mess" of commits, many =
which
don't make sense to anyone but you. For this you use rebase -i to clean=
 up.
It allows you to reorder, squash and edit commits. You'll end up with a=
n entirely
new version of your branch. Retest to make sure it's ok and submit.=20

-- robin
