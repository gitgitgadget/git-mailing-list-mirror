From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 18:16:26 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601311750270.25300@iabervon.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 00:14:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F44hU-0002J3-MU
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 00:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWAaXOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 18:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWAaXOM
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 18:14:12 -0500
Received: from iabervon.org ([66.92.72.58]:2574 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751067AbWAaXOK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 18:14:10 -0500
Received: (qmail 4469 invoked by uid 1000); 31 Jan 2006 18:16:26 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jan 2006 18:16:26 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15361>

On Tue, 31 Jan 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 30 Jan 2006, Carl Baldwin wrote:
> 
> > In general, I think it is grasping the reason for the index file and how 
> > git commands like git-commit and git-diff interact with it.
> 
> IMHO this is the one big showstopper. I had problems explaining the 
> concept myself.
> 
> For example, I had a hard time explaining to a friend why a git-add'ed 
> file is committed when saying "git commit some_other_file", but not 
> another (modified) file. Very unintuitive.

I sort of suspect that "git commit some_other_file" should really read 
HEAD into a temporary index, update "some_other_file" in that (and the 
main index), and commit it. The concept of the index isn't hard (it's the 
preparation you've made so far towards a commit), and plain "git commit" 
makes sense with it; "git commit -a" also makes sense, since committing 
all changes is pretty clear. The surprising thing is that "git commit path 
..." means "everything I've already mentioned, plus path..." not just 
"path ...", and it's particularly surprising because people only tend to 
specify paths when they've done something they don't want to commit.

	-Daniel
*This .sig left intentionally blank*
