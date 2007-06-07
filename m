From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn error msg
Date: Wed, 6 Jun 2007 23:37:23 -0700
Message-ID: <20070607063723.GB2809@muzzle>
References: <008601c7a844$56dc5030$0e67a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Thu Jun 07 08:37:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwBch-0004gG-6V
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 08:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbXFGGh0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 02:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbXFGGh0
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 02:37:26 -0400
Received: from hand.yhbt.net ([66.150.188.102]:57207 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751916AbXFGGhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 02:37:25 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 10EE72DC032;
	Wed,  6 Jun 2007 23:37:24 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 06 Jun 2007 23:37:23 -0700
Content-Disposition: inline
In-Reply-To: <008601c7a844$56dc5030$0e67a8c0@Jocke>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49359>

Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>   git-svn init file:///usr/local/src/tst-git-svn/svn-uboot-repo/
> and then
>   git-svn fetch yields lots of:
> Use of uninitialized value in substitution (s///) at /usr/bin/git-svn line 2144.
> Use of uninitialized value in substitution (s///) at /usr/bin/git-svn line 2144.
> ....
> 
> seems to work though.
> 
> git version - 1.5.1.3

Probably/hopefully harmless.  Although I would like to know what's
causing it, though...  Are git-svn-id: lines generated correctly
in your commit messages?

-- 
Eric Wong
