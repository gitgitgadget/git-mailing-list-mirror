From: Andreas Ericsson <ae@op5.se>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 18:59:19 +0200
Message-ID: <4714EDE7.3010407@op5.se>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org> <471448D0.6080200@op5.se> <E1Ihfrl-0007w1-3I@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: barkalow@iabervon.org, raa.lkml@gmail.com,
	Johannes.Schindelin@gmx.de, tsuna@lrde.epita.fr,
	git@vger.kernel.org, make-w32@gnu.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:59:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhplX-0007PR-9W
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 18:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760547AbXJPQ7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 12:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbXJPQ7Y
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 12:59:24 -0400
Received: from mail.op5.se ([193.201.96.20]:32945 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753805AbXJPQ7X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 12:59:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2061517306FB;
	Tue, 16 Oct 2007 18:59:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id je79t6FUrr7d; Tue, 16 Oct 2007 18:59:30 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 1E3D817306C4;
	Tue, 16 Oct 2007 18:59:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <E1Ihfrl-0007w1-3I@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61213>

Eli Zaretskii wrote:
>> From: Andreas Ericsson <ae@op5.se>
> 
>> I *think* (correct me if I'm wrong) that git is still faster
>> than a whole bunch of other scm's on windows, but to one who's used to
>> its performance on Linux that waiting several seconds to scan 10k files
>> just feels wrong.
> 
> Unless that 10K is a typo and you really meant 100K, I don't think 10K
> files should take several seconds to scan on Windows.  I just tried
> "find -print" on a directory with 32K files in 4K subdirectories, and
> it took 8 sec elapsed with a hot cache.  So 10K files should take at
> most 2 seconds, even without optimizing file traversal code.  Doing
> the same with native Windows system calls ("dir /s") brings that down
> to 4 seconds for 32K files.
> 

It was a typo. Thanks for correcting me.

> On the other hand, what packages have 100K files?  If there's only one
> -- the Linux kernel -- then I think this kind of performance is for
> all practical purposes unimportant on Windows

But it's most definitely not. The *huge* projects that have looked at
git have sometimes turned it down simply because they're either cross-
platform (Mozilla) or they have translators that use windows exclusively
(KDE and Mozilla, just to mention two).

Both Mozilla and KDE repos are *much* larger than the Linux repo.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
