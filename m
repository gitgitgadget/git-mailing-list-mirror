From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Do I misunderstand cg-merge --squash option
Date: Thu, 10 Nov 2005 19:15:53 +0000
Message-ID: <200511101915.53736.alan@chandlerfamily.org.uk>
References: <200511100025.05993.alan@chandlerfamily.org.uk> <20051110101206.GP30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 10 20:17:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaHto-0001WG-9C
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 20:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVKJTPt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 14:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVKJTPt
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 14:15:49 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:48006
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932162AbVKJTPt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 14:15:49 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EaHtk-0004dI-5P
	for git@vger.kernel.org; Thu, 10 Nov 2005 19:15:48 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20051110101206.GP30496@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11506>

On Thursday 10 Nov 2005 10:12, Petr Baudis wrote:

>
> Why do you want to do a squash merge?
>

I used git experimentally as I built a web application from scratch, learning 
both what I wanted the application to look like and how to do it with the 
packages I was using.  There is several hundreds of commits that are totally 
irrelevant (both because they were all different directions I was trying and 
then backing out of and because I saved state just were I was when I gave up 
for the day).

So what I was experimenting with was whether I could somehow get rid of that 
history (at least in one branch) before making that history public.


>
> I told you in the documentation - "re-merging with that branch later
> will cause trouble". If you want to be able to re-merge the branch
> later, you shouldn't use squash merge. And you shouldn't use squash
> merge anyway, expect for few narrow use cases.

I know - I saw the warning - and I was only experimenting.  I just didn't 
understand what had happened.

I am now experimenting with another approach using grafts etc.  But I will 
post on that seperately, so as not to confuse titles of the e-mail thread.

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
