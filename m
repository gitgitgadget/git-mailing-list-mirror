From: Petr Baudis <pasky@suse.cz>
Subject: Re: problem installing latest cogito
Date: Sat, 21 Jan 2006 22:06:22 +0100
Message-ID: <20060121210622.GO28365@pasky.or.cz>
References: <fof4t15q95qkakgk6b7fbfuqh3r6q7ei17@4ax.com> <20060121194826.GK28365@pasky.or.cz> <BAYC1-PASMTP061F43C7F760A9FB73B616AE1E0@CEZ.ICE> <7vmzhpl4r7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: morgad@eclipse.co.uk, git@vger.kernel.org,
	sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat Jan 21 22:05:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0Pur-00064J-Nu
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 22:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWAUVEy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 16:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWAUVEy
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 16:04:54 -0500
Received: from w241.dkm.cz ([62.24.88.241]:5521 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932255AbWAUVEx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 16:04:53 -0500
Received: (qmail 30048 invoked by uid 2001); 21 Jan 2006 22:06:22 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzhpl4r7.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15020>

Dear diary, on Sat, Jan 21, 2006 at 09:12:28PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> I got a complaint or two that some version of sed does not like
> ';' to concatenate more than one commands, and have been trying
> to train myself to do either multiple -e options or multi-line
> scripts.  E.g when I am tempted to say:
> 
> 	sed -e 's/foo/bar/;s/baz/boa/' froboz
> 
> Instead, I say either
> 
> 	sed -e 's/foo/bar/' -e 's/baz/boa/' froboz

Good idea, thanks. Hopefully this will fix Dave Morgan's problem.
Committed and pushed out.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
