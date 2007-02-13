From: Theodore Tso <tytso@mit.edu>
Subject: Re: linux-2.6.git/packed-refs???
Date: Tue, 13 Feb 2007 13:16:10 -0500
Message-ID: <20070213181610.GA2782@thunk.org>
References: <7v7ium1k7s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@linux-foundation.org, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 19:16:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH2CV-00056k-Df
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbXBMSQU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbXBMSQU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:16:20 -0500
Received: from thunk.org ([69.25.196.29]:60244 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429AbXBMSQT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:16:19 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HH2HZ-0002OX-Ul; Tue, 13 Feb 2007 13:21:38 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HH2CJ-0000uR-0I; Tue, 13 Feb 2007 13:16:11 -0500
Content-Disposition: inline
In-Reply-To: <7v7ium1k7s.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39571>

On Tue, Feb 13, 2007 at 01:27:03AM -0800, Junio C Hamano wrote:
> I noticed while scanning #git log that it appears that pack-refs
> was run in your public repo and some people cannot clone over
> dumb protocols with older git.
> 
>     commit 2986c02217f98809d8990e7679edf0f5d99f904d
>     Author: Junio C Hamano <junkio@cox.net>
>     Date:   Wed Nov 22 22:24:09 2006 -0800
> 
>     git-fetch: fix dumb protocol transport to fetch from pack-pruned ref
> 
> was the first revision that aligned dumb protocol clients with
> pack-ref; unfortunately anything older will not find the ref
> that was packed.

Stupid question.  Suppose someone has run git pack-refs on a
repository.  What is the recommended way to reverse the process.  Is
the answer is to clone the repository and then throw away the original
one?  Is there another way to do it?

						- Ted
