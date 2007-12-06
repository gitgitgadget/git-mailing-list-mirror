From: Andreas Ericsson <ae@op5.se>
Subject: Re: git guidance
Date: Thu, 06 Dec 2007 19:24:23 +0100
Message-ID: <47583E57.9050208@op5.se>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com> <200712010950.15628.a1426z@gawab.com> <4755D2E8.5050402@cfl.rr.com> <200712072035.47359.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Phillip Susi <psusi@cfl.rr.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jing Xue <jingxue@digizenstudio.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Al Boldi <a1426z@gawab.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 19:24:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0LOz-0002NL-RU
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 19:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbXLFSY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 13:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbXLFSY2
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 13:24:28 -0500
Received: from mail.op5.se ([193.201.96.20]:59674 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbXLFSY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 13:24:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 57BCA1F080AD;
	Thu,  6 Dec 2007 19:24:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28tWxfDcdq8N; Thu,  6 Dec 2007 19:24:25 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 330E51F080AB;
	Thu,  6 Dec 2007 19:24:25 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <200712072035.47359.a1426z@gawab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67312>

Al Boldi wrote:
> Phillip Susi wrote:
>> Al Boldi wrote:
>>> IOW, git currently only implements the server-side use-case, but fails
>>> to deliver on the client-side.  By introducing a git-client manager that
>>> handles the transparency needs of a single user, it should be possible
>>> to clearly isolate update semantics for both the client and the server,
>>> each handling their specific use-case.
>> Any talk of client or server makes no sense since git does not use a
>> client/server model.
> 
> Whether git uses the client/server model or not does not matter; what matters 
> is that there are two distinct use-cases at work here:  one on the 
> server/repository, and the other on the client.  
> 

Git is distributed. The repository is everywhere. No server is actually needed.
Many use one anyway since it can be convenient. It's not, however, necessary.

>> If you wish to use a centralized repository, then
>> git can be set up to transparently push/pull to/from said repository if
>> you wish via hooks or cron jobs.
> 
> Again, this only handles the interface to/from the server/repository, but 
> once you pulled the sources, it leaves you without Version Control on the 
> client.
> 

No, that's CVS, SVN and other centralized scm's. With git you have perfect
version control on each peer. That's the entire idea behind "fully
distributed".

> By pulling the sources into a git-client manager mounted on some dir, it 
> should be possible to let the developer work naturally/transparently in a 
> readable/writeable manner, and only require his input when reverting locally 
> or committing to the server/repository.
> 

How is that different from what every SCM, including git, is doing today? The
user needs to tell the scm when it's time to take a snapshot of the current
state. Git is distributed though, so committing is usually not the same as
publishing. Is that lack of a single command to commit and publish what's
nagging you? If it's not, I completely fail to see what you're getting at,
unless you've only ever looked at repositories without a worktree attached,
or you think that git should work like an editor's "undo" functionality,
which would be quite insane.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
