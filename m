From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 23:33:39 +0000
Organization: linutronix
Message-ID: <1115854419.22180.196.camel@tglx>
References: <1115847510.22180.108.camel@tglx>
	 <2780.10.10.10.24.1115848852.squirrel@linux1>
	 <1115849141.22180.123.camel@tglx>
	 <2807.10.10.10.24.1115850254.squirrel@linux1>
	 <1115850619.22180.133.camel@tglx>
	 <2853.10.10.10.24.1115850996.squirrel@linux1>
	 <1115851718.22180.153.camel@tglx>
	 <2883.10.10.10.24.1115852463.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 01:25:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW0Zy-0000vQ-W3
	for gcvg-git@gmane.org; Thu, 12 May 2005 01:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVEKXcz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 19:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVEKXcz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 19:32:55 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:26499
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261317AbVEKXcx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 19:32:53 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 3469C65C003;
	Thu, 12 May 2005 01:32:46 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id E190C28204;
	Thu, 12 May 2005 01:32:47 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <2883.10.10.10.24.1115852463.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 19:01 -0400, Sean wrote:
> Why would anyone care how many repositories Russell or Greg use?  Why does
> anyone care if Dave used his repo A, B, or C?   Aren't I still just going
> to contact him via his author email addy if I have an issue with an object
> he has added to the stream?

He? What the hell have the sparc-2.6 and net-2.6 in common except the
same owner/maintainer ? Should we base the heuristics on directories and
filenames ? Cool.

It is relevant for the maintainers to have information which is
consistent over a repository. So the source of change _is_ relevant.

> Exactly!!!  So what is relevant of getting the same thing from Dave's A or
> B?  

The relevant part is, that it _is_ relevant for Dave to know where the
hell a problem was introduced.

> The only point would be to show chain of command, but you don't seem
> interested in that.

What is the chain of commands good for ? Does the chain of commands
change the history information in a specific repository ? 

No. 

If you buy food, then it is relevant if you get it from A directly or
via B. The commit and the referenced tree is immutable and does neither
change the consistency nor gets uneatable.

> > If you want to do this, you break the fast forward mechanism and
> > reinvent the pull ping-pong which is avoided by the fast forwards.
> 
> Yes, I think there are other ways to avoid the ping pong too.

True, but not with a plain rsync approach

tglx


