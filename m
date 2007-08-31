From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Git.pm: Add remote_refs() git-ls-remote frontend
Date: Fri, 31 Aug 2007 03:37:00 +0200
Message-ID: <20070831013700.GL1219@pasky.or.cz>
References: <20070825221143.6514.22516.stgit@rover> <20070830233749.4480.72281.stgit@rover> <7vr6lk5z2p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 03:37:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQvRc-0003WR-Dy
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 03:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757422AbXHaBhF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 21:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756445AbXHaBhE
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 21:37:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40645 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756226AbXHaBhB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 21:37:01 -0400
Received: (qmail 1929 invoked by uid 2001); 31 Aug 2007 03:37:00 +0200
Content-Disposition: inline
In-Reply-To: <7vr6lk5z2p.fsf@gitster.siamese.dyndns.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57101>

On Fri, Aug 31, 2007 at 02:26:22AM CEST, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Should support all the important features, I guess. Too bad that
> >
> > 	git-ls-remote --heads .
> > 	
> > is subtly different from
> >
> > 	git-ls-remote . refs/heads/
> >
> > so we have to provide the interface for specifying both.
> 
> Are they subtly different?  To me they look like asking for
> completely different things.  IIRC, the patterns are ref globs,
> so
> 
> 	git ls-remote $URL 'refs/heads/*'
> 
> would be the same as the former one.

Yes, though subtly different, as I've already explained before - for the
case of say

	refs/remotes/evil/refs/heads

> Ah, that was the bug you were talking about on #git channel, I
> guess...

*nod*

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
