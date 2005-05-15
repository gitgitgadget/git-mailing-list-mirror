From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: git-rev-list  in local commit order
Date: Sun, 15 May 2005 23:30:29 +0200
Organization: linutronix
Message-ID: <1116192629.11872.201.camel@tglx>
References: <4127.10.10.10.24.1116107046.squirrel@linux1>
	 <1116186533.11872.152.camel@tglx>
	 <4971.10.10.10.24.1116187076.squirrel@linux1>
	 <1116189873.11872.171.camel@tglx>
	 <1102.10.10.10.24.1116189916.squirrel@linux1>
	 <1116191636.11872.195.camel@tglx>
	 <1273.10.10.10.24.1116192097.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 23:30:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXQg4-0001Ay-NG
	for gcvg-git@gmane.org; Sun, 15 May 2005 23:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVEOV3r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 17:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVEOV3X
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 17:29:23 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:56482
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261257AbVEOV3U
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 17:29:20 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id DB15E65C003;
	Sun, 15 May 2005 23:29:06 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 14A332829A;
	Sun, 15 May 2005 23:29:20 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <1273.10.10.10.24.1116192097.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-05-15 at 17:21 -0400, Sean wrote:
> > Time is illusion.
> 
> What you're missing is that time is only important in this case to deduce
> the relative age of each commit LOCALLY.   The intention of this proposal
> is not to allow time comparison of commits between repositories. 


I do not want to compare times. I want to figure out workflows and
histories between different repositories.

>  In fact,
> you'll see if you look closely, that you don't need to do that in order to
> solve the stated problem of sorting the commits by the time they were
> merged LOCALLY.

Even LOCALLY is no guarantee for correct timestamps.


tglx


