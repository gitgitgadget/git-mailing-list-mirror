From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: git-rev-list  in local commit order
Date: Sun, 15 May 2005 23:13:56 +0200
Organization: linutronix
Message-ID: <1116191636.11872.195.camel@tglx>
References: <4127.10.10.10.24.1116107046.squirrel@linux1>
	 <1116186533.11872.152.camel@tglx>
	 <4971.10.10.10.24.1116187076.squirrel@linux1>
	 <1116189873.11872.171.camel@tglx>
	 <1102.10.10.10.24.1116189916.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 23:13:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXQQ7-0007QQ-9o
	for gcvg-git@gmane.org; Sun, 15 May 2005 23:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVEOVNO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 17:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVEOVNO
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 17:13:14 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:48802
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261242AbVEOVMy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 17:12:54 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 7A20065C003;
	Sun, 15 May 2005 23:12:34 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 999312829A;
	Sun, 15 May 2005 23:12:47 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <1102.10.10.10.24.1116189916.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-05-15 at 16:45 -0400, Sean wrote:

> You can continue the personal attacks or you can simply explain to the
> list what you are trying to accomplish and why it is important and why any
> other proposal besides yours isn't worthy.

I did never say, that my proposal is the world formula, but I have more
than once explained, why time is the worst source of information.

You keep beating on time as a reliable source of information and tell me
that most people are completely happy with it. You must have access to a
quite good opinion survey.


Time of files or time in commit blobs is not a reliable information to
keep track of
 - workflows
 - history
Thats all I'm talking about and it is the concern of others too.

In "git" repositories the only reliable source of information is the
parent child relationship. This information is only partially reliable
due to the head forward scenario. I think we agreed on this, right ?
You have no other reliable source of information due to the fact that
committer names are not unique.

> I disagree that they're inherently error prone, 
> steps can be taken to make them as secure as you desire.

You continue to propose stuff which is not viable. Can you enforce 
- NTP syncronisation
- the correct usage of rsync options 
- timestamp aware backups 

No, you can't.

Why did the mail people resort to "In-Reply-To", "Message-ID" and
"References" ? Because time turned out to be an inreliable source of
information. Please read the related discussions before you argue that
time based solutions are sufficient.

Time is illusion. 


tglx



