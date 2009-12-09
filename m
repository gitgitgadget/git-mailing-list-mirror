From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: help: bisect single file from repos
Date: Wed, 9 Dec 2009 10:45:32 +0100
Message-ID: <20091209094532.GS18686@neumann>
References: <4B1CFC4C.6090406@bfs.de> <4B1D1A5A.9060004@drmicha.warpmail.net>
	<4B1D27B6.7010900@bfs.de>
	<200912080917.17220.chriscool@tuxfamily.org>
	<4B1E5796.2090201@bfs.de> <7vein5e2lc.fsf@alter.siamese.dyndns.org>
	<20091209012855.GA3208@neumann>
	<20091209172737.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael J Gruber <git@drmicha.warpmail.net>, wharms@bfs.de
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 10:45:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIJ7B-0001DT-05
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 10:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbZLIJpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 04:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbZLIJpc
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 04:45:32 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:53768 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbZLIJpb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 04:45:31 -0500
Received: from [127.0.1.1] (p5B13032B.dip0.t-ipconnect.de [91.19.3.43])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0Lg6Fn-1NsyUo2YkV-00pXWt; Wed, 09 Dec 2009 10:45:35 +0100
Content-Disposition: inline
In-Reply-To: <20091209172737.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX18sxz04bkX41el0C0T3dDs6BXWZGvUZGcM089Z
 SUmbKoePmlBezkgPr52sgzULwbQ1gbS79/GwpbLVh1QcIxmjqH
 QltPdoBMVfN4a4OXmIiiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134953>

Hi,


On Wed, Dec 09, 2009 at 05:27:37PM +0900, Nanako Shiraishi wrote:
> Quoting SZEDER G=E1bor <szeder@ira.uka.de>
>=20
> > [1] - 'git cherry-pick' doc says the following:
> >
> >   <commit>
> >     Commit to cherry-pick. For a more complete list of ways to spel=
l
> >     commits, see the "SPECIFYING REVISIONS" section in git-rev-pars=
e(1).
> >
> > What?  "A _more_ complete list"!?  Well, it's not very hard to be m=
ore
> > complete than this, there is not a single way described here (;
>=20

> I agree that "more" shouldn't be in that sentence, and I understand
> your hesitation to read plumbing manual pages, but I don't think it
> is a sane solution to the issue to repeat how to name a commit in
> manual pages for every single command to bloat the two line
> description you quoted into a half-page paragraph.  Even within that
> two lines, the real information that should be in the manual for
> cherry-pick is only three words "Commit to cherry-pick" and the rest
> is to help people who don't know.

I agree, that's why I proposed "a _section_ about specifying these
commits" in the more relevant part of my previous email you did not
quote.

The description of the "<commit>" option would remain almost the same,
but it will now refer to a dedicated section about specifying commits
below, but still in the same manpage.  This new dedicated section
would contain the list of three, five, N most common ways to specify a
commit, avoiding the bloatage in the options section.  And for those
who really want to dig deep, this dedicated section will refer to 'git
rev-parse' for the complete list.

And this would not be the first time we document something in many
places, think of '--pretty' and diff options, for example.


Best,
G=E1bor
