From: Petr Baudis <pasky@ucw.cz>
Subject: Re: fix various issues in gitapply.sh (basically did not handle add/del/cm at all)
Date: Fri, 15 Apr 2005 20:15:26 +0200
Message-ID: <20050415181526.GA7417@pasky.ji.cz>
References: <1113557318.23299.165.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 15 20:24:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMVTR-0004sF-Df
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 20:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVDOSTY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 14:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVDOSRy
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 14:17:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18910 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261897AbVDOSPe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 14:15:34 -0400
Received: (qmail 9187 invoked by uid 2001); 15 Apr 2005 18:15:26 -0000
To: Martin Schlemmer <azarah@nosferatu.za.org>
Content-Disposition: inline
In-Reply-To: <1113557318.23299.165.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 15, 2005 at 11:28:38AM CEST, I got a letter
where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> Hi,
> 
> The egrep regex should not escape the '{' and '}', and also add a check
> for ' \t' so that we do not pickup stuff like '+----', etc.  Fix typo in
> assignment.  Check if file exists in new tree before adding/removing
> (might add support for this lowlevel to increase speed?).  Fix typo in
> line removing temp files.
> 
> Signed-off-by: Martin Schlemmer <azarah@gentoo.org>

Thanks for the merge and typo fixes. I can't imagine how, but it really
appeared to work for me that time!

I'm confused however what does the exits_in_cache() (what exits? exists?)
gives us, apart of horribly-looking code. What bug does it fix?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
