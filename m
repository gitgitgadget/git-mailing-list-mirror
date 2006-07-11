From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Install built-ins as symlinks
Date: Tue, 11 Jul 2006 20:36:42 +0200
Message-ID: <20060711183642.GB13776@pasky.or.cz>
References: <11526131782190-git-send-email-alp@atoker.com> <11526131781900-git-send-email-alp@atoker.com> <1152613179634-git-send-email-alp@atoker.com> <11526131791902-git-send-email-alp@atoker.com> <11526131792773-git-send-email-alp@atoker.com> <11526131792377-git-send-email-alp@atoker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 20:37:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0N6Y-00011w-3Y
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 20:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWGKSgp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 14:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWGKSgp
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 14:36:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16088 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932076AbWGKSgo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 14:36:44 -0400
Received: (qmail 23732 invoked by uid 2001); 11 Jul 2006 20:36:42 +0200
To: Alp Toker <alp@atoker.com>
Content-Disposition: inline
In-Reply-To: <11526131792377-git-send-email-alp@atoker.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23723>

Dear diary, on Tue, Jul 11, 2006 at 12:19:38PM CEST, I got a letter
where Alp Toker <alp@atoker.com> said that...
> diff --git a/Makefile b/Makefile
> index 5b7bac8..cb5a5cc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -538,7 +538,7 @@ git$X: git.c common-cmds.h $(BUILTIN_OBJ
>  builtin-help.o: common-cmds.h
>  
>  $(BUILT_INS): git$X
> -	rm -f $@ && ln git$X $@
> +	ln -sf git$X $@
>  
>  common-cmds.h: Documentation/git-*.txt
>  	./generate-cmdlist.sh > $@+

Doesn't the git$X dependency become pointless at this point?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
