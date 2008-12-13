From: Nick Andrew <nick@nick-andrew.net>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Sun, 14 Dec 2008 10:05:05 +1100
Message-ID: <20081213230504.GA21912@mail.local.tull.net>
References: <alpine.DEB.1.00.0812121952320.5873@eeepc-johanness> <20081212182827.28408.40963.stgit@warthog.procyon.org.uk> <29095.1229109133@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	torvalds@osdl.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: David Howells <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 00:06:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBdZE-0002PY-SJ
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 00:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbYLMXFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 18:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbYLMXFK
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 18:05:10 -0500
Received: from vps1.tull.net ([66.180.172.116]:59636 "HELO vps1.tull.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751884AbYLMXFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 18:05:09 -0500
Received: (qmail 1481 invoked by uid 1015); 14 Dec 2008 10:05:08 +1100
Received: from [10.0.0.67] (HELO tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Sun, 14 Dec 2008 10:05:08 +1100
Received: (qmail 22335 invoked by uid 1000); 14 Dec 2008 10:05:05 +1100
Content-Disposition: inline
In-Reply-To: <29095.1229109133@redhat.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103034>

On Fri, Dec 12, 2008 at 07:12:13PM +0000, David Howells wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> > So I think that your document might do a good job scaring people away from 
> > Git.  But I do not believe that your document, especially in the tone it 
> > is written, does a good job of helping Git newbies.
> 
> Hmmm.  So what would you suggest is a good way to write for GIT newbies?  Is
> it just that the overview should be canned or drastically simplified?

The way I did it was to start with the directed acyclic graph of
commits, explaining how branches fork the graph and merges join
it. This was presented to people who know subversion, and so they
immediately became aware that there are other ways to manage source
code than in a linear r1 r2 r3 r4 r5. I described tags and branch
heads briefly.

Next up I described the things you'd do with git: add new commits,
create a branch, merge a branch, rebase, tag, push and fetch and
showed what that does with the dag of commits.

Finally I showed the actual commands used to perform those actions.
I didn't get into the object database structure at all (that was
prepared in case I had extra time).

I think a tutorial shouldn't be written in a way that polarises
peoples' opinions or they come to regard git as a "necessary evil".
If the audience is a person who knows nothing about git, that's
hardly a "git hater" and I think the document starts off on the
wrong foot as a result.

Nick.
