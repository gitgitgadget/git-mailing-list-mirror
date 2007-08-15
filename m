From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: git submodule init and redundant data in .gitmodules/.git/config
Date: Wed, 15 Aug 2007 18:38:22 +0200
Message-ID: <20070815163822.GC1070MdfPADPa@greensroom.kotnet.org>
References: <20070815162005.GA18463@piper.oerlikon.madduck.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 15 18:38:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILLt8-0006Tm-1M
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 18:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932959AbXHOQi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 12:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932807AbXHOQiZ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 12:38:25 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:35379 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932539AbXHOQiY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 12:38:24 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMT002OMQ7Z2L@psmtp08.wxs.nl> for git@vger.kernel.org; Wed,
 15 Aug 2007 18:38:23 +0200 (MEST)
Received: (qmail 5351 invoked by uid 500); Wed, 15 Aug 2007 16:38:22 +0000
In-reply-to: <20070815162005.GA18463@piper.oerlikon.madduck.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55922>

On Wed, Aug 15, 2007 at 06:20:05PM +0200, martin f krafft wrote:
> But looking at the two stanzas, it strikes me that the remote url of
> the submodule is duplicated and detached, creating redundant data
> which may become desynchronised.
> 
> Why is this?
> 
> What is the reason for git-submodule init and moving the data to
> .git/config?

The (most appropriate) URL from which to get updates of a submodule
may be different for different people and therefore has to be stored
in .git/config.  It was then decided that the default value
for this URL should be stored in .gitmodules.  git submodule init
simply initializes the URL using this default value.  You are free
to not call git submodule init and set a (more) appropriate URL manually.

skimo
