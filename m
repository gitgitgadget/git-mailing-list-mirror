From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: removing content from git history
Date: Tue, 9 Oct 2007 17:02:35 -0400
Message-ID: <20071009210235.GB9633@fieldses.org>
References: <20070221164527.GA8513@ginosko.local> <20070221165636.GH25559@spearce.org> <20070221171738.GA9112@fieldses.org> <Pine.LNX.4.64.0702210934470.4043@woody.linux-foundation.org> <20070221210045.GB26525@spearce.org> <Pine.LNX.4.64.0702211306520.4043@woody.linux-foundation.org> <20070221212129.GD26525@spearce.org> <18187.60305.613904.547916@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 23:02:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfME6-0002zV-CO
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 23:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbXJIVCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 17:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754089AbXJIVCl
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 17:02:41 -0400
Received: from mail.fieldses.org ([66.93.2.214]:52007 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753808AbXJIVCk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 17:02:40 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IfMDr-00030z-9P; Tue, 09 Oct 2007 17:02:35 -0400
Content-Disposition: inline
In-Reply-To: <18187.60305.613904.547916@lisa.zopyra.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60438>

On Tue, Oct 09, 2007 at 03:58:57PM -0500, Bill Lear wrote:
> As I understand this thread, it does not appear that a resolution
> was reached.  Our company has content in our central git repository
> that we need to remove per a contractual obligation.  I believe the
> content in question is limited to one sub-directory, that has existed
> since (or near to) the beginning of the repo, if that matters.  We
> obviously would just like to issue a "git nuke" operation and be done
> with it, if that is available.  Barring that, we could probably follow
> reasonably simple steps to purge the content and rebuild the repo.
> 
> So, what options do we have at present?

Have you looked at git-filter-branch in a recent version of git?  The
man page has some good examples.

--b.
