From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Add git-mergetool to run an appropriate merge conflict resolution program
Date: Thu, 29 Mar 2007 10:20:44 -0400
Message-ID: <20070329142044.GH2913@thunk.org>
References: <E1HORtY-0000zK-8B@candygram.thunk.org> <7vabxwbszq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 16:20:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWvUh-0007i5-8g
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 16:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbXC2OUq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 10:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753677AbXC2OUq
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 10:20:46 -0400
Received: from thunk.org ([69.25.196.29]:42335 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676AbXC2OUp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 10:20:45 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HWvac-00075Q-If; Thu, 29 Mar 2007 10:26:58 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HWvUa-0006lI-Cr; Thu, 29 Mar 2007 10:20:44 -0400
Content-Disposition: inline
In-Reply-To: <7vabxwbszq.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43435>

On Wed, Mar 28, 2007 at 08:58:49PM -0700, Junio C Hamano wrote:
> I had a chance to use git-mergetool in real life for the first
> time today, when I merged 'maint' into 'master'.  It has a
> symlink vs symlink conflict, so I got something like this:
> 
> A few observations.
> 
> (1) Saying "a" <Return> does not let me exit.  It keeps asking
>     the same question.

Yeah, I fixed that last night, along with a bunch of other git
mergetool cleanups.  I was about to request you to do a pull when I
noticed your e-mail. 

> (2) The word "symlink" might be less geekish if worded "symbolic
>     link".
> 
> (3) The message look very long, and repeats the same information.
> 
> (4) The status info gives local and then remote, but the choice
>     is between remote and local.
> 
> The attached is a minimum fix for the above issues, but not for
> immediate application, as I am sure the rewording would make
> messages inconsistent with other cases.  

OK, let me fix up the display and try to clean up the other messages.
I agree that your output looks much nicer.

						- Ted
