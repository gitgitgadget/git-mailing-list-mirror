From: Petr Baudis <pasky@suse.cz>
Subject: Re: local cg-clone doesn't seem to work
Date: Tue, 13 Sep 2005 11:13:01 +0200
Message-ID: <20050913091301.GA28515@pasky.or.cz>
References: <2b05065b050912121721046257@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 11:14:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EF6qw-0003Ny-5v
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 11:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVIMJNH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 05:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVIMJNG
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 05:13:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54414 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751165AbVIMJNF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 05:13:05 -0400
Received: (qmail 30271 invoked by uid 2001); 13 Sep 2005 11:13:01 +0200
To: eschvoca <eschvoca@gmail.com>
Content-Disposition: inline
In-Reply-To: <2b05065b050912121721046257@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8462>

Dear diary, on Mon, Sep 12, 2005 at 09:17:57PM CEST, I got a letter
where eschvoca <eschvoca@gmail.com> told me that...
> Hi, I think I've found a bug in cogito.  To reproduce, try this:

Hi,

>  mkdir testing
>  cd testing
>  echo "This is the INSTALL file" > INSTALL
>  cg-init  # complete the commit
>  
>  cd ..
>  mkdir testing2
>  cd testing2
>  cg-clone -s ../testing
>  
>  Then I get the following error:
>  
>  defaulting to local storage area
>  Using hard links
>  cp: missing destination file
>  Try `cp --help' for more information.
>  cg-pull: unable to get the HEAD branch
>  cg-clone: pull failed
>  
>  I'm a newbie so maybe I'm just doing something dumb.

yes, sorry about that - it was introduced a short while before the
release and Jan Blunck already submitted a fix. It'll be fixed in
0.14.1.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
