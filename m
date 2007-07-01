From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] cvstrack: work on imported cvs and other git branches
Date: Sun, 1 Jul 2007 21:52:45 +0200
Message-ID: <3599CEBD-F5AB-4DF6-BC00-372A9C710BEA@zib.de>
References: <11832957963860-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0707011533370.4438@racer.site> <4880FDC4-BAD5-49B4-871B-98259D691449@zib.de> <Pine.LNX.4.64.0707011710480.4438@racer.site> <4ED65855-7B87-43C6-B5F1-162FC9A1CBF0@zib.de> <Pine.LNX.4.64.0707011852531.4438@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 21:51:48 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I55SU-0002pr-Fc
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 21:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756384AbXGATvo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 15:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755993AbXGATvo
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 15:51:44 -0400
Received: from mailer.zib.de ([130.73.108.11]:35101 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755203AbXGATvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 15:51:43 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l61JpfUa001346;
	Sun, 1 Jul 2007 21:51:41 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1bbde.pool.einsundeins.de [77.177.187.222])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l61JpeQw019172
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 1 Jul 2007 21:51:41 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0707011852531.4438@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51320>


On Jul 1, 2007, at 7:53 PM, Johannes Schindelin wrote:

> On Sun, 1 Jul 2007, Steffen Prohaska wrote:
>
>> The background is, I plan to convince approximately 60 developers
>> to migrate from CVS to git and I'm searching for a way to start the
>> transition with some beta testers, while maintaining full cvs
>> infrastructure in place for the remaining users.
>
> Why not just cvsimporting into git, and then replace the CVS server  
> with
> git-cvsserver? That's what I did.

I thought about that but I don't know yet how to slice our existing
CVS repository. Most developers use partial checkouts.

But maybe I should reconsider and evaluate git-cvsserver in more detail.

	Steffen
