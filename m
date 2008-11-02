From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Sun, 2 Nov 2008 04:56:58 -0500
Message-ID: <20081102095658.GH8134@mit.edu>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz> <20081031003154.GA5745@sigill.intra.peff.net> <1225435238.20883.18.camel@maia.lan> <20081102041832.GB5261@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Sam Vilain <samv@vilain.net>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 02 10:58:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwZiy-0001ac-01
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 10:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbYKBJ5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 04:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbYKBJ5J
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 04:57:09 -0500
Received: from www.church-of-our-saviour.org ([69.25.196.31]:46183 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753282AbYKBJ5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 04:57:07 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KwZha-0004xT-Sb; Sun, 02 Nov 2008 04:56:59 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KwZha-00084F-8J; Sun, 02 Nov 2008 04:56:58 -0500
Content-Disposition: inline
In-Reply-To: <20081102041832.GB5261@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99837>

On Sun, Nov 02, 2008 at 12:18:33AM -0400, Jeff King wrote:
> 
> Yeah, revert-files is pretty painful to type. And I'm not looking
> forward to fielding UI questions about "why isn't it just revert?" :)
> 

At least for me, I don't use it *that* often, so it's not that painful
for me (I have it as an "git revert-file" as an alias already).   

And the answer, "because 'git revert' used to do something else" is I
think a perfectly reasonable answer.  I probably do "git revert-files"
about 3-5 times more often than I do "git revert", so it's a bit
strange from a character count perspective, but history is history.

> Somebody suggested "clobber", which I think is a bit _too_ intense.
> 
> I guess something like "retrieve" is too ambiguous. You really need
> something that implies movement of content, and something that implies
> the working directory. "Checkout" is actually not a bad name; if only we
> had "git switch" instead of "git checkout" for switching branches, it
> would be perfect.

If people really want a shorter name, how about bk's "unedit"?  I'd
still worry about people being able to find it, since the reality is
that most of the world knows this command as revert, though.

     	     	       	     	  	     	     - Ted
