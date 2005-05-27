From: Linus Torvalds <torvalds@osdl.org>
Subject: More gitweb queries..
Date: Fri, 27 May 2005 12:24:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri May 27 21:21:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbkNX-00039E-J8
	for gcvg-git@gmane.org; Fri, 27 May 2005 21:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVE0TWY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 27 May 2005 15:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVE0TWY
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 15:22:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:32973 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262535AbVE0TWR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 15:22:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4RJMFjA031566
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 May 2005 12:22:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4RJMEFR004536;
	Fri, 27 May 2005 12:22:15 -0700
To: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Kay,
 just a few more quickie suggestions if you don't mind..

 - looking around, the ALSA guys aren't the only ones that start off wi=
th=20
   an empty line, so it's probably worth fixing the summary etc to igno=
re=20
   whitespace at the beginning rather than give empty summary reasons.

 - any reason to limit the "summary" page to just the last 14 changes? =
The=20
   "log" thing you can ask to go back further, it would be nice to have
   something like a "last 100" thing for summaries too, especially sinc=
e=20
   the summary is so nice and dense, so you can actually get a nice vie=
w=20
   of what has happened without scrolling _too_ much.

 - I was in the "commitdiff" thing, and initially thought that there wa=
s=20
   no way to get back to the "summary" view.

   It turns out I was wrong (the summary is reachable by just clicking =
at
   the project name itself in the top header), but it's a bit strange t=
hat
   the "commitdiff" thing has an explicit link back to itself (hey,=20
   consistency is good, so I'm not complaining), but the link back to t=
he
   summary page is implicit.

   So how about adding an explicit "summary" link to the list of other=20
   explicit links (log, commit, commitdiff and tree) at the top of the=20
   page?

I actually like browsing other peoples projects with the gitweb
interfaces, it's both responsive and verbose enough to really say
something good. In contrast, cvsweb is always just a mess of "these are
the files, go at it", which is totally pointless and doesn't tell anyth=
ing
about what is actually happening in the project.

So dammit, I'm very biased indeed, but I'm just looking at gitweb, and
comparing it to both the CVS and SVN web things, and they just reinforc=
e
my conviction that CVS is absolute crap, and I find myself surprised by
how crap SVN also appears.

[ In other words, while I have all these stupid requests for you, I=20
  think gitweb is just _way_ better and more useful than something like
  viewcvs (or cvsweb). So don't mind my small gripes, I only have them=20
  because I like this thing.

  On that small note, I also find "gitk" very cool indeed, too bad abou=
t=20
  the fact that tk/tcl seems to always end up looking so _ugly_. Is the=
re=20
  any way to get anti-aliased fonts and a less 'Motify' blocky look fro=
m=20
  tcl/tk? Every time I see that, I feel like I'm back in the last centu=
ry =20
  or something.

  Combining some of the features of the two (that =FCber-cool revision=20
  history graph from gitk rules, for example) might be cool. I get the=20
  urge to do octopus-merges in the kernel just because of how good they
  look in gitk ;) ]

			Linus
