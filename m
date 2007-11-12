From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH,RFC 1/2] Make the list of common commands more exclusive
Date: Mon, 12 Nov 2007 01:22:22 -0500
Message-ID: <20071112062222.GA17462@thunk.org>
References: <20071111235819.GB7392@thunk.org> <1194829077-14320-1-git-send-email-tytso@mit.edu> <7vzlxk8apz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 07:55:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrTCG-0005jw-VQ
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 07:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbXKLGym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 01:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbXKLGym
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 01:54:42 -0500
Received: from thunk.org ([69.25.196.29]:59176 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbXKLGym (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 01:54:42 -0500
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IrTMC-0003y7-Fr; Mon, 12 Nov 2007 02:05:16 -0500
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1IrSgg-0004YO-V9; Mon, 12 Nov 2007 01:22:23 -0500
Content-Disposition: inline
In-Reply-To: <7vzlxk8apz.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64564>

On Sun, Nov 11, 2007 at 06:21:44PM -0800, Junio C Hamano wrote:
> Theodore Ts'o <tytso@mit.edu> writes:
> 
> > Remove apply, archive, cherry-pick, prune, revert, and show-branch, so
> > "git help" is less intimidating.
> >
> > Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> >
> > -apply
> > -archive
> > -prune
> > -revert
> > -show-branch
> 
> I am fine with this list, perhaps except apply.

I was borderline on apply, but given that people are familiar with
patch -p1, the only real advantage git-apply has is that automatically
deals with new files (which "git commit -a" or "git add -u" won't
automatically get).

What did you think about cherry-pick?  Was that omitted by accident?

> On the other hand, if you are shooting *really* for the absolute
> minimum set for the beginners, I would kill rm and possibly mv)
> in addition to your list:

Those did cross my mind as well.  :-)

> I have a bit of reservation about revert, but I'd imagine we
> could kill it, and also fetch, pull and push, if you are
> shooting for *real* beginners who work alone.  I think the only
> valid justification to drop "revert" from the list is to assume
> that the audience do not interact with the outside world, and
> dropping fetch/pull/push from the list is in line with that.

My mental model for git newbies is that they would probably be pulling
from upstream repositories (so I was tempted to remove git-init from
the common commands list), but they would rarely be cherry-picking or
reverting other people's changes.

They probably would be submitting changes back upstream using e-mail
before they learn how to publish their own repository, so commands I'd
be tempted to add would include git-format-patch, git-send-email, and
git-cherry.  But these commands are pretty complicated for beginners....

	     	       		    	   - Ted
