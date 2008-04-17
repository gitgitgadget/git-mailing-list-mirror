From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/3] git-svn: Add --add-author-from option.
Date: Wed, 16 Apr 2008 21:36:20 -0700
Message-ID: <20080417043620.GA11600@soma>
References: <1208307858-31039-1-git-send-email-apenwarr@gmail.com> <1208307858-31039-2-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@versabanq.com>
To: apenwarr@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 17 06:37:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmLrv-000397-LK
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 06:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbYDQEgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 00:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbYDQEgW
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 00:36:22 -0400
Received: from hand.yhbt.net ([66.150.188.102]:49131 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbYDQEgV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 00:36:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id C51DD7DC0A7;
	Wed, 16 Apr 2008 21:36:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1208307858-31039-2-git-send-email-apenwarr@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79766>

apenwarr@gmail.com wrote:
> From: Avery Pennarun <apenwarr@versabanq.com>
> 
> This adds a From: line (based on the commit's author information) when
> sending to svn.  It doesn't add if a From: or Signed-off-by: header already
> exists for that commit.
> 
> This, combined with --use-log-author, can retain the author field of commits
> through a round trip from git to svn and back.
> Signed-off-by: Avery Pennarun <apenwarr@gmail.com>

This seems like a useful feature for SVN projects and I've sometimes
wanted it myself.  Thanks.

One thing, can you add some tests to ensure this continues working?  I
don't have lots of time to work on git-svn these days and if I do, I
want it to be easy to ensure I'm not breaking things :)

Thanks.

-- 
Eric Wong
