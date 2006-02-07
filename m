From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] git-commit: revamp the git-commit semantics.
Date: Tue, 07 Feb 2006 13:25:02 -0600
Message-ID: <1139340302.13067.42.camel@cashmere.sps.mot.com>
References: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550602050536j73f1091dq9afae232f574d0b4@mail.gmail.com>
	 <7v64ntindq.fsf@assigned-by-dhcp.cox.net> <43E67745.2080302@gmail.com>
	 <7voe1le71b.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0602071135110.5397@localhost.localdomain>
	 <7vfymvvz1r.fsf@assigned-by-dhcp.cox.net>
	 <7vpslzuj6e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Feb 07 20:25:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6YSb-00016F-Ha
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 20:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWBGTZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 14:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWBGTZG
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 14:25:06 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:43464 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S965163AbWBGTZE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 14:25:04 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k17JbiRl006464
	for <git@vger.kernel.org>; Tue, 7 Feb 2006 12:37:44 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k17JYMI7013458
	for <git@vger.kernel.org>; Tue, 7 Feb 2006 13:34:22 -0600 (CST)
To: Git List <git@vger.kernel.org>
In-Reply-To: <7vpslzuj6e.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15709>

On Tue, 2006-02-07 at 12:18, Junio C Hamano wrote:

> That means 1.2.0 (and its maintenance series 1.2.X) will ship
> with --include semantics for "git commit paths...", and will
> allow explicit --only/--include.  After 1.2.0, at some point,
> the "master" branch will start shipping with --only semantics as
> default.  No script should break when 1.3.0 happens.
> 
> People who want to use --include semantics will acquire a habit
> of explicitly askign for --include during 1.3.0 development
> period.  They do not need to unlearn anything when 1.3.0 happens.
> 
> People who learned to type --only can unlearn it to reduce
> typing when 1.3.0 happens, but unlearning is not a requirement.
> Being explicit should always work.
> 
> New people that come after 1.3.0 will get the --only semantics
> by default, the intuitiveness of which has been argued to death,
> without using any flags.

Hmmm...  So maybe just to add fire to the discussion,
maybe the problem lies in the "tool name".  What if there
were two tools named "git-commit-index" and "git-commit-path"?
I understand that this is, in some way, identical to the
"--include" and "--only" sorts of notions.  But I think it
might make the intent clearer, and easier to describe/document.
I think part of my concern with the options is trying to
recall/describe just exactly _what_ is "included" with
the "--include", or what is excluded with the "--only".
It is the index's data/state, of course.  So perhaps
a "git commit-index" might be consistent tool naming?
And for contrast "git commit-file" or "git commit-path"?

Just a thought.

jdl
