From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 3/3] Use a common skipObject method to avoid
	UNINTERESTING items
Date: Mon, 16 Mar 2009 07:13:29 -0700
Message-ID: <20090316141329.GL22920@spearce.org>
References: <1236967912-15088-1-git-send-email-spearce@spearce.org> <1236967912-15088-2-git-send-email-spearce@spearce.org> <1236967912-15088-3-git-send-email-spearce@spearce.org> <200903150125.56987.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 15:16:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjDby-0000EN-4C
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 15:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757962AbZCPONc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 10:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757985AbZCPONc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 10:13:32 -0400
Received: from george.spearce.org ([209.20.77.23]:37298 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531AbZCPONb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 10:13:31 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CBE9538211; Mon, 16 Mar 2009 14:13:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200903150125.56987.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113327>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> fredag 13 mars 2009 19:11:52 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > All cases are using the same logic to decide that we should skip
> > this current object and not return it to the caller.  A common
> > implementation makes the code easier to follow, especially as it
> > reduces the ugly line wrap involved in the loop body.
> 
> Java conventions dictate that this method should be called shouldSkipObject. It
> is a boolean method that actually does not itself skip any objects.
> 
> I can amend that for you.

Yup, amend away.  shouldSkipObject is a much better name.  Thanks.

-- 
Shawn.
