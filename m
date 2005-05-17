From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Constify
Date: Tue, 17 May 2005 23:27:42 +0200
Message-ID: <20050517212742.GM7136@pasky.ji.cz>
References: <118833cc050422110872a6f4a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 17 23:28:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY9bQ-0001zr-My
	for gcvg-git@gmane.org; Tue, 17 May 2005 23:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVEQV2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 17:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVEQV2D
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 17:28:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31460 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261964AbVEQV1s (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 17:27:48 -0400
Received: (qmail 26578 invoked by uid 2001); 17 May 2005 21:27:42 -0000
To: Morten Welinder <mwelinder@gmail.com>
Content-Disposition: inline
In-Reply-To: <118833cc050422110872a6f4a5@mail.gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 08:08:02PM CEST, I got a letter
where Morten Welinder <mwelinder@gmail.com> told me that...
> Hi!

Hello,

> This patch makes strings type "const char *" and keeps people honest.
> [Here's to hoping that nothing in this email setup mangles whitespace...]
> 
> Signed-off-by: Morten Welinder (mwelinder@gmail.com)

thanks. It was somewhat mangled, but the main problem was that it has
rot for too long in my queue, so only quite small part of it survived
until today. :-( I've not applied the CFLAGS+=-Wwrite-strings part yet,
since it would require some additional cleanups and such, so I'll let
someone else deal with that. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
