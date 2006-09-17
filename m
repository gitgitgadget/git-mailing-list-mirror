From: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] Add virtualization support to git-daemon
Date: Sun, 17 Sep 2006 11:23:30 -0500
Message-ID: <E1GOzQY-0001G7-Ju@jdl.com>
References: <E1GOint-00048W-2A@jdl.com>  <7vvenm4xi6.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 18:23:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOzQg-0006yH-7V
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 18:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWIQQXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 12:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWIQQXc
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 12:23:32 -0400
Received: from jdl.com ([66.118.10.122]:29899 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S964979AbWIQQXb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 12:23:31 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1GOzQY-0001G7-Ju; Sun, 17 Sep 2006 11:23:31 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Your message of "Sun, 17 Sep 2006 03:07:29 PDT."
             <7vvenm4xi6.fsf@assigned-by-dhcp.cox.net> 
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27197>

So, like, the other day Junio C Hamano mumbled:
> I have a few stylistic comments but the contents look quite sane
> and fine.

Let me clean it up some and respin.

> > I use an inetd invocation like this example:
> >
> >     git  stream  tcp  nowait  nobody  /usr/bin/git-daemon git-daemon --inetd
> >         --verbose --syslog
> >         --export-all --interpolated-path=/pub/%H/%D
> > 	/pub/software /software
> > 	/pub/www.example.com/software
> > 	/pub/www.example.org/software
> > 	/pub
> 
> This would be nice to have as an example in the documentation.

Will do.

jdl
