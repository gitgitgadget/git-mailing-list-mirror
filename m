From: Petr Baudis <pasky@suse.cz>
Subject: Re: Latest cogito broken with bash-3.1
Date: Mon, 12 Dec 2005 01:26:31 +0100
Message-ID: <20051212002631.GW22159@pasky.or.cz>
References: <1134220724.15125.4.camel@blade> <20051211001106.GV22159@pasky.or.cz> <1134289867.9541.9.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 01:28:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElbWf-0000GH-I3
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 01:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVLLA0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 19:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbVLLA0j
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 19:26:39 -0500
Received: from w241.dkm.cz ([62.24.88.241]:23445 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750936AbVLLA0j (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2005 19:26:39 -0500
Received: (qmail 17074 invoked by uid 2001); 12 Dec 2005 01:26:31 +0100
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1134289867.9541.9.camel@blade>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13509>

  Hello,

Dear diary, on Sun, Dec 11, 2005 at 09:31:07AM CET, I got a letter
where Marcel Holtmann <marcel@holtmann.org> said that...
> it's now working again. Thanks. What do you think about another release?
> I haven't checked the other distributions yet, but I just saw that
> Debian unstable also moved to version 3.1 of bash.

  yes, I was planning 0.16.1 on Sunday anyway. Going to tag it now.

> There exists also another problem with the new bash. It is the broken
> pipe error from cg-log.
> 
> cg-log: line 141: echo: write error: Broken pipe
> 
> The line number varies depending how much you scrolled and when you
> scrolled to the end no broken pipe error comes up. Do you have any idea
> on how to deal with this. I saw your comment about that bash is broken
> and the extra trap command, but it doesn't help. I never saw that
> problem with older versions of bash.

  Then that's quite funny, one-line broken pipe message has been always
there (in the past it looked much worse, we thankfully managed to bring
it down to this at least).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
