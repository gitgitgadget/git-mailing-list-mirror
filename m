X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jon Loeliger <jdl@freescale.com>
Subject: Re: prune/prune-packed
Date: Fri, 27 Oct 2006 16:19:57 -0500
Message-ID: <1161983997.2426.422.camel@cashmere.sps.mot.com>
References: <20061022035919.GA4420@fieldses.org>
	 <7vy7r954k7.fsf@assigned-by-dhcp.cox.net>
	 <20061022231422.GA9375@fieldses.org> <20061023005336.GA12932@fieldses.org>
	 <453C1A35.70504@gmail.com>  <7vvembzp6y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 21:29:10 +0000 (UTC)
Cc: gitzilla@gmail.com, "J. Bruce Fields" <bfields@fieldses.org>,
	Git List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vvembzp6y.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30347>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdZEO-0000OY-Mf for gcvg-git@gmane.org; Fri, 27 Oct
 2006 23:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752485AbWJ0V1J (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 17:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbWJ0V1J
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 17:27:09 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:11771 "EHLO
 az33egw01.freescale.net") by vger.kernel.org with ESMTP id S1752485AbWJ0V1H
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 17:27:07 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200]) by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
 k9RLR2lx004272; Fri, 27 Oct 2006 14:27:02 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2]) by
 az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k9RLR0Vk017892; Fri, 27
 Oct 2006 16:27:01 -0500 (CDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sun, 2006-10-22 at 22:27, Junio C Hamano wrote:

> Sorry, but you are right and Linus is more right.  How about
> doing FRSX.
> 
> diff --git a/pager.c b/pager.c
> index 8bd33a1..4587fbb 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -50,7 +50,7 @@ void setup_pager(void)
>  	close(fd[0]);
>  	close(fd[1]);
>  
> -	setenv("LESS", "FRS", 0);
> +	setenv("LESS", "FRSX", 0);
>  	run_pager(pager);
>  	die("unable to execute pager '%s'", pager);
>  	exit(255);

I'm a little confused by all this because I
set the LESS environment variable by myself
already.  And I use the value that I like.
Why change it or override the user's settings
like this?  Or did I miss something?

Thanks,
jdl

