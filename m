From: Bill Lear <rael@zopyra.com>
Subject: Re: GIT vs Other: Need argument
Date: Wed, 18 Apr 2007 11:49:47 -0500
Message-ID: <17958.19499.813637.324723@lisa.zopyra.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	<20070417104520.GB4946@moonlight.home>
	<8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
	<200704171818.28256.andyparkins@gmail.com>
	<20070417173007.GV2229@spearce.org>
	<462521C7.2050103@softax.com.pl>
	<Pine.LNX.4.64.0704181130150.12094@racer.site>
	<alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 18:50:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeDML-0008Rl-WB
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 18:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992859AbXDRQuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 12:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992861AbXDRQuR
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 12:50:17 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60363 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992859AbXDRQuP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 12:50:15 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l3IGo5C27918;
	Wed, 18 Apr 2007 10:50:05 -0600
In-Reply-To: <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44914>

On Wednesday, April 18, 2007 at 09:07:55 (-0700) Linus Torvalds writes:
>...
>Actually, at this stage, I really think cogito just *complicates* git 
>usage. ...

As a relative newbie to git, I agree.  At our company, we did not even
seriously consider using cogito.  Just easier to jump right in to the
frosty waters.

>What _is_ true is that git is simply different from CVS. I don't think 
>it's necessarily harder to understand or use (in fact, I would argue that 
>git is a lot _easier_ to understand), but it is *different*, and it has a 
>ton more capabilities.

Well, differences can lead to difficulties.

Here are a few of the differential difficulties we have faced:

1) There seems to be an innate desire on our part to just "update this
branch from that one on that repository".  We have been caught several
times pulling onto the wrong branch, pushing onto the wrong one,
because we assumed the behavior of push/pull was "update this branch,
the one I am on right now, and ONLY this branch", but what we got was
a cross-branch merge.  Coming from a CVS background, and there not
having "undo" very easy, this caused severe stress.  Easy enough to
undo, once we understood, but does not obviate the stress.

2) Addressing of branches.  When to use bare 'git pull/push', when to
use 'git pull/push branch' when to use 'git pull/push branch:branch',
have been continually confusing to us.

3) Funkiness of non-bare repos ---- we really got stung trying to push
into one.  Seemed like it took us days to figure out what was going
on.

4) Near disaster using git with ssh to push to our company repo.  In
our company, we have a very loosy-goosy IT group.  We started using
git with ssh and had serious permissions problems.  If we had used the
git protocol from the start, that would have avoided this mess, but
support for that came too late.

Git has gotten much better than when we started with it just at the
beginning of this year.  Remote support, branch tracking, lots of
stuff has gotten much, much better.

I could go on and on about the good things, but it is important to
caution --- not frighten --- newbies with tales from others who have
been stung.


Bill
