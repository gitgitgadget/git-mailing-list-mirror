From: Theodore Tso <tytso@mit.edu>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Mon, 4 Jun 2007 09:18:47 -0400
Message-ID: <20070604131846.GC20342@thunk.org>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bryan Childs <godeater@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 15:19:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvCSg-00054Q-Lz
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 15:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbXFDNTC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 09:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbXFDNTB
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 09:19:01 -0400
Received: from THUNK.ORG ([69.25.196.29]:53032 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbXFDNTB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 09:19:01 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HvCZt-0000LM-EL; Mon, 04 Jun 2007 09:26:33 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HvCSN-0000jW-1B; Mon, 04 Jun 2007 09:18:47 -0400
Content-Disposition: inline
In-Reply-To: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49099>

On Mon, Jun 04, 2007 at 12:48:17PM +0100, Bryan Childs wrote:
> 2) Unlike the Linux Kernel, which Linus uses as a prime example of
> something git is very useful for, the Rockbox project has no central
> figurehead for anyone to consider as owning the "master" repository
> from which to build the "current" version of the Rockbox firmware for
> any given target.

> 3) With a central repository, for which we have a limited number of
> individuals having commit access, it's easy for us to automate a build
> based on each commit the repository receives.

You might want to take a look at http://repo.or.cz for an example of
how you can have a limited number of trusted inidividuals with commit
access.  As has been said before, <SCM> is not a substitute for
communication, and if you have multiple people who can commit into a
repository, you had better make sure those trusted individuals with
commit access are talking to each other.  

There are some folks who have created hooks to do more fine-grained
access control systems, if you want to replicate SVN's ability to
control who can commit to which branch.  

Regards,

						- Ted
