From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Wed, 31 Oct 2007 17:29:23 -0400
Message-ID: <20071031212923.GL4569@fieldses.org>
References: <87d4uv3wh1.fsf@osv.gnss.ru> <20071031195702.GB24332@atjola.homenet> <874pg73u6h.fsf@osv.gnss.ru> <Pine.LNX.4.64.0710312111170.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:31:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InL8L-0006Km-0H
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100AbXJaV3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbXJaV3i
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:29:38 -0400
Received: from mail.fieldses.org ([66.93.2.214]:36511 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323AbXJaV3h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 17:29:37 -0400
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1InL7w-0007OK-RZ; Wed, 31 Oct 2007 17:29:28 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710312111170.4362@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62879>

On Wed, Oct 31, 2007 at 09:12:06PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 31 Oct 2007, Sergei Organov wrote:
> 
> > Yes, and that's the problem. Why 'git --continue' didn't just skip this 
> > patch that *already became no-op* after conflict resolution and forced 
> > me to explicitly use 'git --skip' instead?
> 
> Isn't that obvious?  To prevent you from accidentally losing a commit.

That would make sense to me if this was a mistake that could easily
happen.

I'd assumed that in the case of a conflict that stopped the rebase
process, the index and working tree are always left dirty, so that if
they both agree with the HEAD at the time of commit, then it's because
the user explicitly made them that way.

I ran into the same confusion as the original poster when starting to
use rebase, so I suspect it's common.

--b.
