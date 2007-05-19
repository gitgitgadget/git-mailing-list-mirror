From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 12/16] builtin-fetch--tool: extend "native-store" for use
 in cloning
Date: Sat, 19 May 2007 14:17:57 +0200
Message-ID: <20070519121757.GP942MdfPADPa@greensroom.kotnet.org>
References: <11795163053812-git-send-email-skimo@liacs.nl>
 <11795163072266-git-send-email-skimo@liacs.nl>
 <20070518225234.GI10475@steel.home>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 14:18:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpNtD-000093-8u
	for gcvg-git@gmane.org; Sat, 19 May 2007 14:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758012AbXESMSB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 08:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758775AbXESMSB
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 08:18:01 -0400
Received: from psmtp04.wxs.nl ([195.121.247.13]:39322 "EHLO psmtp04.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758334AbXESMR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 08:17:59 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp04.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIA001FSFHYTV@psmtp04.wxs.nl> for git@vger.kernel.org; Sat,
 19 May 2007 14:17:58 +0200 (MEST)
Received: (qmail 7445 invoked by uid 500); Sat, 19 May 2007 12:17:58 +0000
In-reply-to: <20070518225234.GI10475@steel.home>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47745>

On Sat, May 19, 2007 at 12:52:34AM +0200, Alex Riesen wrote:
> This code produces warning about possible uninitialized used of
> single_force and not_for_merge. I used the patch below, but didn't
> look into what the "all" does.

Sorry for being sloppy.  It is assumed that "all" is only used
for cloning and then the other two flags don't really matter,
but I should've set some defaults.
Yours look fine, thanks.

A fixed-up version is available in the "submodules" branch
of http://www.liacs.nl/~sverdool/git.git or
www.liacs.nl/~sverdool/gitweb.cgi?p=git.git;a=shortlog;h=submodules

skimo
