From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 11:21:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601311110210.7301@g5.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> 
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> 
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> 
 <1138446030.9919.112.camel@evo.keithp.com>  <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
  <20060130185822.GA24487@hpsvcnb.fc.hp.com> 
 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0601310926330.7301@g5.osdl.org> <1138734110.18852.26.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 20:25:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4182-00043Q-LW
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 20:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWAaTZX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 14:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWAaTZX
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 14:25:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47325 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751401AbWAaTZW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 14:25:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0VJLsDZ000339
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 11:21:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0VJLqaS026305;
	Tue, 31 Jan 2006 11:21:53 -0800
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1138734110.18852.26.camel@evo.keithp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15335>



On Tue, 31 Jan 2006, Keith Packard wrote:

> On Tue, 2006-01-31 at 09:30 -0800, Linus Torvalds wrote:
> 
> >  - ignore it. Never _ever_ use git-update-index directly, and don't tell 
> >    people about use individual filenames to git-commit. Maybe even add 
> >    "-a" by default to the git-commit flags as a special installation 
> >    addition.
> 
> As a newly initiated user, this would have been a more gentle
> introduction to the system. But, it would be hard to make it entirely
> invisible given the current interfaces. I'm not sure if obscuring the
> presense of the index is a great plan; it's already hard enough to
> figure out how it works.

Now, I do agree. I don't actually like hiding the index too much. 
Understanding the index is _invaluable_ whenever you're doing a merge with 
conflicts, and understanding what tools are available to you to resolve 
those conflicts.

The index is also obviously very important when you do a partial commit, 
and it's something I do end up doing quite often. Again, maybe that's not 
something that a new git user should be encouraged to ever do, but it's a 
huge convenience feature for power-users.

Understanding the index also allows people to understand certain 
performance-characteristics of git, and explains how "git add" (and 
remove, if we had one) actually works independently of the commit. 

So I'm actually of the "revel in the index" camp (as could probably be 
guessed by the original tutorial).

My personal suggestion would be to introduce git "gently" by ignoring it, 
but by the time a person actually _works_ on a project (as opposed to just 
going through a tutorial or following another persons project), he/she 
should probably have been introduced to the index in order to understand 
what happens and to use its power.

(In particular, the difference between "git diff" and "git diff HEAD" is 
an important one to understand eventually).

			Linus
