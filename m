From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: repo.or.cz wishes?
Date: Wed, 29 Aug 2007 09:32:12 +0200
Message-ID: <20070829073212.GQ1976MdfPADPa@greensroom.kotnet.org>
References: <20070826235944.GM1219@pasky.or.cz>
 <200708272358.43021.jnareb@gmail.com>
 <20070828084939.GF1976MdfPADPa@greensroom.kotnet.org>
 <200708282356.10605.jnareb@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 09:32:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQI2D-0008U0-Tc
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 09:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbXH2HcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 03:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbXH2HcO
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 03:32:14 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:41439 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbXH2HcO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 03:32:14 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JNI0047ZY9OW1@psmtp09.wxs.nl> for git@vger.kernel.org; Wed,
 29 Aug 2007 09:32:12 +0200 (MEST)
Received: (qmail 14281 invoked by uid 500); Wed, 29 Aug 2007 07:32:12 +0000
In-reply-to: <200708282356.10605.jnareb@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56903>

On Tue, Aug 28, 2007 at 11:56:10PM +0200, Jakub Narebski wrote:
> On Tue, 28 August 2007, Sven Verdoolaege wrote:
> > On Mon, Aug 27, 2007 at 11:58:42PM +0200, Jakub Narebski wrote:
> >>
> >> The problem is that repo.or.cz needs support for that in gitweb, while
> >> gitweb in turn needs support for that in git. This needs git consensus
> >> on how to specify object database location (or just gitdir) for
> >> submodules, to have later submodule support in gitweb.
> > 
> > What would be the use of that (outside of gitweb) ?
> 
> For the hypothetical (planned?) future '--recurse-submodules' option
> to git-diff family, git-ls-tree and git-ls-files, git-fetch and git-push
> (but I think not git-pull), perhaps git-log (besides what it supports
> by the way of git-diff-tree), maybe even git-status and git-commit.

Ah... you're talking about bare repositories, right?
For non-bare repos, I'd assume you would only recurse for those
submodules that you have actually checked out in your working tree.

skimo
