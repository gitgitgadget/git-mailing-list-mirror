From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 10:48:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704191043140.8822@racer.site>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <f06d4m$3rs$1@sea.gmane.org> <4626C4B9.1040707@midwinter.com>
 <200704190408.59595.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 10:48:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeSJs-0004HM-KO
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 10:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161227AbXDSIso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 04:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161305AbXDSIso
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 04:48:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:56397 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161227AbXDSIsn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 04:48:43 -0400
Received: (qmail invoked by alias); 19 Apr 2007 08:48:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 19 Apr 2007 10:48:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0G5xVUcH089Gz8JD3YNk5cgqkXjXZYNJijI1A9x
	Iu0sovYwoD8di/
X-X-Sender: gene099@racer.site
In-Reply-To: <200704190408.59595.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44995>

Hi,

On Thu, 19 Apr 2007, Jakub Narebski wrote:

> Steven Grimm wrote:
>
> > One can argue about whether allowing partial commits like that is a 
> > good idea, but it's just not true that svn forces you to always update 
> > before you commit, and if you're pushing into a branch that other 
> > people are also updating, the ability to commit files that didn't 
> > change upstream means it is actually *less* insistent on 
> > update-then-commit than git is (if you take "commit" to mean 
> > "commit-and-push" on the git side as was suggested in the message I 
> > replied to originally.)
> > 
> > Unless, of course, I'm misinterpreting you here.
> 
> I just think the commit _then_ merge (or commit-then-update) workflow is 
> much, much better than update-then-commit one.

Let me pick up the ball here. Once you did your share of conflicting 
merges, you _will_ realize how much better it is to merge when you are at 
a relatively stable state, i.e. you can test things (if only to make sure 
that the merge did not introduce strange side effects). And guess what, at 
such a stage I would commit anyway.

It is so much easier to resolve conflicts if you can look at both sides, 
and can actually go to both sides to test things out, or even just 
generate the diff to one side. This is just not possible with a dirty 
merge. Exactly because you knowingly lost the current state, you cannot do 
diffs with it.

Needless to say (but I do it nevertheless, since I am in a chatty mood), I 
_never_ can be seen doing the 4-command equivalent of `svn up`. I only 
pull when I have a clean state. (Note: this also leads to a more 
structured way of working, which does prevent errors.)

Ciao,
Dscho
