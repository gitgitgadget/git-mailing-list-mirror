From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's in git.git (Oct 2008, #03; Tue, 14)
Date: Wed, 15 Oct 2008 13:36:01 -0700
Message-ID: <20081015203601.GE28802@spearce.org>
References: <7vej2i7rt9.fsf@gitster.siamese.dyndns.org> <bsftmRx17krWBpVlulipoJEO1fWsD0hZfF3HOZcajX6GV66RKW8W6A@cipher.nrlssc.navy.mil> <7vljwpr6lr.fsf@gitster.siamese.dyndns.org> <20081015202032.GD28802@spearce.org> <7vhc7dr4f8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	Arjen Laarhoven <arjen@yaph.org>, Jeff King <peff@peff.net>,
	Mike Ralphson <mike@abacus.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:37:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqD7N-0002Fg-3d
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 22:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbYJOUgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 16:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbYJOUgD
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 16:36:03 -0400
Received: from george.spearce.org ([209.20.77.23]:35930 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbYJOUgD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 16:36:03 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2D1703835F; Wed, 15 Oct 2008 20:36:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vhc7dr4f8.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98324>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> >> If we can add a test case to demonstrate the existing breakage, I think we
> >> can (and should) cherry-pick it to 'maint'.
> >
> > Yes, it probably should have gone to maint.  No, it didn't go there.
> > Temporary lapse in maintainer judgement.
> 
> That is Ok.  I do the same all the time (and I try to rewind and rebuild
> when I spot it before pushing the results out, but I am not always
> successful).

Oh, trust me, I had many times where I had to rebuild everything
for that day's push because I forgot about a patch that should
be in maint.  At least your Meta/RB and Meta/PU scripts make it
somewhat painless, that and Git's ability to just hard reset a
branch back to what I last published.  ;-)

I just utterly failed to do it that morning.  Or at least failed
to do it for this change.
 
> I just wanted to see if there was any particular reason not to have this
> on 'maint'.

Nope.

-- 
Shawn.
