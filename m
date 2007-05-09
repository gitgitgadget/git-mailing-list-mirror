From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Wed, 9 May 2007 13:18:45 -0400
Message-ID: <20070509171845.GC23778@fieldses.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> <vpqbqgxak1i.fsf@bauges.imag.fr> <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com> <alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org> <20070509134151.GT4489@pasky.or.cz> <alpine.LFD.0.98.0705090825090.4062@woody.linux-foundation.org> <56b7f5510705090933t261e414es9e3cc63b28b60546@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 19:18:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlpoX-0006An-24
	for gcvg-git@gmane.org; Wed, 09 May 2007 19:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073AbXEIRSx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 13:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756300AbXEIRSx
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 13:18:53 -0400
Received: from mail.fieldses.org ([66.93.2.214]:47340 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755999AbXEIRSw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 13:18:52 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HlpoL-00085q-O7; Wed, 09 May 2007 13:18:45 -0400
Content-Disposition: inline
In-Reply-To: <56b7f5510705090933t261e414es9e3cc63b28b60546@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46754>

On Wed, May 09, 2007 at 09:33:40AM -0700, Dana How wrote:
> Geez,  this is similar [in nature, not scale] to what I've been doing.
> After reading about people "right-clicking on hunks in git-gui",
> I was convinced I needed to force myself to do more manipulations
> inside git itself.  Hmm...
> 
> Maybe, in addition to [or in] the User Manual, git should have some
> workflow examples, which have been cribbed from various emails
> on this list?

That's something several people have asked for, and I think it's a great
idea--I just haven't personally had much time to get to it.  But I'd
happily take even very rough patches and help get them into shape.

The way I'd thought of doing it was having an "examples" section at the
end of each chapter, with subsections for each individual example; see
the one at the end of the "exploring git history" chapter:

	http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#history-examples

They shouldn't use the material introduced in the associated chapter,
but it's also OK to introduce new commands (with references to the man
pages) when their use in the example is pretty self-explanatory.  (In
fact, this is a great way to introduce more commands and options--git
has so many that it would be tedious to try to be comprehensive, but
they'd fit well in examples.)

The patch-editing stuff discussed above might fit best at the end of
"rewriting history and maintaining patch series".

--b.
