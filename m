From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH Cogito] Improve option parsing for cg-log
Date: Tue, 17 May 2005 22:16:58 +0200
Message-ID: <20050517201658.GD7136@pasky.ji.cz>
References: <1115931114.18499.66.camel@pegasus> <20050512211315.GP324@pasky.ji.cz> <1115934586.18499.70.camel@pegasus> <20050513054140.GF16464@pasky.ji.cz> <1115975134.18499.94.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 17 22:21:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY8UU-0007wc-KF
	for gcvg-git@gmane.org; Tue, 17 May 2005 22:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVEQURE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 16:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVEQURE
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 16:17:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14819 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261827AbVEQURA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 16:17:00 -0400
Received: (qmail 19213 invoked by uid 2001); 17 May 2005 20:16:58 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1115975134.18499.94.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, May 13, 2005 at 11:05:34AM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Petr,

Hi,

> > The -r option still must be after all the other options.
> 
> I see what you mean and it seems that I missed that option. Must be
> because you put the list_commit_files() between them and I assumed that
> there is no further option parsing.

Uhm, I know. :-) It sorta evolved like that. We didn't yet settle down
on where to actually put the functions. I'd say right after . cg-Xlib.

> Do you really wanna keep the double meaning of -r. Depending on a
> previous -r it is $log_start or $log_end.

Yes, by all means. On one side I like the colon notation, on the other
side this was always my biggest usability problem with SVN. And it costs
us nothing and does what the user would after all expect, I think.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
