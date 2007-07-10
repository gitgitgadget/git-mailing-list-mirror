From: Eric Wong <normalperson@yhbt.net>
Subject: Re: "svn switch" equivalent when using git-svn -- git-filter-branch?
Date: Mon, 9 Jul 2007 22:40:38 -0700
Message-ID: <20070710054038.GA17675@muzzle>
References: <86sl7x7nzq.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 07:40:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I88Sy-000467-E9
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 07:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbXGJFkk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 01:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbXGJFkj
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 01:40:39 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37740 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbXGJFkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 01:40:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 742152DC032;
	Mon,  9 Jul 2007 22:40:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <86sl7x7nzq.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52045>

David Kastrup <dak@gnu.org> wrote:
> Hi,
> 
> an upstream svn repository that I access with git-svn has moved.  I
> seem to be too stupid to use git-filter-branch and/or .git/config
> and/or git-reset to make my git mirror follow the switch.

Just changing the url key in the [svn-remote] section of the .git/config
file should be enough.

You'll probably need to fetch at least one revision from the new URL
before being able to dcommit, though.

I've never looked at git-filter-branch, either.

-- 
Eric Wong
