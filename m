From: Theodore Tso <tytso@mit.edu>
Subject: Re: git-pull and tag objects
Date: Mon, 12 Feb 2007 11:27:45 -0500
Message-ID: <20070212162745.GB2741@thunk.org>
References: <1170933407.15431.38.camel@okra.transitives.com> <81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com> <7v4ppurka1.fsf@assigned-by-dhcp.cox.net> <20070210142322.GB25607@thunk.org> <Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org> <7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 17:28:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGe2X-0006q1-Go
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 17:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbXBLQ2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 11:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbXBLQ2I
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 11:28:08 -0500
Received: from thunk.org ([69.25.196.29]:58967 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964893AbXBLQ2H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 11:28:07 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HGe76-0005h3-8Q; Mon, 12 Feb 2007 11:33:12 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HGe1p-0007Zr-F7; Mon, 12 Feb 2007 11:27:45 -0500
Content-Disposition: inline
In-Reply-To: <7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39410>

On Sat, Feb 10, 2007 at 09:52:29PM -0800, Junio C Hamano wrote:
> Although it is correct that the people who already saw the
> original tag would not lose the tag object from their repository
> when you publish a replacement tag, we have _always_ overwritten
> the refs/tags/$tag to point at the new one, effectively losing
> the original.

So I have a suspicion that I have multiple tag objects with the same
tag name (E2FSPROGS-1_26), from doing an hg conversion.  Is there an
easy way to search all of the tag objects in my git repository to see
if this is the case, so I can delete them lest they cause any
confusion/problems?

						- Ted
