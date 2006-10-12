From: Wolfgang Denk <wd@denx.de>
Subject: Re: cg-commit does not run pre-commit hook?
Date: Thu, 12 Oct 2006 17:54:44 +0200
Message-ID: <20061012155444.27391353BDE@atlas.denx.de>
References: <452E545F.6060406@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 17:58:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY2tV-00016m-Oy
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 17:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422726AbWJLPyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 11:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422725AbWJLPyq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 11:54:46 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:31684 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S1422726AbWJLPyp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 11:54:45 -0400
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 0123398B19;
	Thu, 12 Oct 2006 17:54:45 +0200 (CEST)
X-Auth-Info: q3a4y3C/lInUDPV5dPNP2ptmXQu57GZb8PX/ZUcEjIk=
X-Auth-Info: q3a4y3C/lInUDPV5dPNP2ptmXQu57GZb8PX/ZUcEjIk=
X-Auth-Info: q3a4y3C/lInUDPV5dPNP2ptmXQu57GZb8PX/ZUcEjIk=
Received: from mail.denx.de (p54967CA6.dip.t-dialin.net [84.150.124.166])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id D7FCF93A79;
	Thu, 12 Oct 2006 17:54:44 +0200 (CEST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 483046D00BA;
	Thu, 12 Oct 2006 17:54:44 +0200 (CEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 27391353BDE;
	Thu, 12 Oct 2006 17:54:44 +0200 (MEST)
To: Andreas Ericsson <ae@op5.se>
In-reply-to: Your message of "Thu, 12 Oct 2006 16:42:39 +0200."
             <452E545F.6060406@op5.se> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28785>

Dear Andreas,

in message <452E545F.6060406@op5.se> you wrote:
>
> > I'm looking for a way  to  register  the  commit  message  into  some
> > changelog  file  which  gets  checked  in with the same commit. Or is
> > there another way to do this? 
> 
> git log

Sorry, this does not work, as I can access the  commit  message  only
*after* the commit completed, and then it's too late to get it into a
file that shall be included with the very same commit.

> The commit message is already saved and git (and cogito, I presume) 
> provide tools to fetch those messages in the relevant different orders 

Yes, but only *after* doing the job. That's why  I'm  looking  for  a
pre-commit hook.

> One part of why a proper SCM is so good to use is that you shouldn't 
> have to maintain a separate changelog. The SCM should create one for you 
> when you ask it, based on the comments you've entered when actually 
> making the changes.

True, as long as you can work within the SCM. The changelog file  I'm
talking  about is mostly for people who just work with exported trees
(for example, when they download a tarball).


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Everyting looks interesting until you do it. Then you find it's  just
another job.                     - Terry Pratchett, _Moving Pictures_
