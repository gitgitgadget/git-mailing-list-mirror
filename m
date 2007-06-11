From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn - creating a tag in a cloned SVN repository
Date: Sun, 10 Jun 2007 21:26:37 -0700
Message-ID: <20070611042637.GA17405@muzzle>
References: <466C624F.70303@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Piatyszek <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 06:26:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxbUK-0005Rk-RD
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 06:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750695AbXFKE0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 00:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbXFKE0j
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 00:26:39 -0400
Received: from hand.yhbt.net ([66.150.188.102]:51953 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695AbXFKE0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 00:26:39 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E7C9F7DC09D;
	Sun, 10 Jun 2007 21:26:37 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 10 Jun 2007 21:26:37 -0700
Content-Disposition: inline
In-Reply-To: <466C624F.70303@users.sourceforge.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49815>

Adam Piatyszek <ediap@users.sourceforge.net> wrote:
> Hi!
> 
> I recently switched to git for my projects, even for these which are
> tracked in remote SVN repositories (thanks to git-svn tool).
> However, I did not find anywhere an answer to one question:
> 
> Is it possible to create a subversion-like tag in the remote SVN
> repository using git-svn?
> 
> In more detail: is it possible to emulate the following SVN command:
>   svn copy http://svn.project.server/project/trunk \
>            http://svn.project.server/project/tags/release-1.0
> using git-svn?

No, not at the moment.  Patches welcome :)

-- 
Eric Wong
