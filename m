From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Gitweb and submodules
Date: Fri, 27 Jul 2007 14:32:29 +0200
Message-ID: <20070727123229.GB31114MdfPADPa@greensroom.kotnet.org>
References: <200707271322.50114.jnareb@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 14:32:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEOzp-0000UC-RH
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 14:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932930AbXG0Mce (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 08:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934203AbXG0Mce
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 08:32:34 -0400
Received: from psmtp12.wxs.nl ([195.121.247.24]:40100 "EHLO psmtp12.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764766AbXG0Mcd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 08:32:33 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp12.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JLU00M77867SI@psmtp12.wxs.nl> for git@vger.kernel.org; Fri,
 27 Jul 2007 14:32:32 +0200 (MEST)
Received: (qmail 30775 invoked by uid 500); Fri, 27 Jul 2007 12:32:29 +0000
In-reply-to: <200707271322.50114.jnareb@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53923>

On Fri, Jul 27, 2007 at 01:22:49PM +0200, Jakub Narebski wrote:
> But for that I need a question answered: how to find GIT_DIR of 
> repository which contains submodule objects? We have to assume in 
> gitweb that repositories are bare...

You'll have to add a configuration variable for that.
The submodule may not even be on the same server.

skimo
