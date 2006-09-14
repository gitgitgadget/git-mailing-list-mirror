From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Historical kernel repository size
Date: Thu, 14 Sep 2006 23:32:18 +0200
Message-ID: <1158269538.5724.237.camel@localhost.localdomain>
References: <20060914142249.GK23891@pasky.or.cz>
	 <Pine.LNX.4.64.0609140824580.4388@g5.osdl.org>
	 <Pine.LNX.4.64.0609141714010.2627@xanadu.home>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 14 23:31:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNyoL-0006YL-4S
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 23:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWINVbg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 17:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWINVbg
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 17:31:36 -0400
Received: from www.osadl.org ([213.239.205.134]:36564 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751222AbWINVbe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 17:31:34 -0400
Received: from hermes.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id B9A1D65C003;
	Thu, 14 Sep 2006 23:31:33 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by hermes.tec.linutronix.de (Postfix) with ESMTP id 4E43067FA0;
	Thu, 14 Sep 2006 23:31:32 +0200 (CEST)
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0609141714010.2627@xanadu.home>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27043>

On Thu, 2006-09-14 at 17:23 -0400, Nicolas Pitre wrote:
> On Thu, 14 Sep 2006, Linus Torvalds wrote:
> 
> > For better packing, I think I used a larger depth, ie try something like
> > 
> > 	git repack -a -f --depth=50
> > 
> > to get more improvement. For a historical archive that you don't much use, 
> > doign the deeper depth is definitely worth it.
> 
> Using a larger window helps too.  It of course has a direct impact on 
> the processing to perform a full repack, but it has no runtime costs 
> when the pack is used.  So I'd suggest adding --window=50 to the above.
> 
> [ I made those suggestions in person to Thomas at OLS to which 
>   he replied he'd do it when he'd get back home.   ;-) ]

Thanks for the reminder. I actually logged into kernel.org already :)

	tglx
