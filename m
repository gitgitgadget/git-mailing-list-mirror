From: Theodore Tso <tytso@mit.edu>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 18:49:54 -0400
Message-ID: <20080716224954.GL2167@mit.edu>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com> <7v7iblsnfh.fsf@gitster.siamese.dyndns.org> <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com> <7vmykhr6h1.fsf@gitster.siamese.dyndns.org> <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com> <alpine.DEB.1.00.0807170024310.4318@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 00:51:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJFpq-00063P-2N
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 00:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736AbYGPWt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 18:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbYGPWt6
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 18:49:58 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:37705 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752012AbYGPWt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 18:49:57 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KJFoo-0005RW-Sm; Wed, 16 Jul 2008 18:49:54 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KJFoo-0005BE-Aa; Wed, 16 Jul 2008 18:49:54 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807170024310.4318@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88777>

On Thu, Jul 17, 2008 at 12:28:27AM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 16 Jul 2008, Avery Pennarun wrote:
> 
> > I find it interesting how git usability discussions tend to go.
> 
> I find it not interesting at all, even slightly annoying, that I cannot 
> seem to start a perfectly valid discussion about advocating porcelain, and 
> trying to even avoid mentioning plumbing in user-visible documentation, 
> without somebody highjacking the thread to talk about svn.

I've already said I agree with you, but maybe it would be helpful if
you focused the discussion a little more with a concrete suggestion
about how we could improve the user-visible documentation.  For
example, it is already the case that "git help" only shows porcelain
commands, that has been a big step forward.

So a concrete suggestion might be to move the list of plumbing
commands from the top-level git man page to a "git-plumbing" man page.

I'll note that the git user manual is pretty good about avoiding the
use of git plumbing commands.  It's not until Chapter 9, "Low Level
Git Commands" that it start going into the plumbing.  (There are a
couple of mentions of git rev-parse before chapter 9, but that's about
it that I could find).

Was there other git documentation where you think there is too many
references to git plumbing?

						- Ted
