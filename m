From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Partial checkouts / submodules
Date: Tue, 20 Nov 2007 13:36:02 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711201329490.32410@iabervon.org>
References: <20071120155922.GA6271@pvv.org> <Pine.LNX.4.64.0711201226320.32410@iabervon.org>
 <1AD9B065-647B-4672-B6B0-8D4447960913@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 19:39:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuY0O-0006Qc-Ow
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 19:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764090AbXKTSgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 13:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762486AbXKTSgK
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 13:36:10 -0500
Received: from iabervon.org ([66.92.72.58]:57417 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764083AbXKTSgF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 13:36:05 -0500
Received: (qmail 10522 invoked by uid 1000); 20 Nov 2007 18:36:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Nov 2007 18:36:02 -0000
In-Reply-To: <1AD9B065-647B-4672-B6B0-8D4447960913@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65563>

On Tue, 20 Nov 2007, Steven Grimm wrote:

> On Nov 20, 2007, at 10:03 AM, Daniel Barkalow wrote:
> >This has theoretical problems: it's going to be practically impossible, in
> >most cases, to write a commit message that describes changes in three
> >submodules (which are sometimes used in the context of a different
> >supermodule) as well as the supermodule.
> 
> I got the impression from his email that there *are* no other supermodules.
> The submodules are submodules purely to reduce the amount of data people have
> to transfer around, not because they're logically distinct from the parent.

He said:

"there are multiple superprojects sharing some of the submodules."

Getting the effect of partial checkouts was the first-listed reason, but 
not the only one. The submodules don't make sense except in the context of 
some supermodule, but there are multiple contexts they each appear in.

	-Daniel
*This .sig left intentionally blank*
