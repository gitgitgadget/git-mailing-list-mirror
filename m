From: Petr Baudis <pasky@suse.cz>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 20:37:24 +0200
Message-ID: <20060610183724.GE2609@pasky.or.cz>
References: <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org> <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org> <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com> <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org> <46a038f90606092041neadcc54n2acb6272d1f71de7@mail.gmail.com> <Pine.LNX.4.64.0606092043460.5498@g5.osdl.org> <Pine.LNX.4.64.0606092109380.5498@g5.osdl.org> <9e4733910606092302h646ff554p107564417183e350@mail.gmail.com> <7vr71xk047.fsf@assigned-by-dhcp.cox.net> <9e4733910606100844v5f4765d8o85c9a6f239faed43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 20:37:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fp8KT-000793-Kw
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 20:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbWFJSg6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbWFJSg6
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 14:36:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43999 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030491AbWFJSg6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jun 2006 14:36:58 -0400
Received: (qmail 25202 invoked by uid 2001); 10 Jun 2006 20:37:24 +0200
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910606100844v5f4765d8o85c9a6f239faed43@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21615>

Dear diary, on Sat, Jun 10, 2006 at 05:44:58PM CEST, I got a letter
where Jon Smirl <jonsmirl@gmail.com> said that...
> The fetch on my local machine failed too. It left nothing behind, now
> I have to download the 680MB again.
> 
> walk 1f19465388a4ef7aff7527a13f16122a809487d4
> walk c3ca840256e3767d08c649f8d2761a1a887351ab
> walk 7a74e42699320c02b814b88beadb1ae65009e745
> error: Couldn't get
> http://mirrors.catalyst.net.nz/pub/mozilla.git//refs/tags/JS%5F1%5F7%5FALPHA%5FBASE
> for tags/JS_1_7_ALPHA_BASE
> Couldn't resolve host 'mirrors.catalyst.net.nz'
> error: Could not interpret tags/JS_1_7_ALPHA_BASE as something to pull
> [jonsmirl@jonsmirl mozgit]$ cg update
> There is no GIT repository here (.git not found)
> [jonsmirl@jonsmirl mozgit]$ ls -a
> .  ..
> [jonsmirl@jonsmirl mozgit]$

  You could try with cg-clone, which won't delete the repository if
things fail. It will clone only the master branch, though.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
