From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: forward -q to git-rebase
Date: Tue, 12 Jun 2012 21:38:05 +0000
Message-ID: <20120612213805.GA29840@dcvr.yhbt.net>
References: <1339515815-10752-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 23:38:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeYmy-0000Qz-Je
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 23:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab2FLViI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 17:38:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38894 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153Ab2FLViH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 17:38:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC6B1F4E9;
	Tue, 12 Jun 2012 21:38:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1339515815-10752-1-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199865>

Erik Faye-Lund <kusmabite@gmail.com> wrote:
> When calling "git svn rebase -q", we still get the message
> "Current branch BRANCHNAME is up to date." from git-rebase, which
> isn't quite as quiet as we could be.
> 
> Fix this by forwarding the -q flag to git-rebase.
> 
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---

Looks good to me.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

Also pushed to "master" of git://bogomips.org/git-svn
