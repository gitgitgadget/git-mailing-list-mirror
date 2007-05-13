From: Sean <seanlkml@sympatico.ca>
Subject: Re: ~ and ^
Date: Sun, 13 May 2007 15:17:09 -0400
Message-ID: <20070513151709.76b5fc33.seanlkml@sympatico.ca>
References: <20070513144442.b3cba792.seanlkml@sympatico.ca>
	<7v8xbssfti.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 21:31:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnJmt-0000pG-FT
	for gcvg-git@gmane.org; Sun, 13 May 2007 21:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757852AbXEMTbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 15:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758155AbXEMTbS
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 15:31:18 -0400
Received: from bay0-omc2-s1.bay0.hotmail.com ([65.54.246.137]:17366 "EHLO
	bay0-omc2-s1.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757852AbXEMTbR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2007 15:31:17 -0400
X-Greylist: delayed 846 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 May 2007 15:31:17 EDT
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]) by bay0-omc2-s1.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 13 May 2007 12:17:10 -0700
X-Originating-IP: [65.95.67.118]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.95.67.118]) by bayc1-pasmtp06.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 13 May 2007 12:17:33 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1HnJXp-0002fL-NE; Sun, 13 May 2007 15:15:49 -0400
In-Reply-To: <7v8xbssfti.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed 2.3.1 (GTK+ 2.10.8; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 13 May 2007 19:17:33.0968 (UTC) FILETIME=[5C017900:01C79593]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47174>

On Sun, 13 May 2007 12:07:21 -0700
Junio C Hamano <junkio@cox.net> wrote:

> Interesting.
> 
> At least, "ls ~0" does not seem to get confused by bash to be
> the home directory of the root user, so I do not offhand think
> of a reason not to have ~$n as a synonym to HEAD~$n.  Would that
> be useful?  I dunno.

Not going to shake the world but it's a small convenience.  Would be
a bit nicer if a lone ~ worked as well without escaping, but I'm not
sure you'd accept a patch to assume "~" whenever git is passed the
users home directory as a lone option ;)

> P.S.
> 
> Welcome back to the list ;-)
> 

Thanks.

Sean
