From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-log patches
Date: Sun, 8 May 2005 21:25:36 +0200
Message-ID: <20050508192536.GE9495@pasky.ji.cz>
References: <1742.10.10.10.24.1115573750.squirrel@linux1> <1115574136.9031.147.camel@pegasus> <1856.10.10.10.24.1115576809.squirrel@linux1> <1115578807.8949.12.camel@pegasus> <20050508191831.GD9495@pasky.ji.cz> <2014.10.10.10.24.1115580230.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcel Holtmann <marcel@holtmann.org>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 21:21:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUrKy-0001zp-0d
	for gcvg-git@gmane.org; Sun, 08 May 2005 21:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbVEHT11 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 15:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbVEHT0y
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 15:26:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18652 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262978AbVEHTZh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 15:25:37 -0400
Received: (qmail 13736 invoked by uid 2001); 8 May 2005 19:25:36 -0000
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <2014.10.10.10.24.1115580230.squirrel@linux1>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 08, 2005 at 09:23:50PM CEST, I got a letter
where Sean <seanlkml@sympatico.ca> told me that...
> On Sun, May 8, 2005 3:18 pm, Petr Baudis said:
> 
> >> I am not a really good git expert, but maybe another option for it would
> >> be fine.
> >>
> >> However there is another thing that I am missing. With Bitkeeper I was
> >> able to do something like "bk changes -umarcel" to list all changes done
> >> by the user "marcel". I like to have something similar with cg-log. Any
> >> ideas on how to do that?
> >
> > What should it take in regard? Username portion of the email address?
> > The email address itself? The realname?
> >
> 
> Attached is a new version of cg-log that includes a -u option that takes a
> single parameter.   Whatever you put in that parameter will be searched in
> the author line, so it can be part or all of an authors name and/or email
> address.
> 
> So you could do:
> 
> cg-log -c -f -u petr
> 
> or
> 
> cg-log -uxpasky
> 
> Sean

That sounds great. Could you please post a patch against the current
Cogito's cg-log?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
