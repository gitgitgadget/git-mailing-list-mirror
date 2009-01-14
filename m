From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: Google Summer of Code 2009
Date: Wed, 14 Jan 2009 23:01:12 +0100
Message-ID: <20090114220112.GC32313@leksak.fem-net>
References: <20090107183033.GB10790@spearce.org> <m3privyn20.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 23:02:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNDp5-0007rR-Ku
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 23:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbZANWB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 17:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753485AbZANWB2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 17:01:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:36432 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753092AbZANWB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 17:01:26 -0500
Received: (qmail invoked by alias); 14 Jan 2009 22:01:25 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp001) with SMTP; 14 Jan 2009 23:01:25 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX190YUNn2HN0WQupheb3+igSXbT7zX1ViX5TDNoNsS
	UT7jK1o/CtzgIp
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNDnU-0005J6-J0; Wed, 14 Jan 2009 23:01:12 +0100
Content-Disposition: inline
In-Reply-To: <m3privyn20.fsf@localhost.localdomain>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105708>

Hi,

Jakub Narebski wrote:
> By the way, do you know what happened with git-sequencer project? 
> 
> If I remember correctly there was agreement on sequences mini-language
> (I think), and there was git-sequencer prototype in shell, using
> git-cherry-pick if I remember correctly, and even git-rebase and
> git-am etc reworked to make use of git-sequencer.  Stephan Beyer wrote
> that he has some preliminary version of builtin git-sequencer (in C),
> and that it makes git-rebase--interactive and like faster than current
> implementation... but builtin sequencer never materialized on git
> mailing list as a patch, if I remember correctly, and of course it was
> not merged into git either.

You remember and conclude correctly.

As Christian pointed out, we are working on it. Development didn't make
any real progress for a long time because of different personal reasons.
(If you're interested: an important exam at the end of September,
some other work besides, wrong priorities in time management,
some kind of "burnout" after the exam which made me avoid any kind of
productive work for a long time... it went away in between but came back
later...)

Now, again, I'm highly motivated to get it merged into pu or next before
the end of January. I hope, Christian or Daniel will kick me in the back
if this is not going to happen :-)
The next days some tiny and some bigger patches will follow. Commits
that have been lying around in my repo for a _long_ time.

In this time I try to address the rest of my TODO list which emerged
from a very chaotic sticky note[1] and is, well, just chaotic.
It contains items about...
 - some internal changes (simplifications, code reuse),
 - some changes in the output of sequencer,
 - some better code documentation (one item for a part of sequencer
   itself, one item for its test suite t3350),
 - check some stuff and fix if needed
   (e.g. whether sequencer changes this or that behavior (for
   rebase or am) that I haven't taken care of yet),
 - and the last item is to check/incorporate the git-rebase --root
   patches and/or fix sequencer to work with them (if needed).
   (I haven't taken one look at these patches, so I don't know
   if it's really necessary.)

It's not too much, but every single change can generate a bug
and, thus, hassle. :-)

Well, this is the current state of the git-sequencer project.
Thanks for the question and the prodding in the other thread (although
the problem there was solved much simpler without sequencer.)

Regards,
  Stephan

Footnotes.
 1. I mean those fancy yellow desktop notes provided by tools like
    "knotes" -- now uninstalled from my desktop machine, because
    there are *useful* tools like outliners that _help_ to
    manage ideas, todo lists, etc in a non-chaotic way.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
