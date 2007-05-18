From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Sat, 19 May 2007 00:08:26 +0200
Message-ID: <20070518220826.GM942MdfPADPa@greensroom.kotnet.org>
References: <11795163053812-git-send-email-skimo@liacs.nl>
 <11795163061588-git-send-email-skimo@liacs.nl>
 <20070518215312.GB10475@steel.home>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 00:08:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpAco-0000qs-Fs
	for gcvg-git@gmane.org; Sat, 19 May 2007 00:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbXERWIb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 18:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754953AbXERWIb
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 18:08:31 -0400
Received: from psmtp12.wxs.nl ([195.121.247.24]:57549 "EHLO psmtp12.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754761AbXERWIb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 18:08:31 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp12.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JI9000LDC63RE@psmtp12.wxs.nl> for git@vger.kernel.org; Sat,
 19 May 2007 00:08:29 +0200 (MEST)
Received: (qmail 11636 invoked by uid 500); Fri, 18 May 2007 22:08:26 +0000
In-reply-to: <20070518215312.GB10475@steel.home>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47665>

I noticed there's a whole thread about subprojects that I haven't read yet,
so this may have been addressed already ....

On Fri, May 18, 2007 at 11:53:12PM +0200, Alex Riesen wrote:
> Can we have this option (and corresponding support in the following
> patches, of course) first?

That's why the clone thing comes last.

> It is enough to have subprojects working
> locally, and people can start using them immediately: anyone can clone
> the subprojects manually if he wishes so.

Anyone can run git-write-tree and git-commit-tree is she wishes so...

> Cloning of subprojects is still unclear, and frankly I'm not sure it
> should be done at all. Not even with an option which is off by
> default.

Then don't use it.

The reason for not putting this in shouldn't be that someone doesn't
think it is useful; the reason should be that my code is crap.

skimo
