From: Randy Brandenburg <randy.brandenburg@woh.rr.com>
Subject: Re: Unable to fork off sideband demultiplexer
Date: Fri, 3 Jun 2011 12:32:06 +0000 (UTC)
Message-ID: <loom.20110603T142958-87@post.gmane.org>
References: <loom.20110601T161508-689@post.gmane.org> <7vk4d5h3qt.fsf@alter.siamese.dyndns.org> <20110601173524.GF7132@sigill.intra.peff.net> <loom.20110601T210757-955@post.gmane.org> <loom.20110602T172442-653@post.gmane.org> <20110602192927.GA21262@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 14:35:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSTat-0005r0-31
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 14:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680Ab1FCMfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 08:35:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:38049 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754477Ab1FCMfH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 08:35:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QSTak-0005oI-R4
	for git@vger.kernel.org; Fri, 03 Jun 2011 14:35:06 +0200
Received: from pm2-users.caci.com ([204.194.77.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 14:35:06 +0200
Received: from randy.brandenburg by pm2-users.caci.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 14:35:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 204.194.77.3 (Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; InfoPath.2; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; MS-RTC LM 8))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175007>

Jeff King <peff <at> peff.net> writes:

> 
> If you build without NO_PTHREADS set on a Solaris 9 box, does it work on
> that same box? That would confirm or deny my ABI compatibility theory
> (and hopefully point us in the right direction for the sunfreeware
> people to build a binary that works on Solaris 9 and 10).
> 
> -Peff
> 

I will attempt building without NO_PTHREADS set today along with the other 
suggestions about modifying the config.mak instead of the actual Makefile. Stay 
tuned.

- Randy
