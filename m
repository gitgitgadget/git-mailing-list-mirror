From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Add possibility to pass CFLAGS and LDFLAGS specific to the perl subdir
Date: Sun, 2 Jul 2006 00:59:06 +0200
Message-ID: <20060701225906.GC29115@pasky.or.cz>
References: <20060625014703.29304.12715.stgit@machine.or.cz> <7vk676orjy.fsf@assigned-by-dhcp.cox.net> <20060626082428.G52c9608e@leonov.stosberg.net> <20060626082754.G6ec0a61e@leonov.stosberg.net> <7vwtb4i89d.fsf@assigned-by-dhcp.cox.net> <20060626094211.G3b49c5c3@leonov.stosberg.net> <20060626100402.G5761a3ea@leonov.stosberg.net> <7vd5cvj1d0.fsf@assigned-by-dhcp.cox.net> <20060626222308.G71066338@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 00:59:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwoQl-0004kh-62
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 00:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWGAW7L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 18:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWGAW7L
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 18:59:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26514 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751444AbWGAW7J (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 18:59:09 -0400
Received: (qmail 28132 invoked by uid 2001); 2 Jul 2006 00:59:06 +0200
To: Dennis Stosberg <dennis@stosberg.net>
Content-Disposition: inline
In-Reply-To: <20060626222308.G71066338@leonov.stosberg.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23073>

Dear diary, on Tue, Jun 27, 2006 at 12:23:08AM CEST, I got a letter
where Dennis Stosberg <dennis@stosberg.net> said that...
> Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
> ---
>  Makefile |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index f44fbd3..306025d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -94,6 +94,8 @@ CFLAGS = -g -O2 -Wall
>  LDFLAGS =
>  ALL_CFLAGS = $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
> +PERL_CFLAGS =
> +PERL_LDFLAGS =
>  STRIP ?= strip
>  
>  prefix = $(HOME)

Just an annotation:

	ALL_* means "use these flags for compilation of all the stuff
			except perly stuff"
	PERL_* means "use these flags for compilation of really all the
			stuff"

So "all" might not mean what you think and Perl is stonger than
everything.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
