From: Theodore Tso <tytso@mit.edu>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 20:27:48 -0400
Message-ID: <20060929002748.GA11055@thunk.org>
References: <Pine.LNX.4.64.0609281043380.3952@g5.osdl.org> <20060928191816.76466.qmail@web51014.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Rogan Dawes <discard@dawes.za.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 02:29:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT6FI-0007Xr-7U
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 02:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161226AbWI2A2S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 20:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161224AbWI2A2Q
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 20:28:16 -0400
Received: from thunk.org ([69.25.196.29]:21698 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1161223AbWI2A2J (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 20:28:09 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1GT6Gk-000075-TY; Thu, 28 Sep 2006 20:30:23 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.60)
	(envelope-from <tytso@thunk.org>)
	id 1GT6EG-0005jz-F5; Thu, 28 Sep 2006 20:27:48 -0400
To: Matthew L Foster <mfoster167@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20060928191816.76466.qmail@web51014.mail.yahoo.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28079>

On Thu, Sep 28, 2006 at 12:18:15PM -0700, Matthew L Foster wrote:
> --- Linus Torvalds <torvalds@osdl.org> wrote:
>  
> >  - it means that the -same- exact project, when looked at frm two 
> >    different sites that mirror it, have totally different times. In other 
> >    words, the times have become pointless for something like gitweb.
> 
> Mirrored git repos probably should use the same timestamp, e.g. the
> "master" or "private" git server's local time. Replicated repos have
> a delay compared to when you made changes in your private repo, that
> is ok, replication is not what makes commit order inconsistent with
> time, it's the act of pulling/merging from a server with
> misconfigured time and gitweb.cgi trusting "creation time", right?
> Or is replication the same thing as merging/pulling?

Git mirroring takes place using the same pushing and pulling that are
used with multiple repositories.  That's why if Linus does a huge
amount of work over the period of a day or two in his private
repository, and then publishes it master.kernel.org, the "local" time
on master.kernel.org will be the time when they are pushed to
master.kernel.org, because it's done via the same operation as any
other repository push or pull.

That's what everyone has been trying to tell you for this entire
thread....

						- Ted
