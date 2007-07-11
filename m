From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH 3/4] --decorate now decorates ancestors, too
Date: Tue, 10 Jul 2007 22:27:14 -0400
Message-ID: <20070711022714.GI27033@thunk.org>
References: <Pine.LNX.4.64.0707110220340.4047@racer.site> <Pine.LNX.4.64.0707110229320.4047@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 11 04:27:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8RvG-00011O-88
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 04:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbXGKC1S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 22:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbXGKC1S
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 22:27:18 -0400
Received: from THUNK.ORG ([69.25.196.29]:44432 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbXGKC1S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 22:27:18 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I8S3A-0008LF-Bj; Tue, 10 Jul 2007 22:35:32 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I8Rv8-0004AS-KX; Tue, 10 Jul 2007 22:27:14 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707110229320.4047@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52128>

On Wed, Jul 11, 2007 at 02:29:49AM +0100, Johannes Schindelin wrote:
> 
> The option --decorate changed default behavior: Earlier, it decorated
> commits pointed to by any ref.  The new behavior is this: decorate the
> with the given refs and its ancestors, i.e.
> 
> 	git log --decorate next master
> 
> will show "next", "next^", "next~2", ..., "master", "master^", ...
> in parenthesis after the commit name.

I'm wondering how useful the default is.  The arguments get used for
two things; both for git-log to decide what revisions to display, and
which refs to decorate, right?  I'm not sure that overloading is such
a great idea.

Also, I note that "git log --decorate" does nothing at all.  Maybe it
would be better to keep the default to be "any-ref" instead of "given"?

		      	 	   	    - Ted
