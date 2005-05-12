From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 11:07:30 +0100
Message-ID: <1115892451.16187.561.camel@hades.cambridge.redhat.com>
References: <1115847510.22180.108.camel@tglx>
	 <2780.10.10.10.24.1115848852.squirrel@linux1>
	 <1115849141.22180.123.camel@tglx>
	 <2807.10.10.10.24.1115850254.squirrel@linux1>
	 <1115850619.22180.133.camel@tglx>
	 <2853.10.10.10.24.1115850996.squirrel@linux1>
	 <1115851718.22180.153.camel@tglx>
	 <2883.10.10.10.24.1115852463.squirrel@linux1>
	 <1115854419.22180.196.camel@tglx>
	 <2997.10.10.10.24.1115855049.squirrel@linux1>
	 <1115857838.22180.250.camel@tglx>
	 <3185.10.10.10.24.1115858739.squirrel@linux1>
	 <1115859372.22180.266.camel@tglx>
	 <3259.10.10.10.24.1115859535.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 12:01:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWAUG-0007uF-T0
	for gcvg-git@gmane.org; Thu, 12 May 2005 12:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVELKHr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 06:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVELKHr
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 06:07:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25541 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261386AbVELKHk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 06:07:40 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DWAbL-0003ng-T2; Thu, 12 May 2005 11:07:32 +0100
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <3259.10.10.10.24.1115859535.squirrel@linux1>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 20:58 -0400, Sean wrote:
> > Try to find out the history of kernel.org/.../dwmw2/audit-2.6 in 
> > correct order, using the available tools.
> >
> > Come back to me when you are done.
> 
> Ask me any question that matters and i'll answer it with available
> tools.

The above question matters, so please answer it if you can. I'll make it
clearer for you though...

By 'correct order' Thomas means the order in which my old BK-export
script used to generate the "changesets since last release" web page;
the order in which the changes actually got merged into Linus'
repository.

If I looked at the page yesterday, and then I look at it again today, I
want all the commits I hadn't seen already to be at the _top_.
Regardless of the date on which they were _originally_ committed to some
private tree elsewhere.

There were a lot of complaints until I worked out how to get that
ordering out of BitKeeper.

-- 
dwmw2

