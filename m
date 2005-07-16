From: randy_dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] Documentation: update recommended workflow when working
 with others.
Date: Fri, 15 Jul 2005 21:39:22 -0700
Organization: YPO4
Message-ID: <20050715213922.66414ac5.rdunlap@xenotime.net>
References: <7vslyfo143.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 16 06:40:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DteSo-0004Tk-0n
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 06:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVGPEji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 00:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVGPEji
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 00:39:38 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:372 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262193AbVGPEjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 00:39:36 -0400
Received: from pool-71-111-147-75.ptldor.dsl-w.verizon.net ([71.111.147.75]:57930 helo=midway)
	by chretien.genwebhost.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.51)
	id 1DteSj-000215-QT; Sat, 16 Jul 2005 00:39:42 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslyfo143.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 15 Jul 2005 20:56:12 -0700 Junio C Hamano wrote:

> Clarify that the hierarchy implied by the recommended workflow
> is only informal.
> 
> Refer readers to nice illustration by Rundy Dunlap.
                                        Randy            (please)

> 
> Separate out the step to "push" to own public repository in the
> workflow.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
> 
>  Documentation/tutorial.txt |   65 ++++++++++++++++++++++++++++++--------------
>  1 files changed, 44 insertions(+), 21 deletions(-)
> 
> 70a7f8c18de2006a500059f3cb23d353250d0a9d
> diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
> --- a/Documentation/tutorial.txt
> +++ b/Documentation/tutorial.txt
> @@ -967,7 +967,19 @@ unpacked in the destination, unless rsyn
>  	Working with Others
>  	-------------------
>  
> -A recommended work cycle for a "project lead" is like this:
> +Although git is a truly distributed system, it is often
> +convenient to organize your project with an informal hierarchy
> +of developers.  Linux kernel development is run this way.  There
> +is a nice illustration (page 17, "Merges to Mainline") in Rundy
> +Dunlap's presentation (http://tinyurl.com/a2jdg).

and again.  :)

Thanks,
---
~Randy
