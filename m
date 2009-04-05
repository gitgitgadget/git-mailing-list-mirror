From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 5/5] Cache resolved ids in quickdiff document for
	faster update
Date: Sun, 5 Apr 2009 14:43:32 -0700
Message-ID: <20090405214332.GC23604@spearce.org>
References: <1238697991-12990-1-git-send-email-robin.rosenberg@dewire.com> <1238697991-12990-6-git-send-email-robin.rosenberg@dewire.com> <20090405203604.GP23521@spearce.org> <200904052340.01864.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 23:45:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqa9K-0007Hb-OP
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 23:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553AbZDEVnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 17:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754774AbZDEVne
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 17:43:34 -0400
Received: from george.spearce.org ([209.20.77.23]:46243 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717AbZDEVne (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 17:43:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 633B038211; Sun,  5 Apr 2009 21:43:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200904052340.01864.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115722>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> s?ndag 05 april 2009 22:36:04 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > Arrrgh.  We're still using Commit/Tree/TreeEntry to read file paths?
> >
> > I'm applying this as-is, but we really need to start to transition
> > away from them.  I wanted to start deleting the mapCommit and its
> > friends from the Repository class.
> 
> Yeah, but the new API is more awkward and error-prone to use. The old
> API is quite straightforward.

I see.  Then I failed.

What can we do to reduce that?

> I will try harder next time.

Shouldn't be necessary.  :-)

-- 
Shawn.
