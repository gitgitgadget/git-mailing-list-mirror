From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 00:03:52 -0500
Message-ID: <47BFA938.3050504@garzik.org>
References: <200802221837.37680.chase.venters@clientec.com> <alpine.LNX.1.00.0802222249480.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Chase Venters <chase.venters@clientec.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 06:04:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSmYr-0004jV-2n
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 06:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbYBWFD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 00:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbYBWFD5
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 00:03:57 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:60907 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbYBWFD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 00:03:56 -0500
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.66 #1 (Red Hat Linux))
	id 1JSmYD-0001Nv-Cj; Sat, 23 Feb 2008 05:03:54 +0000
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <alpine.LNX.1.00.0802222249480.19024@iabervon.org>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74800>

Daniel Barkalow wrote:
> I find that the sequence of changes I make is pretty much unrelated to the 
> sequence of changes that end up in the project's history, because my 
> changes as I make them involve writing a lot of stubs (so I can build) and 
> then filling them out. It's beneficial to have version control on this so 
> that, if I screw up filling out a stub, I can get back to where I was.
> 
> Having made a complete series, I then generate a new series of commits, 
> each of which does one thing, without any bugs that I've resolved, such 
> that the net result is the end of the messy history, except with any 
> debugging or useless stuff skipped. It's this series that gets merged into 
> the project history, and I discard the other history.
> 
> The real trick is that the early patches in a lot of series often refactor 
> existing code in ways that are generally good and necessary for your 
> eventual outcome, but which you'd never think of until you've written more 
> of the series.

That summarizes well how I do original development, too.  Whether its a 
branch of an existing repo, or a newly cloned repo, when working on new 
code I will do a first pass, committing as I go to provide useful 
checkpoints.

Once I reach a satisfactory state, I'll refactor the patches so that 
they make sense for upstream submission.

	Jeff
