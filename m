From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Clean up compatibility definitions.
Date: Mon, 5 Dec 2005 22:50:59 +0100
Message-ID: <20051205215059.GC4443@steel.home>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com> <81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com> <7vfyp7cuii.fsf@assigned-by-dhcp.cox.net> <7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 22:53:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjOFV-0002c2-HA
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 22:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVLEVvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 16:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbVLEVvf
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 16:51:35 -0500
Received: from devrace.com ([198.63.210.113]:2052 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964817AbVLEVvf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 16:51:35 -0500
Received: from tigra.home (p54A0DC5E.dip.t-dialin.net [84.160.220.94])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jB5Lp1Vn041480;
	Mon, 5 Dec 2005 15:51:02 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EjOEe-0001B2-00; Mon, 05 Dec 2005 22:51:00 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EjOEd-0003UI-Uh; Mon, 05 Dec 2005 22:50:59 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13238>

Junio C Hamano, Mon, Dec 05, 2005 21:22:42 +0100:
> This attempts to clean up the way various compatibility
> functions are defined and used.
...
> --- a/compat/mmap.c
> +++ b/compat/mmap.c
> @@ -2,7 +2,7 @@
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <errno.h>
> -#include "../cache.h"
> +#include "../git-compat-util.h"

I still think that compat functions should stand alone.
Especially if it does not costs us much (or even less than that).
