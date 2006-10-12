From: Wolfgang Denk <wd@denx.de>
Subject: Re: cg-commit does not run pre-commit hook?
Date: Thu, 12 Oct 2006 16:27:36 +0200
Message-ID: <20061012142736.74DE7353BDE@atlas.denx.de>
References: <20061012011548.GT20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 16:29:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY1XN-0005b2-BI
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 16:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709AbWJLO1k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 10:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422708AbWJLO1j
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 10:27:39 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54663 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S1422654AbWJLO1i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 10:27:38 -0400
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 38F2599C6F;
	Thu, 12 Oct 2006 16:27:37 +0200 (CEST)
X-Auth-Info: 9M60vx568Ue5E+wB6r26vrUnaPVvyX6ZUthmwUvmmis=
X-Auth-Info: 9M60vx568Ue5E+wB6r26vrUnaPVvyX6ZUthmwUvmmis=
Received: from mail.denx.de (p54967CA6.dip.t-dialin.net [84.150.124.166])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 225699272F;
	Thu, 12 Oct 2006 16:27:37 +0200 (CEST)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 8ECC36D00BA;
	Thu, 12 Oct 2006 16:27:36 +0200 (CEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 74DE7353BDE;
	Thu, 12 Oct 2006 16:27:36 +0200 (MEST)
To: Petr Baudis <pasky@suse.cz>
In-reply-to: Your message of "Thu, 12 Oct 2006 03:15:48 +0200."
             <20061012011548.GT20017@pasky.or.cz> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28780>

Dear Petr,

in message <20061012011548.GT20017@pasky.or.cz> you wrote:
> 
>   historically, Git and Cogito use a different set of hooks (Cogito got
> hooks first but Git picked own names and usage and now is prevalent).

I see. And current versions of cogito don't support any pre-commit
script, right?

> I have plans for making Cogito support Git hooks and slowly deprecate
> those own ones for which Git has counterparts, but didn't get to it yet.
> I might do today during the more boring lectures... ;-)

Keeping my fingers crossed :-)

I'm looking for a way  to  register  the  commit  message  into  some
changelog  file  which  gets  checked  in with the same commit. Or is
there another way to do this? 

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The goal of science is to build better mousetraps. The goal of nature
is to build better mice.
