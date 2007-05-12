From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Merging commits together into a super-commit
Date: Sat, 12 May 2007 19:03:04 +0200
Message-ID: <20070512170304.GC28039@diana.vm.bytemark.co.uk>
References: <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192106.GB4489@pasky.or.cz> <87tzuk31fu.wl%cworth@cworth.org> <20070512113430.GL19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070512140228.GB28039@diana.vm.bytemark.co.uk> <20070512144145.GF16903@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carl Worth <cworth@cworth.org>, Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat May 12 19:04:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmv0u-0000In-D9
	for gcvg-git@gmane.org; Sat, 12 May 2007 19:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612AbXELREG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 12 May 2007 13:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbXELREG
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 13:04:06 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1946 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612AbXELREE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 13:04:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hmuzo-0007tL-00; Sat, 12 May 2007 18:03:04 +0100
Mail-Followup-To: Yann Dirson <ydirson@altern.org>,
	Carl Worth <cworth@cworth.org>, Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070512144145.GF16903@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47064>

On 2007-05-12 16:41:45 +0200, Yann Dirson wrote:

> On Sat, May 12, 2007 at 04:02:28PM +0200, Karl Hasselstr=F6m wrote:
>
> > What we should do is delete all stgit metadata when the last patch
> > goes away.
>
> This supposes there is no valuable branch-level metadata. Currently
> we have the description - something which could arguably be moved to
> the git level as well. Otherwise that sounds reasonable to me.

I left the branch description out of the discussion on purpose, since
it's not that interesting -- if there is a description, we can simply
delete everything except that. And I wholeheartedly agree that the
branch description doesn't belong in stgit; it's orthogonal to the
business of managing a patch stack.

> > And we shouldn't have "stg init", either. Initing should be done
> > automatically when needed.
>
> Good idea as well, that would make stg more accessible to the
> average plain-git user.

Yes, that's my secret evil master plan.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
