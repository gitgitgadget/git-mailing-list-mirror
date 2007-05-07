From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Mon, 7 May 2007 13:05:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705071301230.4167@racer.site>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
 <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
 <vpqbqgxak1i.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705070146140.4167@racer.site>
 <vpqd51duklo.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon May 07 13:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl123-0005Of-CJ
	for gcvg-git@gmane.org; Mon, 07 May 2007 13:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbXEGLF2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 07:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbXEGLF2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 07:05:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:36505 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932247AbXEGLF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 07:05:27 -0400
Received: (qmail invoked by alias); 07 May 2007 11:05:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 07 May 2007 13:05:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LsnA4zXCLfnCTpRh5pMCYkOsaJSfn52JrTBAPSf
	2yQh/RPtnP0Lt1
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqd51duklo.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46444>

Hi,

On Mon, 7 May 2007, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Just another reason to hate CVS. Because it trained people to do that. If 
> > it was not for the training by CVS, I would have strongly opposed to the 
> > introduction of the "-m" switch to commit. It _encourages_ bad commit 
> > messages.
> 
> Well, this really depends on the use-case, size of commit, ...

Okay, so I use "-m" myself sometimes.

> I often use a version control system for very low importance stuff. I 
> don't want to type a 3-lines long message to describe a 2-lines long 
> change in my ~/.emacs.el for example.

IIRC our record is 90+ lines of commit message for a one-line change.

> I also work with people using (sorry) svn to work collaboratively, but 
> they don't even provide a log message: the version control system here 
> is just a replacement for unison/NFS/whatever other way to have people 
> edit files from different machines.

I positively _hate_ empty commit messages. There is _always_ something to 
be said about the intent of the change, that has no place in the code.

> For sure, in a context where code quality and review is important, -m 
> "xxx" isn't the way (except if you prefer your shell's line editor to 
> your actual editor).

I also find it very useful for my own pleasure when reviewing some logs. I 
track config files, small scripts, documents, etc. with Git, and I found 
myself looking for something in _all_ of them. The commit messages helped.

Commit messages, BTW, are somewhat of an artform. You cannot imagine how 
slow I am writing them, because they should be helpful not only for the 
reviewer, but also for the casual git-blame user, who wants to find out 
the rationale of a change.

Ciao,
Dscho
