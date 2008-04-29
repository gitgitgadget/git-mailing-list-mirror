From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: my git problem
Date: Tue, 29 Apr 2008 13:15:19 -0400
Message-ID: <20080429171519.GA21310@fieldses.org>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org> <20080427124454.6a606305.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org> <20080428114509.240ef4ae.akpm@linux-foundation.org> <alpine.DEB.1.00.0804281948270.19187@eeepc-johanness> <20080428120917.dd9f01e8.akpm@linux-foundation.org> <alpine.DEB.1.00.0804282012140.19187@eeepc-johanness> <alpine.LFD.1.10.0804281222190.3119@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 19:16:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqtRE-0006rR-Ru
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 19:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbYD2RPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 13:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753740AbYD2RPY
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 13:15:24 -0400
Received: from mail.fieldses.org ([66.93.2.214]:35763 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596AbYD2RPW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 13:15:22 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1JqtQF-0005mE-IX; Tue, 29 Apr 2008 13:15:19 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804281222190.3119@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80707>

On Mon, Apr 28, 2008 at 12:28:38PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 28 Apr 2008, Johannes Schindelin wrote:
> > 
> > On Mon, 28 Apr 2008, Andrew Morton wrote:
> > > 
> > > That's missing the "logical" bit :)
> > 
> > Heh, you're right.  I am too used to Git to think how other people would 
> > feel about these things... :-)
> 
> No, you are both wrong.
> 
> You're wrong because apparently you never did abstract algebra and set 
> theory in school.

Hmph.  I've got a PhD in algebra and still find that choice of operators
confusing.

(Which may just be further evidence that one can take a lot of classes
and still be an idiot.)

> If you know math, git actually does the rigth and very much the *logical* 
> thing.
> 
> So ".." is a simple difference, while "..." is a more complex difference. 
> 
> They mean different things for different operation types, but that is 
> again something a math person takes for granted (ie in algebra, a "+" or 
> "-" is just a random operation that follows certain rules: "a-b" means one 
> thing for the set of real numbers, and something *totally* different if 
> you are talking about set algebra).

I suspect one reason the set-difference operator is more commonly
written with a backslash than a minus sign is that set difference is
different enough from anything else usually called subtraction that most
people find it confusing to use the same notation.

I can sorta buy the argument that "A...B" means most generally "some
kind of difference between the three sets A, A^B, and B", and that in
the context of "git diff" it's most sensible to take ordering into
account and produce some approximation of a diff between A^B and B.  I'd
personally have found an entirely separate operator simpler to
understand.  But perhaps there's only so many keys on the keyboard.

--b.
