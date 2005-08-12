From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fix documentation installation
Date: Fri, 12 Aug 2005 23:14:19 +0200
Message-ID: <20050812211418.GB20812@pasky.ji.cz>
References: <20050812211145.GA20812@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 12 23:15:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3grC-0008PU-25
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 23:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVHLVOX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 17:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVHLVOX
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 17:14:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23054 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932092AbVHLVOX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 17:14:23 -0400
Received: (qmail 1761 invoked by uid 2001); 12 Aug 2005 21:14:19 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050812211145.GA20812@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Aug 12, 2005 at 11:11:45PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> told me that...
> diff --git a/tools/Makefile b/tools/Makefile
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -18,7 +18,7 @@ git-%: %.c
>  all: $(PROGRAMS)
>  
>  install: $(PROGRAMS) $(SCRIPTS)
> -	$(INSTALL) -m755 -d $(dest)$(bindir)
> +	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
>  	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(DESTDIR)$(bindir)
>  
>  clean:

I should read patches after myself, especially when messing with them.
This hunk is obviously superflous, so feel free to drop it from that
patch if you are in a "patch purity" mood. OTOH it is obviously valid
fix. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
