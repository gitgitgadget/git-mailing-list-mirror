From: Theodore Tso <tytso@mit.edu>
Subject: Re: Questions about git-rev-parse
Date: Tue, 27 Feb 2007 21:52:58 -0500
Message-ID: <20070228025258.GD2178@thunk.org>
References: <E1HMETh-0004BO-Lw@candygram.thunk.org> <7vvehn2eds.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 03:53:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMEwH-0003o3-If
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 03:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbXB1CxE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 21:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbXB1CxE
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 21:53:04 -0500
Received: from thunk.org ([69.25.196.29]:40790 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbXB1CxB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 21:53:01 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HMF1b-0004ME-Mj; Tue, 27 Feb 2007 21:58:39 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HMEw6-0005rM-Ci; Tue, 27 Feb 2007 21:52:59 -0500
Content-Disposition: inline
In-Reply-To: <7vvehn2eds.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40879>

On Tue, Feb 27, 2007 at 06:40:47PM -0800, Junio C Hamano wrote:
> You are lacking historical context that our porcelain-ish were

So while I'm asking questions, where did the "*-ish" terminology come
from, anyway?  For someone who is a relative newbie, terms like
tree-ish and commit-ish seems like some kind of strange, git jargon.
And this is the first time I've come across porcelian-ish.

I had the mental model (which I had intuited, since no git
documentation I could find had bothered to explain it) that -ish meant
something like specifier, so "tree-ish" meant tree specifier, so a
commit id could get dereferenced into a tree id, so it could be used
to specify a tree.

But that explanation doesn't explain "porcelain-ish".  

So what does -ish mean, really?  Where did it come from?  And if it
does add value to use this wierd bit of git jargon, can we document it
somewhere, preferably in a tutorial and main git man page?  It used in
too many places that it's probably not worth it to rip it out, but I
can tell you that for someone who is learning git from the ground up,
it would be easier if we used some term like <tree_specifier> instead
of <tree-ish>.  

Regards,

						- Ted
