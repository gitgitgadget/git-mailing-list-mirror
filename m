From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: More gitweb queries..
Date: Sat, 28 May 2005 01:59:24 +0200
Message-ID: <20050527235924.GB19491@vrfy.org>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 01:58:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dboi0-0008Jo-BN
	for gcvg-git@gmane.org; Sat, 28 May 2005 01:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVE0X7t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 27 May 2005 19:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVE0X7h
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 19:59:37 -0400
Received: from soundwarez.org ([217.160.171.123]:24536 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262665AbVE0X72 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 19:59:28 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 76DE83A74D; Sat, 28 May 2005 01:59:24 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, May 27, 2005 at 12:24:20PM -0700, Linus Torvalds wrote:
>  - looking around, the ALSA guys aren't the only ones that start off =
with=20
>    an empty line, so it's probably worth fixing the summary etc to ig=
nore=20
>    whitespace at the beginning rather than give empty summary reasons=
=2E

That is already fixed a few days ago, but unfortunately only in my deve=
l
version. After the catch-up on the recent format changes of the git-out=
put,
I need to wait now until the new git-binaries are hitting kernel.org.

>  - any reason to limit the "summary" page to just the last 14 changes=
? The=20
>    "log" thing you can ask to go back further, it would be nice to ha=
ve
>    something like a "last 100" thing for summaries too, especially si=
nce=20
>    the summary is so nice and dense, so you can actually get a nice v=
iew=20
>    of what has happened without scrolling _too_ much.

Yes, I recognized that too. Jeff asked for branches and I did the summa=
ry
page just for the branches. :) With that I realized that the dense log =
of the
summary is sometimes nicer than the full log. How about this:
  http://ehlo.org/~kay/gitweb.cgi?p=3Dgit/git.git;a=3Dshortlog

It is reachable on the summary page by clicking in the title of the
shortlog.

>  - I was in the "commitdiff" thing, and initially thought that there =
was=20
>    no way to get back to the "summary" view.
>=20
>    It turns out I was wrong (the summary is reachable by just clickin=
g at
>    the project name itself in the top header), but it's a bit strange=
 that
>    the "commitdiff" thing has an explicit link back to itself (hey,=20
>    consistency is good, so I'm not complaining)

Well, yes I was trying to get a navigation which is not changing with
every new page... It's not an active link now. Maybe that's better.

>    but the link back to the
>    summary page is implicit.
>=20
>    So how about adding an explicit "summary" link to the list of othe=
r=20
>    explicit links (log, commit, commitdiff and tree) at the top of th=
e=20
>    page?

Done! That was easy. It will show up on kernel.org when the actual
git-binaries are installed.

> I actually like browsing other peoples projects with the gitweb
> interfaces, it's both responsive and verbose enough to really say
> something good. In contrast, cvsweb is always just a mess of "these a=
re
> the files, go at it", which is totally pointless and doesn't tell any=
thing
> about what is actually happening in the project.
>=20
> So dammit, I'm very biased indeed, but I'm just looking at gitweb, an=
d
> comparing it to both the CVS and SVN web things, and they just reinfo=
rce
> my conviction that CVS is absolute crap, and I find myself surprised =
by
> how crap SVN also appears.

Good to hear that. It's a long road to make software from "working" to
"nice to use". That was probably never the goal of some SCM-web-interfa=
ces. :)

>   Combining some of the features of the two (that =C3=BCber-cool revi=
sion=20
>   history graph from gitk rules, for example) might be cool. I get th=
e=20
>   urge to do octopus-merges in the kernel just because of how good th=
ey
>   look in gitk ;) ]

I would like to show something like the graph too, but I don't really k=
now
how to do this in html. Seems slippery if not impossible.
If anybody has a nice idea how to represent that, I will give it a try.

Kay
