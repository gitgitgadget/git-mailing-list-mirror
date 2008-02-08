From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor annoyance with git push
Date: Fri, 8 Feb 2008 11:52:44 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802081151170.11591@racer.site>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <46a038f90802072050s46ffe305mcffffa068511e3b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 12:53:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNRn4-0006WH-60
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 12:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235AbYBHLwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 06:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbYBHLwh
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 06:52:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:40220 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751718AbYBHLwg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 06:52:36 -0500
Received: (qmail invoked by alias); 08 Feb 2008 11:52:35 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp009) with SMTP; 08 Feb 2008 12:52:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+esulOfmKezh4TpjH5Q3HxCZFocnu0FBJZqy0Uqr
	S6qiFjIvC30Md8
X-X-Sender: gene099@racer.site
In-Reply-To: <46a038f90802072050s46ffe305mcffffa068511e3b8@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73078>

Hi,

On Fri, 8 Feb 2008, Martin Langhoff wrote:

> On Feb 8, 2008 5:44 PM, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> >  None of these "rejected" branches have anything _new_, they are just 
> > stale. Nothing new to say.
> 
> And I guess the natural follow up question is: would it make sense to 
> tell git pull to do a "merge" for not-checked-out branches where we can 
> safely tell that the resulting "merge" will actually be a fast-forward?

That question comes up pretty often, I think.  But you need a working 
directory to resolve conflicts for merges.  You only have one, though.

So no, I think it is saner to have tracking branches (which are updated 
anyway), and local branches.  And once you're done with a branch, you 
simply push it, and then delete it (you will still have the result in the 
tracking branch).

Ciao,
Dscho
