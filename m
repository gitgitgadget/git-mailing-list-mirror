From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 19:12:05 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807161902400.8986@racer>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 20:13:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJBUv-0001PP-5w
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 20:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbYGPSMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 14:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbYGPSMG
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 14:12:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:53858 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752163AbYGPSMF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 14:12:05 -0400
Received: (qmail invoked by alias); 16 Jul 2008 18:12:02 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp024) with SMTP; 16 Jul 2008 20:12:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6hSZp+df65Uby6s1v7qsVWqBt0T4kmfgYEllV5C
	7vgU9gelVH+xpw
X-X-Sender: gene099@racer
In-Reply-To: <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88704>

Hi,

On Wed, 16 Jul 2008, Avery Pennarun wrote:

> On 7/16/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >  Am I the only one who deems teaching plumbing to users ("I like it raw!
> >  So I teach it the same way!") harmful?
> 
> I believe the only way you can get away with such a simple learning
> sequence is if your workflow is as simple as that you seem to
> describe: everyone has push access to the central 'master'.

That _is_ the most common form.

And with my way of not even bothering to tell users that "git pull" has a 
default remote and branch, it is easy to tell users about pulling from 
somewhere else:

	git pull that.big.machine:~gitte/git my-next

No problem.  After having worked with the first form a few time, this 
command line is surprisingly easy to teach.

> At the very least, there will be branches.

Oh.  And you have to teach plumbing for that?

Besides, you do not start with that.  Most users will be happy with one 
branch called master for the first day, if not week.

> And where there are branches, there's merging.  And with merging comes 
> merge conflicts.

Funny that you should say that: I had that case.  "git pull origin master" 
said something about conflicts.  Happily, this user was able to read, and 
edited the files mentioned to have conflicts.

After resolving the conflicts (the "<<< === >>>" was known from CVS), add 
and commit were again as encountered in the first 2 minutes of my course.

> And so you suddenly need to find out about things like
> 
>        git diff :{1,3}:path/to/filename

No.  Nobody needed that.  All except one user were content with "git 
diff".  That one wanted "git diff --ours".

So there was no use to teach some advanced concepts there, let alone in 
the first few lectures.

But back to the subject: what does this have to do with plumbing?

I will not even bother to reply to your mentioning rebase, submodules, and 
the "complicated" log due to merges for that very reason: all of this can 
be done, easily, with porcelain.

> Ironically, the plumbing is the only part of git that isn't supposed to 
> ever change, so it's the most valuable knowledge to have.

Aha.  So we changed porcelain recently, in a backwards-incompatible way?  
Now, that is news to me.

Ciao,
Dscho
