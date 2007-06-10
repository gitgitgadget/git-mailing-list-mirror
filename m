From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn set-tree bug
Date: Sat, 9 Jun 2007 18:47:34 -0700
Message-ID: <20070610014734.GA542@muzzle>
References: <1181323515.30670.110.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Sun Jun 10 03:47:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxCWq-0005Pv-Or
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 03:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbXFJBrg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 21:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753340AbXFJBrg
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 21:47:36 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42922 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099AbXFJBrf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 21:47:35 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 62D867DC09D;
	Sat,  9 Jun 2007 18:47:34 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 09 Jun 2007 18:47:34 -0700
Content-Disposition: inline
In-Reply-To: <1181323515.30670.110.camel@gentoo-jocke.transmode.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49651>

Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> trying to do git-svn set-tree remotes/trunk..svn
> in my new git-svn repo I get:
> config --get svn-remote.svn.fetch :refs/remotes/git-svn$: command returned error: 1

You need to specify "-i trunk" in the command-line

git-svn set-tree -i trunk remotes/trunk..svn

-- 
Eric Wong
