From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Newbie falls at first hurdle
Date: Sat, 17 Sep 2005 18:01:35 +0100
Message-ID: <200509171801.35612.alan@chandlerfamily.org.uk>
References: <200509171309.46893.alan@chandlerfamily.org.uk> <200509171730.19055.alan@chandlerfamily.org.uk> <7v1x3n8wps.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 17 19:02:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGg4E-0001hQ-L0
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 19:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVIQRBb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 13:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVIQRBb
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 13:01:31 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:60315
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751160AbVIQRBb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2005 13:01:31 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EGg4A-0000rL-4h
	for git@vger.kernel.org; Sat, 17 Sep 2005 18:01:30 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7v1x3n8wps.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8769>

On Saturday 17 Sep 2005 17:50, Junio C Hamano wrote:
> Alan Chandler <alan@chandlerfamily.org.uk> writes:
> > The editor file that came up with this listed all the files it was going
> > to commit INCLUDING some .files from the root directory (I am using
> > eclipse, so I had files like .project and .classpath there).  It says in
> > the Documentation that git ignores those - has it done?
>
> We ignore '.git' but we let you have paths starting with dots
> these days -- the change happened quite a while ago and if some
> documentation still says we do not, then you spotted a
> documentation bug.

I think that is probably my problem.  I deleted all of /usr/local/bin (which 
had an earlier version of git in it) and then tried to re-install git 99.6.  
When I got a permissions error I gave up and installed into ~/bin.


But of course - that probably means that the man pages are old ones from when 
I last installed git (very early in the development cycle).

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
