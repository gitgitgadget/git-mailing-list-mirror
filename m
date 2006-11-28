X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Theodore Tso <tytso@mit.edu>
Subject: Re: Hyphens and hiding core commands
Date: Tue, 28 Nov 2006 00:40:32 -0500
Message-ID: <20061128054032.GC11122@thunk.org>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home> <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org> <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org> <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org> <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 05:40:43 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32484>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Govhx-0001Cy-Pq for gcvg-git@gmane.org; Tue, 28 Nov
 2006 06:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935623AbWK1Fki (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 00:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935622AbWK1Fki
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 00:40:38 -0500
Received: from thunk.org ([69.25.196.29]:65188 "EHLO thunker.thunk.org") by
 vger.kernel.org with ESMTP id S935621AbWK1Fki (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 00:40:38 -0500
Received: from root (helo=candygram.thunk.org) by thunker.thunk.org with
 local-esmtps  (tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1
 (Debian)) id 1GovlV-0003Tk-Kg; Tue, 28 Nov 2006 00:44:21 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
 (envelope-from <tytso@thunk.org>) id 1Govho-0006UG-Lv; Tue, 28 Nov 2006
 00:40:32 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Mon, Nov 27, 2006 at 06:18:54PM -0800, Junio C Hamano wrote:
> Read what I wrote again.  You can explain it without talking
> about index at all.  I really do not think you need to break
> "git commit" nor rename "update-index" to "resolve" to explain
> things to new people.

I think you're both right, and talking past each other to a certain
extent.  Yes, pedagogically it would be better to talk about "git
commit Makefile hello.c ..."; and "git commit -a" as a short-cut to
not have to list all of the files explicitly.

> The tutorial might be better reworked not to start talking about
> -a but start building small project from a newly created
> hello.c, git add it, and "git commit" (the first commit), then
> edit hello.c and "git commit hello.c" (the second commit).
> 
> Perhaps.

Carl was saying that the totorial should be changed to do this.  I
would change "perhaps" to "DEFINITELY".  

I would go further and argue that the man page for git-commit should
be changed to list the:

	git commit file ...
and
	git -a

alternatives first, and then talk about the index in a subsequent
paragraph (perhaps with a note that the first two usages are best for
novice users) might also be a good idea.  Yes, the man page is
supposed to be a reference, but some novice users do bother to try to
learn by reading the man page (shock!  horror!), and it might be good
if they don't run screaming into the night.

But hey, there's room for many distributed SCM's, and we can always
let those users use Mercurial and be happy....  (Just know that
project leaders who are worried about keeping their developer base
broad might choose Mercurial because it has a gentler learning curve
--- and that perhaps a few simple documentation changes plus some
syntatic sugar might make git much more attractive to them and to
novice git users.)

