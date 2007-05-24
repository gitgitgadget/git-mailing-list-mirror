From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 09/15] entry.c: optionally checkout submodules
Date: Thu, 24 May 2007 15:29:09 +0200
Message-ID: <20070524132909.GR942MdfPADPa@greensroom.kotnet.org>
References: <11796842882917-git-send-email-skimo@liacs.nl>
 <11796842892490-git-send-email-skimo@liacs.nl>
 <20070520211850.GJ5412@admingilde.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu May 24 15:29:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrDNk-0007Od-FQ
	for gcvg-git@gmane.org; Thu, 24 May 2007 15:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757012AbXEXN3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 09:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757765AbXEXN3M
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 09:29:12 -0400
Received: from psmtp03.wxs.nl ([195.121.247.12]:65233 "EHLO psmtp03.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757047AbXEXN3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 09:29:10 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp03.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIJ00BPSS4LCU@psmtp03.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 15:29:10 +0200 (MEST)
Received: (qmail 3842 invoked by uid 500); Thu, 24 May 2007 13:29:09 +0000
In-reply-to: <20070520211850.GJ5412@admingilde.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48261>

On Sun, May 20, 2007 at 11:18:50PM +0200, Martin Waitz wrote:
> hoi :)
> 
> have you seen my patch to checkout submodules?
> 
> The submodule checkout should really check that the requested commit
> is really available and have some other path for creating submodules
> which are not currently checked out / able to be checked out.

If you are talking about your May 5th patch, then you weren't doing
that either.  You just checked if it _looked_ like a SHA1.

I check for the presence of the commit by calling git-cat-file.
Of course, this doesn't guarantee that the whole tree is available.

skimo
