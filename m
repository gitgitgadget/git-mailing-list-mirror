From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] mergetool: add support for ECMerge
Date: Mon, 8 Oct 2007 17:44:51 -0400
Message-ID: <20071008214451.GB31713@thunk.org>
References: <11918785613855-git-send-email-prohaska@zib.de> <11918785611059-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 23:45:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If0PQ-0001wk-1s
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 23:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbXJHVoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 17:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbXJHVoy
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 17:44:54 -0400
Received: from THUNK.ORG ([69.25.196.29]:36782 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753344AbXJHVoy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 17:44:54 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1If0Yw-0000zc-I9; Mon, 08 Oct 2007 17:54:54 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1If0PD-0002ux-Ec; Mon, 08 Oct 2007 17:44:51 -0400
Content-Disposition: inline
In-Reply-To: <11918785611059-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60342>

On Mon, Oct 08, 2007 at 11:22:41PM +0200, Steffen Prohaska wrote:
> Add support for ECMerge available from
> http://www.elliecomputing.com/Products/merge_overview.asp

Hmm.  A propietary merge tool.  It's not that much code, so I guess....

I note though that it claims on the web page that they are integrated
with "most famous SCM's", but they don't include git.  If we add this
support, are they going to change their web page?  :-)

Also, ECmerge is supported on Linux, Solaris, MacOS X, and Windows.
Which platforms have you tested on?  My guess is that if it works on
Linux, it'll probably work on Solaris and MacOS, but is it a fair
guess you haven't tested under Windows?  Not that most Windows systems
are going to be able to use git-mergetool since it's a bash script,
unless they are using Cygwin or some such.

       	    	      	     	     - Ted
