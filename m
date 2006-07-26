From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Extend testing git-mv for renaming of subdirectories
Date: Wed, 26 Jul 2006 17:22:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607261721460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607260348130.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <200607261544.08435.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jul 26 17:23:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5lDl-0001EB-Ip
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 17:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWGZPWr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 11:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWGZPWr
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 11:22:47 -0400
Received: from mail.gmx.de ([213.165.64.21]:64179 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750868AbWGZPWq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 11:22:46 -0400
Received: (qmail invoked by alias); 26 Jul 2006 15:22:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 26 Jul 2006 17:22:45 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200607261544.08435.Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24222>

Hi,

On Wed, 26 Jul 2006, Josef Weidendorfer wrote:

> On Wednesday 26 July 2006 03:52, Johannes Schindelin wrote:
> > 	There is no test for it, and I am quite certain the old script
> > 	doesn't do it either: git-mv some_tracked_dir/ there/ will
> > 	not work. t7001-mv passes, though.
> 
> Hmm... Renaming full subtrees worked since the old git-rename days.
> I just checked it, and it works fine.

Thanks.

And thanks again: since there is a test now, I'll have to implement that 
feature, too, I guess ;-)
