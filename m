From: "Simon Sasburg" <simon.sasburg@gmail.com>
Subject: Re: linux-2.6 clone with CygWin git
Date: Fri, 9 Nov 2007 16:02:21 +0100
Message-ID: <981e6de60711090702y2132a5eq889ac1b62993adce@mail.gmail.com>
References: <598D5675D34BE349929AF5EDE9B03E270174D8A2@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Medve Emilian" <Emilian.Medve@freescale.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 16:02:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqVNW-0004MN-IZ
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 16:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759860AbXKIPCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 10:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758875AbXKIPCX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 10:02:23 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:22900 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759500AbXKIPCW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 10:02:22 -0500
Received: by wa-out-1112.google.com with SMTP id v27so634141wah
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 07:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CZ7TZMwqOg9DiyupzP+n66E0ZDMM/7PyQc0ts0FwiS4=;
        b=llkRz2UJ2Kr5reY/ukKpxEqXh3x/aCE/7j4w66rgqMHHYsD1Qyvh+Nc893cehcbDTdmZ/HGdFZMh8ex4nnoQiDf2rgih7ybYGQDBydcu8o3XIPZhg3xTgWfPUgrN5fKO7Vmr8Fz5drykRTgcw7OzxuelBxUqQ/LxDH5hWV4jD0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BjV/u4CIYUlc23RF+/zsbF2+zd9wchBafU3JHf+IezDy6XXlZhMvk4BunHxF77/5nUYVJw4sc2avn6r0Re0JVYFGRIWTVewJqJCYPXzqSuQimeayCUaPk1XHgJCMTKIVyzZHplASHL3BC3+WW+3C7pN5P2EO/neonbovPSGY9FU=
Received: by 10.114.111.1 with SMTP id j1mr258597wac.1194620541593;
        Fri, 09 Nov 2007 07:02:21 -0800 (PST)
Received: by 10.114.124.16 with HTTP; Fri, 9 Nov 2007 07:02:21 -0800 (PST)
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E270174D8A2@az33exm24.fsl.freescale.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64198>

This is not a problem with git.

The kernel tree contains files which only differ from other files by case.

If on a case-insensitive filesystem this will cause problems like the
ones you noticed.

On Nov 9, 2007 3:29 PM, Medve Emilian <Emilian.Medve@freescale.com> wrote:
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
>
> Thanks,
> Emil.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
