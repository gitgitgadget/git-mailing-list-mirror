From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: update-po
Date: Sun, 22 Jul 2007 23:48:30 -0400
Message-ID: <20070723034830.GA32566@spearce.org>
References: <Pine.LNX.4.64.0707221352210.14781@racer.site> <200707222321.l6MNL0pi005112@mi0.bluebottle.com> <7v644cosmu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Xudong Guan <xudong.guan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 05:48:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICouX-0006fR-7j
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 05:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbXGWDsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Jul 2007 23:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbXGWDsi
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 23:48:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40968 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbXGWDsh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 23:48:37 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICouC-0006oI-J8; Sun, 22 Jul 2007 23:48:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7CC3120FBAE; Sun, 22 Jul 2007 23:48:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v644cosmu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53381>

Junio C Hamano <gitster@pobox.com> wrote:
> =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nan=
ako3@bluebottle.com> writes:
>=20
> > Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> msgid "Add Existing"
> >> msgstr ""
> >>
> >
> > I had problem when translating this word "Existing" in my old trans=
lation.
> > I did not understand what that expression meaned.  My old translati=
on for
> > "Add Existing To Commit" said, because I did not understand what it=
 meant,
> > "Add Some Existing THING To Commit", and it felt very wrong, but I =
could
> > not come up with anything better.
>=20
> I did not quite understand the "Existing" either (I do not
> use git-gui myself---I just launch it from time to time to make
> sure it does not barf on simple operations as part of the last
> minite tests before pushing changes to git.git out), and had a
> discussion on #git channel with a few people.
>=20
> My reading of git-gui code suggests that "Add Existing To
> Commit" is used in an item in "Commit" menu, while "Add
> Existing" is a label on the button, and they do exactly the same
> operation.  It updates the index with the current contents of
> the tracked files.  That is, deleted files are discarded from
> the index, and modified files are updated.  IOW, "git add -u".

Yes, that's exactly correct.

> "Existing" is probably a misnomer even in the original English
> UI --- it is more about "Tracked".  I think your confusion about
> "Add unexisting" is justified, because "Add Existing" operation
> is not about "existing" but "all tracked files without having me
> pick and select all of them", and the other variant, "Add To
> Commit", lets you add selected files, be they "tracked" or
> "untracked".

I agree.  I'm going to change the base English version to say
"Tracked" here instead of "Existing".  Its the correct term,
at least with regards to Git.

Thanks for the sanity check.

--=20
Shawn.
