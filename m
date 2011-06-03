From: Randy Brandenburg <randy.brandenburg@woh.rr.com>
Subject: Re: Unable to fork off sideband demultiplexer
Date: Fri, 3 Jun 2011 18:52:32 +0000 (UTC)
Message-ID: <loom.20110603T204919-581@post.gmane.org>
References: <loom.20110601T161508-689@post.gmane.org> <7vk4d5h3qt.fsf@alter.siamese.dyndns.org> <20110601173524.GF7132@sigill.intra.peff.net> <loom.20110601T210757-955@post.gmane.org> <loom.20110602T172442-653@post.gmane.org> <20110602192927.GA21262@sigill.intra.peff.net> <loom.20110603T151012-143@post.gmane.org> <20110603144907.GA11273@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 20:52:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSZUK-0001Q1-J0
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 20:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983Ab1FCSwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 14:52:47 -0400
Received: from lo.gmane.org ([80.91.229.12]:36770 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361Ab1FCSwr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 14:52:47 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QSZUA-0001LQ-QJ
	for git@vger.kernel.org; Fri, 03 Jun 2011 20:52:45 +0200
Received: from pm2-users.caci.com ([204.194.77.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 20:52:42 +0200
Received: from randy.brandenburg by pm2-users.caci.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 20:52:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 204.194.77.3 (Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; InfoPath.2; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; MS-RTC LM 8))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175021>

Jeff King <peff <at> peff.net> writes:

> 
> Thanks, that's a good data point. I know you are probably out of time
> for fooling with such things, but if you get a chance, could you try
> building also with "-pthreads" in PTHREAD_CFLAGS? I'm wondering if the
> problem is as simple as that.
> 
> -Peff
> 

OK, rebuilt with NO_PTHREADS=0 and PTHREAD_CFLAGS=-pthreads and it seems to be 
working. Just tested quickly for the basics (push and pull). I will be able to 
test more in depth next week, but I would assume that all will be okay.

Hope this helps.

-Randy
