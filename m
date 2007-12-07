From: Al Boldi <a1426z@gawab.com>
Subject: Re: git guidance
Date: Fri, 7 Dec 2007 20:35:47 +0300
Message-ID: <200712072035.47359.a1426z@gawab.com>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com> <200712010950.15628.a1426z@gawab.com> <4755D2E8.5050402@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jing Xue <jingxue@digizenstudio.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 18:37:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Kf4-0005xV-Au
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 18:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbXLFRg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 12:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbXLFRg6
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 12:36:58 -0500
Received: from [212.12.190.133] ([212.12.190.133]:49234 "EHLO raad.intranet"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751378AbXLFRg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 12:36:57 -0500
Received: from localhost ([10.0.0.111])
	by raad.intranet (8.8.7/8.8.7) with ESMTP id UAA31031;
	Thu, 6 Dec 2007 20:36:00 +0300
User-Agent: KMail/1.5
In-Reply-To: <4755D2E8.5050402@cfl.rr.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67307>

Phillip Susi wrote:
> Al Boldi wrote:
> > IOW, git currently only implements the server-side use-case, but fails
> > to deliver on the client-side.  By introducing a git-client manager that
> > handles the transparency needs of a single user, it should be possible
> > to clearly isolate update semantics for both the client and the server,
> > each handling their specific use-case.
>
> Any talk of client or server makes no sense since git does not use a
> client/server model.

Whether git uses the client/server model or not does not matter; what matters 
is that there are two distinct use-cases at work here:  one on the 
server/repository, and the other on the client.  

> If you wish to use a centralized repository, then
> git can be set up to transparently push/pull to/from said repository if
> you wish via hooks or cron jobs.

Again, this only handles the interface to/from the server/repository, but 
once you pulled the sources, it leaves you without Version Control on the 
client.

By pulling the sources into a git-client manager mounted on some dir, it 
should be possible to let the developer work naturally/transparently in a 
readable/writeable manner, and only require his input when reverting locally 
or committing to the server/repository.


Thanks!

--
Al
