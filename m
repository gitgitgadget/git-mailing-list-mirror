From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fetch-clone progress: finishing touches.
Date: Sat, 11 Feb 2006 19:01:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602111901160.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602111041430.3691@g5.osdl.org>
 <7vslqpjq2q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 04:02:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F87Ut-0004Mg-Nk
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 04:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWBLDBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 22:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWBLDBr
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 22:01:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57289 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750956AbWBLDBq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 22:01:46 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1C31gDZ000415
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 11 Feb 2006 19:01:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1C31f0A022933;
	Sat, 11 Feb 2006 19:01:42 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslqpjq2q.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15973>



On Sat, 11 Feb 2006, Junio C Hamano wrote:
> 
>    BTW, don't you mean 512 down there???
> 
>         -	msecs += (int)(tv.tv_usec - prev_tv.tv_usec) >> 10;
>         +	msecs += usec_to_binarymsec(tv.tv_usec - prev_tv.tv_usec);
>         +
>                 if (msecs > 500) {
>                         prev_tv = tv;

Well, it's just a random number, but if you like 512 better than 500, go 
wild ;)

		Linus
