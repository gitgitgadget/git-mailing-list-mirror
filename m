From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 20:55:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
 <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227154241.GA8228@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 27 20:55:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM8QN-0005Zd-1l
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 20:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbXB0Tzo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 14:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbXB0Tzo
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 14:55:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:45926 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751796AbXB0Tzn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 14:55:43 -0500
Received: (qmail invoked by alias); 27 Feb 2007 19:55:42 -0000
X-Provags-ID: V01U2FsdGVkX1+9AW5iNTK9oaEebJpMK0LUlU7t7yYjqOJZvT3HIr
	Y6bw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070227154241.GA8228@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40776>

Hi,

On Tue, 27 Feb 2007, Theodore Tso wrote:

> On Tue, Feb 27, 2007 at 01:57:18PM +0100, Johannes Schindelin wrote:
> > git-show, of all, is _not_ plumbing. It is one of the foremost porcelain 
> > programs core Git ships.
> 
> Maybe, but its man page doesn't show it.  The average end-user isn't 
> going to be thinking about blobs, tree objects, and tag objects. 
> Furthermore, the EXAMPLES section in the man page is misformatted due to 
> some ASCII doc issues.  I'll send a patch to correct the EXAMPLES 
> section, but if git-show is a foremost porecelain program the 
> DISCRIPTION section probably needs to be rewritten as well.

Thank you for the patch.

Since you seem to be no old-timer who cannot remember how she learnt about 
certain Git concepts: What documentation did you read, an in which order? 
This might help us making the parts likely to be seen by new users 
better...

> > git show v.37:e2fsck/pass1.c
> 
> Thanks, I just didn't know about tree-ish:pathname syntax, and I've
> been playing with git for a while.
> 
> As a suggestion, maybe we should be moving (or at least copying) things 
> like the <object> identifier syntax from the git-rev-parse manpage 
> (which is plumbing, right?) to the top-level git manpage?

My vote is for moving, and referencing (kind of mv && ln -s).

But that means that you have to explain in a really concise way that Git 
repositories contain blob, tree, commit and tag objects. And what they 
are.

Ciao,
Dscho
