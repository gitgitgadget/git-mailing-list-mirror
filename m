From: "Zorba" <cr@altmore.co.uk>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-)
Date: Wed, 31 Dec 2008 00:31:46 -0000
Message-ID: <gjeei2$e72$4@ger.gmane.org>
References: <gj68a0$u56$3@ger.gmane.org> <gj6kqq$nvh$4@ger.gmane.org> <3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com> <gjdh0r$n3c$4@ger.gmane.org> <gjdlcl$5no$4@ger.gmane.org> <gjdmm6$9oj$4@ger.gmane.org> <3ab397d0812301035w3dcd872fkae9509629a0ed7de@mail.gmail.com> <gje4ff$ip6$4@ger.gmane.org> <alpine.LNX.1.00.0812301730440.19665@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 01:33:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHp1j-0000Ia-Nq
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 01:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbYLaAcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 19:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbYLaAcO
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 19:32:14 -0500
Received: from main.gmane.org ([80.91.229.2]:46773 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbYLaAcN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 19:32:13 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHp0L-0000gM-DY
	for git@vger.kernel.org; Wed, 31 Dec 2008 00:32:09 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 00:32:09 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 00:32:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.2 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  1.2 PRIORITY_NO_NAME Message has priority, but no X-Mailer/User-Agent
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104234>

> So in order for this to make sense, you're going to need to know a little
> tiny bit about branches

** (sigh) At some level I knew I'd have to face up to this... - ok lets do 
it

(which, fortunately, is trivial compared to
> branches in most SCMs). In git, a branch is a mutable pointer to a commit,
> which is the latest commit on the branch (all of the earlier commits on
> the branch are linked off of the latest one; each commit points to the one
> before). By default, you have a branch called "master", and that's the
> branch that your series of commands builds up. Now, at any given time, you
> can have a "current branch" (a.k.a. HEAD), which is the branch that you'd
> put a new commit on if you made one. "master" is your current branch while
> you're building up that history.

> When you want to navigate the history, however, you want to leave all of
> the branches alone and take your working directory into the history. This
> is known as being on "(no branch)" or, as Zippy would say, having a
> "detached HEAD". This way you leave the "master" branch pointing to
> versionD, which is, after all, the latest commit, while you get yourself
> an old version. You can do this with:

> $ git checkout versionA
>
> because you've made a tag for it. In order to get back to developing (as
> opposed to looking at history), you use:
>
> $ git checkout master
>
> (because "master" is your branch, while "versionA" is a tag).
>
> If you're on master, either after checking it out explicitly or before
> you've used checkout at all, doing:
>
> $ git checkout versionA .
>
> with *not* switch you away from the current branch, but will get the
> contents of "." from versionA into your index and working directory, and
> it doesn't remove things that you have currently.

** ok, thanks for explaining - one little dot and my HEAD don't get a 
holiday !

Now, lets say we checkout versionB. I don't just want to be pointing at 
versionB in the repo, I want an exact copy (no more, no less) of all the 
files in version B, to be placed in the working tree. Currently this is not 
happening reliably.

Is that too much to ask ?
