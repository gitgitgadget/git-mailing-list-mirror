From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Thu, 30 Oct 2008 19:27:17 -0400
Message-ID: <20081030232717.GB10779@mit.edu>
References: <1225338485-11046-1-git-send-email-sam@vilain.net> <20081030143918.GB14744@mit.edu> <1225389068.19891.28.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <samv@vilain.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Oct 31 00:28:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvgwf-0006U9-Al
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 00:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbYJ3X1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 19:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753530AbYJ3X1U
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 19:27:20 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:37554 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754280AbYJ3X1T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 19:27:19 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1Kvgv7-0003s9-WC; Thu, 30 Oct 2008 19:27:18 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1Kvgv7-0005Ox-D4; Thu, 30 Oct 2008 19:27:17 -0400
Content-Disposition: inline
In-Reply-To: <1225389068.19891.28.camel@maia.lan>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99533>

On Thu, Oct 30, 2008 at 10:51:08AM -0700, Sam Vilain wrote:
> 
> Well, I don't have strong feelings on the exact command name used; I
> suggested "undo", probably also ambiguous.  But still, a significant
> number of users are surprised when they type 'git revert' and they get a
> backed out patch.

Yeah, that's why I suggested "git revert-file".  It's less ambiguous
than "undo", and it's easier for people used to "hg revert" and "svn
revert" to find "git revert-file".  And, it won't be run accidentally
by old-timers who are used to the old (to be deprecated) "git revert".
But I'm not that picky about the name; I just missed the "git undo"
proposal in your patch.

> Making it plain "revert" would violate expectations of existing users;
> it seems a better idea to just deprecate it, and point the users to the
> new method - cherry-pick --revert - or the command they might have meant
> - whatever that becomes.

Yup, I agree; that's why I suggested "git revert-file".

							- Ted
