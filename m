From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] checkout-cache fix
Date: Thu, 12 May 2005 21:38:38 +0200
Message-ID: <20050512193838.GE324@pasky.ji.cz>
References: <118833cc05050911255e601fc@mail.gmail.com> <7vr7gewuxt.fsf@assigned-by-dhcp.cox.net> <20050510230357.GF26384@pasky.ji.cz> <7vsm0us5p5.fsf@assigned-by-dhcp.cox.net> <118833cc050511113122e2d17d@mail.gmail.com> <7vpsvxqwab.fsf@assigned-by-dhcp.cox.net> <7vd5rxquo5.fsf@assigned-by-dhcp.cox.net> <20050511224044.GI22686@pasky.ji.cz> <7voebhnwey.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 21:31:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWJOg-0005e1-1t
	for gcvg-git@gmane.org; Thu, 12 May 2005 21:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVELTim (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 15:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVELTim
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 15:38:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38105 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261504AbVELTij (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 15:38:39 -0400
Received: (qmail 11292 invoked by uid 2001); 12 May 2005 19:38:38 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voebhnwey.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 02:02:45AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Commit    cc01b05f0a3dfdf5ed114e429a7bec1ad549ab1c
> Author    Junio C Hamano <junkio@cox.net>, Wed May 11 17:00:16 2005 -0700
> Committer Junio C Hamano <junkio@cox.net>, Wed May 11 17:00:16 2005 -0700
> 
> Fix checkout-cache when existing work tree interferes with the checkout.

Thanks, applied. A nit about the commit message, though - I'd prefer you
to put this metadata stuff belong the --- separator, since they really
do not belong to the log message. I've already seen something like this
in one commit merged from git-jc (IIRC some of the Ingo Molnar's leak
fixes), and it was a little PITA there since the first line was some
 Date: header but we tend to use the first line as the commit's caption
at some places.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
