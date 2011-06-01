From: Randy Brandenburg <randy.brandenburg@woh.rr.com>
Subject: Re: Unable to fork off sideband demultiplexer
Date: Wed, 1 Jun 2011 19:10:19 +0000 (UTC)
Message-ID: <loom.20110601T210757-955@post.gmane.org>
References: <loom.20110601T161508-689@post.gmane.org> <7vk4d5h3qt.fsf@alter.siamese.dyndns.org> <20110601173524.GF7132@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 21:10:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRqoU-0000Pv-15
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 21:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124Ab1FATKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 15:10:37 -0400
Received: from lo.gmane.org ([80.91.229.12]:56900 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956Ab1FATKg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 15:10:36 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QRqoI-0000K6-M0
	for git@vger.kernel.org; Wed, 01 Jun 2011 21:10:30 +0200
Received: from pm2-users.caci.com ([204.194.77.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 21:10:30 +0200
Received: from randy.brandenburg by pm2-users.caci.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 21:10:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 204.194.77.3 (Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; InfoPath.2; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; MS-RTC LM 8))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174892>

Jeff King <peff <at> peff.net> writes:
> 
> I suspect it is more subtle than that. We've had several people recently
> reporting the same issue, and all are using pre-built binaries on
> Solaris 9. Given the weird errno value ("unknown error"), my guess is
> that the packages are built on Solaris 10, and there is some ABI
> incompatibility between the two platforms.
> 
> I'd be curious if building on Solaris 9, even without NO_PTHREADS set,
> fixes the issue.
> 
> -Peff
> 

Thank you for the insight. I will attempt to rebuild on the target platform and 
see what happens. 

I will post the results when I have an answer on whther that helped or not.
