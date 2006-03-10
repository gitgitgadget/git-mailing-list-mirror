From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: What's in git.git
Date: Fri, 10 Mar 2006 11:44:43 +0100
Message-ID: <20060310104443.GA4491@c165.ib.student.liu.se>
References: <7v1wxg82r3.fsf@assigned-by-dhcp.cox.net> <46a038f90603060105m29595745ke64d4a623506c0b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 11:45:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHf77-0002Td-6K
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 11:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbWCJKou (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 05:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbWCJKou
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 05:44:50 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:3974 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1752215AbWCJKot
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 05:44:49 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 0A4404114; Fri, 10 Mar 2006 12:00:21 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FHf6x-0006kh-00; Fri, 10 Mar 2006 11:44:43 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90603060105m29595745ke64d4a623506c0b0@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17468>

On Mon, Mar 06, 2006 at 10:05:41PM +1300, Martin Langhoff wrote:
> On 3/6/06, Junio C Hamano <junkio@cox.net> wrote:
> > - The deathmatch between annotate/blame (Ryan Anderson, Fredrik
> >   Kuivinen, me cheerleading)
> 
> Add fuel to the fire  ;-) Can git-blame take cached git-rev-list
> output like annotate does with -S?
> 

Currently it cannot do that. How is that option used? If you want to
make annotate/blame faster for certain files you might as well cache
the output of annotate/blame instead of the git-rev-list output, no?

What am I missing?

- Fredrik
