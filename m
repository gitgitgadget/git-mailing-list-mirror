From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's in git.git (Oct 2008, #03; Tue, 14)
Date: Wed, 15 Oct 2008 13:20:32 -0700
Message-ID: <20081015202032.GD28802@spearce.org>
References: <7vej2i7rt9.fsf@gitster.siamese.dyndns.org> <bsftmRx17krWBpVlulipoJEO1fWsD0hZfF3HOZcajX6GV66RKW8W6A@cipher.nrlssc.navy.mil> <7vljwpr6lr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	Arjen Laarhoven <arjen@yaph.org>, Jeff King <peff@peff.net>,
	Mike Ralphson <mike@abacus.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:21:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqCsU-0004lk-D0
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 22:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592AbYJOUUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 16:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbYJOUUe
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 16:20:34 -0400
Received: from george.spearce.org ([209.20.77.23]:42073 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549AbYJOUUd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 16:20:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 76B673835F; Wed, 15 Oct 2008 20:20:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vljwpr6lr.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98317>

Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
> > Two questions:
> >
> >   1) Should a5a5a048 be in maint?
> >      "xdiff-interface.c: strip newline (and cr) from line before pattern matching"
> 
> I would have forked a maint-fix topic to prepare a merge of this fix to
> both 'maint' and 'master' but apparently this was applied directly on
> 'master'.  I may be missing a valid reason why Shawn did it this way.

My fault.  I didn't have a reason for putting it on master.
My reason really boiled down to "I can't decide where this goes,
oops, got distracted by something, git checkout master, git am,
move on...".

Yes, it probably should have gone to maint.  No, it didn't go there.
Temporary lapse in maintainer judgement.
 
> If we can add a test case to demonstrate the existing breakage, I think we
> can (and should) cherry-pick it to 'maint'.

Probably.  Sorry for the cherry-pick being required here.

-- 
Shawn.
