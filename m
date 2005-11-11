From: Petr Baudis <pasky@suse.cz>
Subject: Re: Getting rid of symlinks in .git?
Date: Fri, 11 Nov 2005 14:01:00 +0100
Message-ID: <20051111130100.GR30496@pasky.or.cz>
References: <20051110204543.GZ30496@pasky.or.cz> <43746118.30404@hogyros.de> <81b0412b0511110443x48415032k8ca40d999071e8a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 14:01:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaYWk-0004uF-6i
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 14:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVKKNBD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 08:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVKKNBD
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 08:01:03 -0500
Received: from w241.dkm.cz ([62.24.88.241]:23215 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750721AbVKKNBC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 08:01:02 -0500
Received: (qmail 24526 invoked by uid 2001); 11 Nov 2005 14:01:00 +0100
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0511110443x48415032k8ca40d999071e8a9@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11593>

Dear diary, on Fri, Nov 11, 2005 at 01:43:18PM CET, I got a letter
where Alex Riesen <raa.lkml@gmail.com> said that...
> It looks more like a rhetorical question of code cleanup, because
> in-file symlinks already handle all possible cases.

Another example recently mentioned is detecting current branch over
HTTP, where you can't see where the HEAD's symlink heads to.

Actually, cg-fetch wouldn't handle the 'ref:' head properly. Just fixed
that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
