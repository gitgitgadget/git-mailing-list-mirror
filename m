From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Fix data corruption in DirCacheIterator when
	EmptyTreeIterator is used
Date: Mon, 11 May 2009 12:44:29 -0700
Message-ID: <20090511194429.GM30527@spearce.org>
References: <1242064348-13197-1-git-send-email-spearce@spearce.org> <200905112059.58212.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Struberg <struberg@yahoo.de>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon May 11 21:44:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3bQW-0006Vr-FU
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 21:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758553AbZEKTo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 15:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758133AbZEKTo3
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 15:44:29 -0400
Received: from george.spearce.org ([209.20.77.23]:35361 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732AbZEKTo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 15:44:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4C455381D5; Mon, 11 May 2009 19:44:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200905112059.58212.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118836>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> 
> Shouldn't we update some unit tests too? The dircache must be reliable.

I see you ignored the remark I put in the cover letter below the ---.

I think we should have unit tests too.  I just can't come up with
a way test the fix to prevent regression.  And I don't have any
more time for it probably the rest of this week.  I'd rather have
the corruption fix in the tree with no test than continue to have
surprising corruption under certain cases.  But if you or Mark can
offer a test, I'd love to have it.

-- 
Shawn.
