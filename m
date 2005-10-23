From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: git and gitweb inconsistencies
Date: Sun, 23 Oct 2005 13:59:39 +0200
Message-ID: <20051023115939.GG8383MdfPADPa@greensroom.kotnet.org>
References: <20051023001412.GA22679@pe.Belkin>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 23 14:00:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETeW9-0004bY-8L
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 14:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVJWL7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 07:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVJWL7n
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 07:59:43 -0400
Received: from smtp18.wxs.nl ([195.121.6.14]:46722 "EHLO smtp18.wxs.nl")
	by vger.kernel.org with ESMTP id S1750700AbVJWL7m (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 07:59:42 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp18.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IOT002JYANFEQ@smtp18.wxs.nl> for git@vger.kernel.org; Sun,
 23 Oct 2005 13:59:39 +0200 (CEST)
Received: (qmail 17468 invoked by uid 500); Sun, 23 Oct 2005 11:59:39 +0000
In-reply-to: <20051023001412.GA22679@pe.Belkin>
To: Chris Shoemaker <c.shoemaker@cox.net>
Mail-followup-to: Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10490>

On Sat, Oct 22, 2005 at 08:14:12PM -0400, Chris Shoemaker wrote:
> A few days later, I ran git-cvsimport again, with -i.  This imported
> just the recent changes, but the view from gitweb didn't change.  :(

Are you sure you didn't just create a new import *inside* the old import ?
Do you have, say, both an 'objects' and a '.git/objects' directory ?

> $ echo `git-rev-list tip --max-count=1` > refs/heads/mytest
> $ git-cat-file -t `cat refs/heads/mytest`

That should be

git-update-ref refs/heads/mytest tip
(the new head will appear in .git/refs/heads/mytest, 
unless you've set GIT_DIR)
git-cat-file -t mytest


skimo
