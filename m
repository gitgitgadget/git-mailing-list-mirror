From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Canonicalize svn urls to prevent libsvn assertion
Date: Fri, 26 Jun 2009 14:49:57 -0700
Message-ID: <20090626214957.GA12855@dcvr.yhbt.net>
References: <1246027929-2792-1-git-send-email-uli@spamt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ulrich Dangel <uli@spamt.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 23:50:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKJJ5-0007Lg-L4
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 23:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761189AbZFZVt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 17:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760496AbZFZVt5
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 17:49:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40920 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756943AbZFZVt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 17:49:56 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id B980B1F44D;
	Fri, 26 Jun 2009 21:49:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1246027929-2792-1-git-send-email-uli@spamt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122326>

Ulrich Dangel <uli@spamt.net> wrote:
> Cloning/initializing svn repositories with an uncanonicalize url does not
> work as libsvn throws an assertion. This patch canonicalize svn uris for the
> clone and init command from git-svn.
> 
> Signed-off-by: Ulrich Dangel <uli@spamt.net>

Thanks,

I'm not getting any assertions in my version of SVN (1.5.1) but it
actually does cause issues with path stripping when following
repositories.

Acked-by: Eric Wong <normalperson@yhbt.net>
..and pushed out to git://git.bogomips.org/git-svn

There was a minor trailing whitespace issue which I fixed, too

-- 
Eric Wong
