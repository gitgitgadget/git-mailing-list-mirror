From: Randy Brandenburg <randy.brandenburg@woh.rr.com>
Subject: Re: Unable to fork off sideband demultiplexer
Date: Fri, 3 Jun 2011 13:30:00 +0000 (UTC)
Message-ID: <loom.20110603T151012-143@post.gmane.org>
References: <loom.20110601T161508-689@post.gmane.org> <7vk4d5h3qt.fsf@alter.siamese.dyndns.org> <20110601173524.GF7132@sigill.intra.peff.net> <loom.20110601T210757-955@post.gmane.org> <loom.20110602T172442-653@post.gmane.org> <20110602192927.GA21262@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 15:30:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSUSL-0000hK-4R
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 15:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225Ab1FCNaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 09:30:24 -0400
Received: from lo.gmane.org ([80.91.229.12]:40195 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754666Ab1FCNaX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 09:30:23 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QSUS6-0000Xl-Hr
	for git@vger.kernel.org; Fri, 03 Jun 2011 15:30:14 +0200
Received: from pm2-users.caci.com ([204.194.77.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 15:30:14 +0200
Received: from randy.brandenburg by pm2-users.caci.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 15:30:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 204.194.77.3 (Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; InfoPath.2; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; MS-RTC LM 8))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175008>

Jeff King <peff <at> peff.net> writes:

> Great, I'm glad it's working. With NO_PTHREADS set, you will be
> fork()ing off the sideband process instead of using a thread. So you
> avoid pthreads altogether and it works, but you can't do multi-threaded
> delta compression.
> 
> If you build without NO_PTHREADS set on a Solaris 9 box, does it work on
> that same box? That would confirm or deny my ABI compatibility theory
> (and hopefully point us in the right direction for the sunfreeware
> people to build a binary that works on Solaris 9 and 10).
> 

Building without NO_PTHREADS set results in the original "broken" behaviour. I 
am staying with the working version in the interest of time. May investigate 
more later. 

Thanks for all the insight and tips.

- Randy
