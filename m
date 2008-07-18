From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Documentation/git-merge.txt: Expand the How Merge
	Works   section
Date: Fri, 18 Jul 2008 15:18:00 +0200
Message-ID: <20080718131800.GP10151@machine.or.cz>
References: <20080717162922.12081.96582.stgit@localhost> <7v3am8gytp.fsf@gitster.siamese.dyndns.org> <20080717185451.GJ10151@machine.or.cz> <7vd4lcfgoo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 15:19:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJprW-00008n-PL
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 15:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054AbYGRNSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 09:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755033AbYGRNSG
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 09:18:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38716 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754829AbYGRNSE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 09:18:04 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 29051244C01A; Fri, 18 Jul 2008 15:18:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4lcfgoo.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89037>

  Hi,

On Thu, Jul 17, 2008 at 12:34:31PM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> >   I'm not sure if I should resend the updated patch, or if you already
> > included your comments yourself.
> 
> When I send my review comments out, I generally expect an updated version,
> unless I explicitly say "will apply with tweaks, no need to resend".

  ok, that is pretty much what I expected, I just wanted to avoid doing
duplicate work. :-)

..snip..
> yes, I am strongly hinting to drop that description; it
> is not even remotely interesting

  I have tried to salvage the now-subsection for a while yet, but
ultimately, I now feel as well that it is not worth it; the meat of it
can be summed up in a single sentence that I have re-added to the main
section.

> However, I think we may want to talk about "How to tell if your merge did
> not even touch your index nor working tree" somewhere in the manual.
> "When there are conflicts, these things happen" part talks about how to
> resolve conflicts, but when merge refuses to avoid losing local changes,
> the instruction in that part does not apply.

  I'm not sure if this is worth pondering about? The action would feel
rather obvious to me - get rid of the local changes somehow, either
committing them or stashing them or wiping them out. Is that worth
elaborating, or is there more to it?

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
