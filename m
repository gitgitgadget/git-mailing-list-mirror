From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and
 other non-sophisticated new Git users :-) [Scanned]
Date: Wed, 31 Dec 2008 02:22:32 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnglllr8.kdq.sitaramc@sitaramc.homelinux.net>
References: <BB5F02FD3789B54E8964D38D6775E718242D33@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 03:24:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHqki-0003qC-MN
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 03:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbYLaCWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 21:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753899AbYLaCWr
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 21:22:47 -0500
Received: from main.gmane.org ([80.91.229.2]:51443 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898AbYLaCWq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 21:22:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHqjK-0004eD-6S
	for git@vger.kernel.org; Wed, 31 Dec 2008 02:22:42 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 02:22:42 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 02:22:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104238>

On 2008-12-30, Conor Rafferty <conor.rafferty@altmore.co.uk> wrote:

[re-arranged some of the quotes; it's not in the same order
as in your original email...]

> Even in clearcase this was a cinch.

Hey there's no need to use swear words ;-)

> Is there anyone who can see anyway to do this simply, without a script,
> without creating a branch ?

You'll have to unlearn this resistance to creating branches.
I've never used clearcase, but people tell me it is
expensive to create branches and/or merge them later --
almost a project in itself perhaps?

In git, however, creating a branch is as cheap as creating a
tag, so why not go with the flow until you're a little more
familiar with it?

> Personally I suspect "$ git checkout <version> ." is what should be

leave out the "." is all you needed to do.

> doing this (I have confidence in saying this because it seems to want to
> do this, and does it right at least half the time). But no-one wants to
> admit to the remotest possibility that it might be off ....

Because it's not off :-)  You're using an unusual construct
that is not often used.  (I've done path checkout of one or
a few files, but not the whole "." ever).  So it took people
time to analyse what was happening -- such as suggesting you
use "git ls-files -s" to see what's in the index at each
stage.

May I ask where you got the idea that "." is needed?  We
need to fix that source too ;-)

> In any case, a bunch of smart guys like you should be able to knock this
> functionality together in hours, if you put your mind to it.

> I know you guys have put a lot into this project and for many of you it
> defines who you are 
> - but if you want ppl out there in the user world to take this stuff on,
> its gotta work for them 

While I applaud your efforts to try and understand
everything in one long weekend, you'd have more fun if you
spaced it out a bit :-)

I'll also say that "ppl out there in the user world" will
not experiment the way you have -- they'll follow a basic
set of commands that work.

They'll even (gasp!) use the GUI.  Believe me the GUIs are
pretty nice, though it won't let you checkout a tag (you can
checkout a branch, but not a tag -- because this gets you a
detached head which is a little too advanced for normal
folks I guess).

In other words, you're combining newbie and expert too
fast...

Finally, I heartily recommend reading the following article:
http://thedailywtf.com/Articles/Happy_Merge_Day!.aspx

If the hints in the article are not enough for you to figure
out this is about clearcase read the comments :-)
