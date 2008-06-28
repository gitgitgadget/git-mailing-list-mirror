From: Theodore Tso <tytso@mit.edu>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 21:17:24 -0400
Message-ID: <20080628011723.GB15463@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Anderson <rwa000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Jeske <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 03:18:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCP5b-0003zE-7B
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 03:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbYF1BRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 21:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753820AbYF1BRk
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 21:17:40 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:33431 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753815AbYF1BRf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 21:17:35 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KCP48-0001t2-NN; Fri, 27 Jun 2008 21:17:24 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KCP48-0004Cd-8B; Fri, 27 Jun 2008 21:17:24 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86687>

On Fri, Jun 27, 2008 at 08:29:15PM -0000, David Jeske wrote:
> git has all the concepts I want except one. However, it makes the process
> pretty manual. Here is an idea about automating it. I'll talk about that one
> new concept at the bottom.
> 
> I think of this as reorder/merge/split...
> 
> reorder: Picture that a list of commits on this branch opens in an
> editor. You are free to rearrange the lines in any order you want,
> but you have to keep all the lines. When you are done reordering the
> lines, the tool creates a new topic branch and applies the changes
> (probably with cherrypick) to the new topic branch. If there are no
> conflicts, you're done.....

Read the man page for for "git rebase --interactive".  I think you
will find that it handles reording and merging (its called squashing)
already.

Splitting patches is harder to do and probably is one of the things
you have to do manually.

						- Ted
