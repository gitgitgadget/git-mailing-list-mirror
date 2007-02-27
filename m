From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Trivia: When did git self-host?
Date: Tue, 27 Feb 2007 01:54:33 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702270113470.6485@iabervon.org>
References: <3c6c07c20702261551u55ec2ea7mde4075b1c929cf87@mail.gmail.com>
 <Pine.LNX.4.64.0702261650120.12485@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702261722310.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Coleman <tutufan@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 07:54:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLwES-0004u7-Fq
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 07:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbXB0Gyg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 01:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbXB0Gyg
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 01:54:36 -0500
Received: from iabervon.org ([66.92.72.58]:1064 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbXB0Gyf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 01:54:35 -0500
Received: (qmail 7115 invoked by uid 1000); 27 Feb 2007 01:54:33 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2007 01:54:33 -0500
In-Reply-To: <Pine.LNX.4.64.0702261722310.12485@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40696>

On Mon, 26 Feb 2007, Linus Torvalds wrote:

> On Mon, 26 Feb 2007, Linus Torvalds wrote:
> > 
> > The first commit was already self-hosted. It was done manually (write-tree 
> > etc by hand), but yes, the first commit really is:
> > 
> > 	Thu Apr 7 15:13:13 2005 -0700
> > 
> > and the second one (add copyright notices) was done a few minutes later.
> > 
> > So git was self-hosting since April 7, 2005.
> > 
> > Now, exactly when I started git development (ie how long it took before it 
> > got to that self-hosting stage), I can't remember. I'd say about two 
> > weeks, probably.
> 
> Actually, it must have been less than that.
> 
> The first version of git was just ~1300 lines of code, and I have reason 
> to believe that I started it at or around April 3rd. The reason: I made 
> the last BK release on that day, and I also remember aiming for having 
> something usable in two weeks. 

As of April 3rd, you were looking at existing systems, rejecting all of 
them aside from monotone, and finding monotone too slow.

According to the first public mention of git 
(http://lkml.org/lkml/2005/4/8/9), you'd spent two days getting it to the 
point where it was hosting itself and sparse (and doing nothing else), and 
it was ready for other people to start writing things. (That is to say, 
your main task was finding a new SCM, and you were playing with monotone 
as the expected solution, but it was so slow you had time to write git 
while you were waiting for monotone to run)

> And hosting git itself was not that important for me - hosting the kernel 
> was. And the first kernel commit was April 16 (with the first merges being 
> a few days later). Which meshes with my "two week goal" recollection.
> 
> Not that I'd normally be entirely sure I hit any time goals I set, but I 
> *am* pretty sure that I decided that in order to be effective, I didn't 
> want to do kernel development at the same time as git development, so the 
> "April 3" date of the 2.6.12-rc2 release is fairly significant.

You did mention getting 2.6.12-rc2 done, and then spending the ensuing 
calm time doing something about replacing BK, and it sounded like 2 weeks 
was a time limit for getting something in place, even if it was only a 
temporary solution. After two weeks, git was suitable for the immediate 
task of applying patches from other people, and then people started 
figuring out workflows around it.

	-Daniel
*This .sig left intentionally blank*
