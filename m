From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH Cogito] Fix t/t9300-seek.sh
Date: Sat, 12 Nov 2005 23:47:43 +0100
Message-ID: <20051112224743.GJ30496@pasky.or.cz>
References: <20051112223914.GA1150@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 12 23:48:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb4A3-00026f-FD
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 23:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVKLWrq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 17:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbVKLWrq
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 17:47:46 -0500
Received: from w241.dkm.cz ([62.24.88.241]:53724 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964872AbVKLWrp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 17:47:45 -0500
Received: (qmail 21908 invoked by uid 2001); 12 Nov 2005 23:47:43 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051112223914.GA1150@ferdyx.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11717>

Dear diary, on Sat, Nov 12, 2005 at 11:39:14PM CET, I got a letter
where "Fernando J. Pereda" <ferdy@ferdyx.org> said that...
> After 'seeking' to the first commit, identical should have 'identical'
> instead of 'nonconflicting'.

Nope, since we locally change it to "nonconflicting", and cg-seek is
supposed to keep local changes.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
