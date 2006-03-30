From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to switch kernel customizations from 2.6.15.6 to 2.6.16?
Date: Wed, 29 Mar 2006 19:22:35 -0800
Message-ID: <7vy7ys4nwk.fsf@assigned-by-dhcp.cox.net>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
	<7vmzfac7gn.fsf@assigned-by-dhcp.cox.net>
	<1143687710.2524.1.camel@mattlaptop.metaesthetics.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 30 05:22:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOnk9-0004W2-Cq
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 05:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWC3DWi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 22:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWC3DWi
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 22:22:38 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:8677 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751261AbWC3DWh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 22:22:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060330032237.UOLH17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 29 Mar 2006 22:22:37 -0500
To: Matt McCutchen <hashproduct@verizon.net>
In-Reply-To: <1143687710.2524.1.camel@mattlaptop.metaesthetics.net> (Matt
	McCutchen's message of "Wed, 29 Mar 2006 22:01:50 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18188>

Matt McCutchen <hashproduct@verizon.net> writes:

>> you could:
>> 
>>         $ git fetch git://../torvalds/linux-2.6.git tag v2.6.16
>>         $ git checkout -b 2.6.16-matt v2.6.16
>>         $ git format-patch origin master | git am -3
>...
> What is wrong?

Me ;-).

It should have been 

        $ git format-patch --stdout origin master | git am -3

Sorry.

> Perhaps this is just politics, but which kernel repository is more
> official, and why?  Linus's or the one I have been using,
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
> ?

Linus tree is the main development for the 2.6.(X+1), and
2.6.x.y are managed by the stable team.  They serve different
purposes, and both are "official".
