From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: clarify documentation of dcommit sub-command
Date: Thu, 10 May 2012 19:13:41 +0000
Message-ID: <20120510191341.GB1715@dcvr.yhbt.net>
References: <1336398527-4363-1-git-send-email-jon.seymour@gmail.com>
 <7vpqadtgpj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 21:13:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSYo7-00064T-6X
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 21:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761506Ab2EJTNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 15:13:43 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37445 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756480Ab2EJTNm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 15:13:42 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B1541F42C;
	Thu, 10 May 2012 19:13:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vpqadtgpj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197618>

Junio C Hamano <gitster@pobox.com> wrote:
> Perhaps something like this?
> 
> 'dcommit'::
> 	Commit each diff from the current branch directly to the SVN
> 	repository, and then rebase or reset (depending on ...
> 	...
> 	When an optional git branch name (or a git commit object name)
> 	is given, the subcommand works on the specified branch, not on
>         the current branch.

I think that looks good.  Using "revision" to mean "git commit object"
was a confusing mistake in the first place.
