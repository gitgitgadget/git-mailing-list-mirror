From: Greg KH <greg@kroah.com>
Subject: Re: [script] ge: export commits as patches
Date: Tue, 19 Apr 2005 12:11:29 -0700
Message-ID: <20050419191128.GA4871@kroah.com>
References: <20050419134843.GA19146@elte.hu> <20050419170320.GG12757@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 21:09:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNy4q-0003AO-OJ
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 21:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVDSTMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 15:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVDSTMI
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 15:12:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:61419 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261571AbVDSTL4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 15:11:56 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3JJBoi07755;
	Tue, 19 Apr 2005 12:11:50 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DNy89-1TU-00; Tue, 19 Apr 2005 12:11:29 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050419170320.GG12757@pasky.ji.cz>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 07:03:20PM +0200, Petr Baudis wrote:
> Dear diary, on Tue, Apr 19, 2005 at 03:48:43PM CEST, I got a letter
> where Ingo Molnar <mingo@elte.hu> told me that...
> > is there any 'export commit as patch' support in git-pasky? I didnt find 
> > any such command (maybe it got added meanwhile), so i'm using the 'ge' 
> > hack below.
> > 
> > e.g. i typically look at commits via 'git log', and then when i see 
> > something interesting, i look at the commit via the 'ge' script. E.g.  
> > "ge 834f6209b22af2941a8640f1e32b0f123c833061" done in the kernel tree 
> > will output a particular commit's header and the patch.
> 
> Nice idea. I will add it, probably as 'git patch'.

Ah, thanks for doing this.  'git patch' works great (but you might want
to mention in the 'help' that you can give the commit id for the patch,
if you don't want to see the HEAD patch.)

thanks,

greg k-h
