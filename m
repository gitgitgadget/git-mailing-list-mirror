From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/6] Add set to IntList
Date: Mon, 4 May 2009 07:22:31 -0700
Message-ID: <20090504142231.GS23604@spearce.org>
References: <1241230127-28279-1-git-send-email-spearce@spearce.org> <1241230127-28279-2-git-send-email-spearce@spearce.org> <200905030907.02287.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon May 04 16:22:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0z43-0007B3-JG
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 16:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbZEDOWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 10:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbZEDOWb
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 10:22:31 -0400
Received: from george.spearce.org ([209.20.77.23]:46987 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbZEDOWa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 10:22:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 287A138195; Mon,  4 May 2009 14:22:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200905030907.02287.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118240>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> l?rdag 02 maj 2009 04:08:42 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > Some applications may wish to modify an int list.

OK, as it turns out, this is used by code which Dscho wrote but I
haven't packaged up as patches yet.  And I don't think that even uses
the weird set(size(), ...) expands the list rules I implemented.
So drop this patch for now from the series and I'll respin it at
a later date.

> >  .../tst/org/spearce/jgit/util/IntListTest.java     |   21 ++++++++++++++++++++
> >  .../src/org/spearce/jgit/util/IntList.java         |   17 ++++++++++++++++
> >  2 files changed, 38 insertions(+), 0 deletions(-)

-- 
Shawn.
