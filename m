From: Theodore Tso <tytso@mit.edu>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 22:47:35 -0400
Message-ID: <20080717024735.GA23896@mit.edu>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com> <7v7iblsnfh.fsf@gitster.siamese.dyndns.org> <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com> <7vmykhr6h1.fsf@gitster.siamese.dyndns.org> <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com> <alpine.DEB.1.00.0807170024310.4318@eeepc-johanness> <20080716224954.GL2167@mit.edu> <alpine.DEB.1.00.0807170218280.4318@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 04:49:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJJYG-00064i-8t
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 04:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760170AbYGQCrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 22:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753813AbYGQCrn
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 22:47:43 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:42862 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760166AbYGQCrm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 22:47:42 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KJJWq-0000Cu-TA; Wed, 16 Jul 2008 22:47:36 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KJJWp-0006X9-Ri; Wed, 16 Jul 2008 22:47:35 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807170218280.4318@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88800>

On Thu, Jul 17, 2008 at 02:25:05AM +0200, Johannes Schindelin wrote:
> Well, rev-parse is one of my pet peeves this day.  rev-parse is _nothing_ 
> but plumbing.

Actually the the git man page doesn't list rev-parse as plumbing.  :-)

> Actually, the problem arose with a few "tutorials" on the web, and their 
> creators violently arguing for their ways (and me being more and more 
> uncertain if they are wrong or me).

I know you don't like hearing about SVN, but normally the tutorials I
tend to point people to, in addition to the standard official git
tutorial and git's user manual, are these two web pages.  First I tell
people to read first part of:

       http://utsl.gen.nz/talks/git-svn/intro.html

which covers the git "philosophy" very nicely, up to the point where
it starts talking about the "git svn" command, and then I tell them to
go read:

	http://git.or.cz/course/svn.html

There are no git plumbing commands in either of those two web pages,
because most SVN users would run screaming if they were given a
tutorial that talked about git-read-tree or git-commit-tree.  :-)

							- Ted
