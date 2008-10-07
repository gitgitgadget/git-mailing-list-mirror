From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git/spearce.git (Oct 2008, #01; Mon, 06)
Date: Tue, 7 Oct 2008 07:50:04 -0700
Message-ID: <20081007145004.GA4674@spearce.org>
References: <20081006165943.GG8203@spearce.org> <20081006210303.GA30812@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 16:53:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnDuB-0006ia-Ng
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 16:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbYJGOuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 10:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbYJGOuG
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 10:50:06 -0400
Received: from george.spearce.org ([209.20.77.23]:55923 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbYJGOuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 10:50:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 73D6338360; Tue,  7 Oct 2008 14:50:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081006210303.GA30812@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97714>

Jeff King <peff@peff.net> wrote:
> On Mon, Oct 06, 2008 at 09:59:43AM -0700, Shawn O. Pearce wrote:
> 
> > * jk/diff-convfilter (Sun Oct 5 17:43:45 2008 -0400) 4 commits
> >  - diff: add filter for converting binary to text
> >  - diff: introduce diff.<driver>.binary
> >  - diff: unify external diff and funcname parsing code
> >  - t4012: use test_cmp instead of cmp
> > 
> > A general cleanup on how diff drivers are implemented.  Its still
> > missing documentation updates and tests but doesn't break anything
> > current as far as I can tell.  It needs more review before it can
> > be slated for 'next'.
> 
> I should note, too, that this is in direct competition with Matthieu
> Moy's "Implementation of a textconv filter for easy custom diff" posted
> about a week ago. So if you are reviewing this series, please review
> both and decide which you think is more sensible.

To be clear, Jeff's series is in pu because it seems reasonable on
the surface and applied cleanly to my master branch.  Matthieu's
branch didn't apply cleanly, and I didn't really have the time to
figure out why and hand fix it.

So my carrying of Jeff's series and not Matthieu's is not an
endorsement one way or the other.  It was simply a matter of trying
to help the topic get exposure with the least amount of effort on
my part.

-- 
Shawn.
