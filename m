From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git guidance
Date: Sat, 8 Dec 2007 11:13:55 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712081106200.27959@racer.site>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com>
 <200712071353.11654.a1426z@gawab.com> <m3prxiu3oo.fsf@roke.D-201>
 <200712072204.48410.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Phillip Susi <psusi@cfl.rr.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jing Xue <jingxue@digizenstudio.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Al Boldi <a1426z@gawab.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 12:15:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0xe3-00055R-Ab
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 12:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbXLHLOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 06:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbXLHLOe
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 06:14:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:43269 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751462AbXLHLOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 06:14:33 -0500
Received: (qmail invoked by alias); 08 Dec 2007 11:14:31 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp028) with SMTP; 08 Dec 2007 12:14:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18463F0oiI4428e/4JdKQk45RJixE4dB+omI+mzQ0
	dK8/cdWtHwOatz
X-X-Sender: gene099@racer.site
In-Reply-To: <200712072204.48410.a1426z@gawab.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67541>

Hi,

On Fri, 7 Dec 2007, Al Boldi wrote:

> Jakub Narebski wrote:
>
> > Version control system is all about WORKFLOW B, where programmer 
> > controls when it is time to commit (and in private repository he/she 
> > can then rewrite history to arrive at "Perfect patch series"[*1*]); 
> > something that for example CVS failed at, requiring programmer to do a 
> > merge if upstream has any changes when trying to commit.
> 
> Because WORKFLOW C is transparent, it won't affect other workflows.  So 
> you could still use your normal WORKFLOW B in addition to WORKFLOW C, 
> gaining an additional level of version control detail at no extra cost 
> other than the git-engine scratch repository overhead.
> 
> BTW, is git efficient enough to handle WORKFLOW C?

The question is not if git is efficient enough to handle workflow C, but 
if that worflow is efficient enough to help anybody.

Guess what takes me the longest time when committing?  The commit message.  
But it is really helpful, so there is a _point_ in writing one, and there 
is a _point_ in committing when I do it: it is a point in time where I 
expect the tree to be in a good shape, to be compilable, and to solve a 
specific problem which I describe in the commit message.

So I absolutely hate this "transparency".  Git _is_ transparent; it does 
not affect any of my other tools; they still work very well 
thankyouverymuch.

What your version of "transparency" would do: destroy bisectability, make 
an absolute gibberish of the history, and more!

Nobody could read the output of "git log" and form an understanding what 
was done.  Nobody could read the commit message for a certain "git blame"d 
line that she tries to make sense of.

IOW you would revert the whole meaning of the term Source Code Management.

Hth,
Dscho
