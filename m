From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: Fix for svn paths removed >
	log-window-size revisions ago
Date: Sat, 9 May 2009 18:32:11 -0700
Message-ID: <20090510013211.GB2000@dcvr.yhbt.net>
References: <1241641133-6974-1-git-send-email-alexmv@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Vandiver <alexmv@MIT.EDU>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 03:32:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2xtr-0000VT-Tv
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 03:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520AbZEJBcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 21:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754555AbZEJBcM
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 21:32:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39991 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754002AbZEJBcL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 21:32:11 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1AB41F791;
	Sun, 10 May 2009 01:32:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1241641133-6974-1-git-send-email-alexmv@mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118697>

Alex Vandiver <alexmv@MIT.EDU> wrote:
> Instead of trying to find the end of the commit history only in the
> last window, track if we have seen commits yet, and use that to judge
> if we need to backtrack and look for a tail.  Otherwise, conversion
> can silently lose up to 100 revisions of a branch if it was deleted
> >100 revisions ago.
> 
> Signed-off-by: Alex Vandiver <alexmv@mit.edu>

Thanks Alex,

This series (and your svn.authorsfile patch)
Acked-by: Eric Wong <normalperson@yhbt.net>

..and pushed out to git://git.bogomips.org/git-svn
-- 
Eric Wong
