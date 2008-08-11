From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Adjust for the new way of enabling the default
	post-update hook
Date: Tue, 12 Aug 2008 01:05:40 +0200
Message-ID: <20080811230540.GG10151@machine.or.cz>
References: <20080811223446.8342.37008.stgit@localhost> <7vfxpbuplr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 01:06:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSgTO-0004ks-Jv
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 01:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbYHKXFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 19:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752341AbYHKXFo
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 19:05:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60591 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbYHKXFn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 19:05:43 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1D81D393B31D; Tue, 12 Aug 2008 01:05:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vfxpbuplr.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92019>

On Mon, Aug 11, 2008 at 03:57:36PM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > This patch emphasizes this change in the release notes (since
> > I believe this is rather noticeable backwards-incompatible change).
> 
> Anybody who tries to chmod an nonexisting file would notice, so I
> personally think you are making a mountain out of a molehill.
> 
> Nevertheless, mentioning it in the release notes would be a good finishing
> touch.

Well, my only point is that you might want to know that you have to
modify your scripts _before_ they break.

> > +The standard way of making repositories friendly to dumb protocols
> > +(i.e. HTTP) changed: instead of making hooks/post-update executable,
> > +hooks/post-update.sample is to be moved to hooks/post-update.
> 
> I'm actually not very happy with the above wording that makes it sound as
> if any of the samples are part of any "standard way".
> 
> The only standard thing is to make sure update-server-info runs.  You do
> not have to start from the sample hook to do so, even though it may be one
> of the easiest ways.

Then the question is what is "standard" defined as, and why shouldn't
this be the standard way? This is how our user documentation (both the
User Manual and the Git Core Tutorial) teaches the users to do it.

> The rest of the patches look good, but have you actually made sure
> AsciiDoc markups are correct (I am not complaining, just asking, as I
> haven't)?

I haven't - actually, for various technical reasons, I don't even have
AsciiDoc installed on my notebook right now. I plan to get around
to investigate the problem, but didn't yet and I didn't want to hold
this off.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
