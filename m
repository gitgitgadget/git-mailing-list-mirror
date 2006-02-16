From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: fix revision order when XML::Simple is not loaded
Date: Thu, 16 Feb 2006 13:44:02 -0800
Message-ID: <20060216214402.GA19155@hand.yhbt.net>
References: <20060216073826.GA12055@hand.yhbt.net> <43F4A4B1.4010307@blairos.org> <20060216190426.GC12055@hand.yhbt.net> <43F4CF5E.1010700@blairos.org> <20060216194532.GA4446@Muzzle> <20060216194751.GB4446@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Feb 16 22:44:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9qv3-000679-MX
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 22:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWBPVoG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 16:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWBPVoG
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 16:44:06 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60823 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932267AbWBPVoE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 16:44:04 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 11B9A2DC08D; Thu, 16 Feb 2006 13:44:03 -0800 (PST)
To: git list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060216194751.GB4446@Muzzle>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16314>

Just to add, XML::Simple is a recommended dependency.  git-svn will work
fine without it (after this patch) as long as the repository doesn't
have any log messages that regurgitate or otherwise look like svn log
output (most svn repositories are sane in this regard :)

I may add support for the SVN:: perl libraries in the future, but I'll
always git-svn compatible with the command-line svn client and lazy load
any non-standard libraries.

-- 
Eric Wong
