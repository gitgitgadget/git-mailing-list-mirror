From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [patch] fixup GECOS handling
Date: Fri, 22 Apr 2005 19:18:18 +0200
Message-ID: <20050422171818.GE7173@pasky.ji.cz>
References: <1113820589.16288.5.camel@nosferatu.lan> <1113827713.5286.13.camel@localhost.localdomain> <1114179795.29271.18.camel@nosferatu.lan> <1114186599.31076.409.camel@axer.marchex.com> <1114189105.29271.36.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kyle@marchex.com, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 19:14:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP1ir-0003Gq-C6
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 19:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVDVRSV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 13:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVDVRSV
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 13:18:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45724 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262072AbVDVRSU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 13:18:20 -0400
Received: (qmail 7725 invoked by uid 2001); 22 Apr 2005 17:18:18 -0000
To: Martin Schlemmer <azarah@nosferatu.za.org>
Content-Disposition: inline
In-Reply-To: <1114189105.29271.36.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 06:58:25PM CEST, I got a letter
where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> Meaning, if they use a ',' in one of the fields (and it is a linux
> system with the chfn most probably from the shadow package), then they
> are looking for trouble.  The only reason I added the ';' was because
> somebody said whatever OS used it instead of a ','.

What about just swapping the two tests so that ; is cut off and , only
when no ; is around?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
