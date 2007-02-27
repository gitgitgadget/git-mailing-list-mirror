From: Theodore Tso <tytso@mit.edu>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 10:42:41 -0500
Message-ID: <20070227154241.GA8228@thunk.org>
References: <E1HM1XL-00071C-N5@candygram.thunk.org> <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 19:38:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM7Dh-0006wu-PU
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 19:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbXB0SiY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 13:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbXB0SiY
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 13:38:24 -0500
Received: from thunk.org ([69.25.196.29]:39835 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968AbXB0SiX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 13:38:23 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HM7It-00030L-KQ; Tue, 27 Feb 2007 13:43:59 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HM4TR-0003Mw-I6; Tue, 27 Feb 2007 10:42:41 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40767>

On Tue, Feb 27, 2007 at 01:57:18PM +0100, Johannes Schindelin wrote:
> git-show, of all, is _not_ plumbing. It is one of the foremost porcelain 
> programs core Git ships.

Maybe, but its man page doesn't show it.  The average end-user isn't
going to be thinking about blobs, tree objects, and tag objects.
Furthermore, the EXAMPLES section in the man page is misformatted due
to some ASCII doc issues.  I'll send a patch to correct the EXAMPLES
section, but if git-show is a foremost porecelain program the
DISCRIPTION section probably needs to be rewritten as well.

> git show v.37:e2fsck/pass1.c

Thanks, I just didn't know about tree-ish:pathname syntax, and I've
been playing with git for a while.

As a suggestion, maybe we should be moving (or at least copying)
things like the <object> identifier syntax from the git-rev-parse
manpage (which is plumbing, right?) to the top-level git manpage?  I
don't think it's a good idea to force users to read man pages for
plumbing commands in order to learn key git command-line concepts.

						- Ted
