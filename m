From: Andreas Ericsson <ae@op5.se>
Subject: Re: linux-2.6 clone with CygWin git
Date: Fri, 09 Nov 2007 16:00:53 +0100
Message-ID: <47347625.9040705@op5.se>
References: <598D5675D34BE349929AF5EDE9B03E270174D8A2@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Medve Emilian <Emilian.Medve@freescale.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 16:01:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqVMA-0003oy-PG
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 16:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbXKIPA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 10:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754123AbXKIPA5
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 10:00:57 -0500
Received: from mail.op5.se ([193.201.96.20]:48137 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864AbXKIPA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 10:00:56 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DD0E11F08723;
	Fri,  9 Nov 2007 16:00:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NVMAdrQiwrGC; Fri,  9 Nov 2007 16:00:54 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 03FCC1F0871F;
	Fri,  9 Nov 2007 16:00:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E270174D8A2@az33exm24.fsl.freescale.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64196>

Medve Emilian wrote:
> Hello,
> 
> 
> I noticed that something might not be right with my CygWin git (latest
> CygWin relevant build packages + a few days old git build from the next
> & master branches). When I clone, say,  Linus' tree over the native git
> protocol everything goes fine but a git-status shows this:
> 
> $ git-status
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #       modified:   include/linux/netfilter/xt_CONNMARK.h
> #       modified:   include/linux/netfilter/xt_DSCP.h
> #       modified:   include/linux/netfilter/xt_MARK.h
> #       modified:   include/linux/netfilter/xt_TCPMSS.h
> #       modified:   include/linux/netfilter_ipv4/ipt_CONNMARK.h
> #       modified:   include/linux/netfilter_ipv4/ipt_DSCP.h
> #       modified:   include/linux/netfilter_ipv4/ipt_ECN.h
> #       modified:   include/linux/netfilter_ipv4/ipt_MARK.h
> #       modified:   include/linux/netfilter_ipv4/ipt_TCPMSS.h
> #       modified:   include/linux/netfilter_ipv4/ipt_TOS.h
> #       modified:   include/linux/netfilter_ipv4/ipt_TTL.h
> #       modified:   include/linux/netfilter_ipv6/ip6t_HL.h
> #       modified:   include/linux/netfilter_ipv6/ip6t_MARK.h
> #       modified:   net/ipv4/netfilter/ipt_ECN.c
> #       modified:   net/ipv4/netfilter/ipt_TOS.c
> #       modified:   net/ipv4/netfilter/ipt_TTL.c
> #       modified:   net/ipv6/netfilter/ip6t_HL.c
> #       modified:   net/netfilter/xt_CONNMARK.c
> #       modified:   net/netfilter/xt_DSCP.c
> #       modified:   net/netfilter/xt_MARK.c
> #       modified:   net/netfilter/xt_TCPMSS.c
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> 
> git-fsck --strict --full finds no fault in the clone, git-reset --hard
> goes fine but changes nothing in the output of git-status. Some
> additional superficial investigation showed that git-diff doesn't even
> compare my checked out tree against the latest commit. Checkout of
> various commits shows the same issue.
> 
> Can somebody please double-check this scenario for me just to validate
> that this happens only due to some particular factors combination on my
> box?
> 

Your filesystem is not case sensitive and there are files with identical
names (apart from the case thing) in the Linux kernel repo.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
