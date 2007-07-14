From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: mtimes of working files
Date: Sat, 14 Jul 2007 15:23:32 +0200
Message-ID: <200707141523.32929.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.64.0707111940080.4516@racer.site> <20070714004433.GB10131@fieldses.org> <1184374174.2785.104.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 15:22:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9haJ-0003to-2Y
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 15:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188AbXGNNWv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 14 Jul 2007 09:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755364AbXGNNWl
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 09:22:41 -0400
Received: from [83.140.172.130] ([83.140.172.130]:10181 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755181AbXGNNWj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 09:22:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E719A80265B;
	Sat, 14 Jul 2007 15:15:31 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31283-08; Sat, 14 Jul 2007 15:15:31 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 68DD7802663;
	Sat, 14 Jul 2007 15:15:31 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <1184374174.2785.104.camel@shinybook.infradead.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52480>

l=C3=B6rdag 14 juli 2007 skrev David Woodhouse:
> On Fri, 2007-07-13 at 20:44 -0400, J. Bruce Fields wrote:
> > On Sat, Jul 14, 2007 at 01:36:33AM +0100, David Woodhouse wrote:
> > > Yeah, much of it. Although I've also seen other people trying to =
get
> > > to grips with git and tripping up over branches recently.
> >=20
> > Could you give any details?  What specifically was it they were hav=
ing
> > trouble with?=20
>=20
> Just conversations on IRC where stuff had to be explained. People not
> understanding that they'd actually cloned _multiple_ branches and the=
y
> needed to select the one they wanted, making the same kind of stupid
> mistakes I did with committing to the wrong place, etc. Nothing speci=
fic
> stands out as being fixable, certainly.

That's why there are scripts that modify the bash prompt to show the cu=
rrent branch.
I made one for stacked git (it works with plain git too). The git compl=
etion scripts have=20
something also I think

It helps a lot for those of us with bad memory implants.

> Branches have their place, and some people seem very happy with them =
as
> part of their local workflow. I just wonder if we have to have them o=
n
> the servers too; that's all.

Branches are bad if you don't need them as is any feature you don't nee=
d is bad, it is
just that many people need branches. Branches are a pain to manage with=
 many SCM
tools, except git, which solves most of the problems with branches.

-- robin
