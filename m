From: Petr Baudis <pasky@suse.cz>
Subject: Re: dotfile support
Date: Wed, 7 Dec 2005 22:51:56 +0100
Message-ID: <20051207215156.GK22159@pasky.or.cz>
References: <20050416230058.GA10983@ucw.cz> <118833cc05041618017fb32a2@mail.gmail.com> <20050416183023.0b27b3a4.pj@sgi.com> <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org> <42620092.9040402@dwheeler.com> <Pine.LNX.4.58.0504170857580.7211@ppc970.osdl.org> <42628D1B.3000207@dwheeler.com> <20051207145646.GA9207@tumblerings.org> <4396FFB0.4040203@op5.se> <20051207161130.GA10924@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 22:53:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek7CU-0001W4-T6
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 22:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbVLGVvm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 16:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbVLGVvm
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 16:51:42 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56797 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030375AbVLGVvl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 16:51:41 -0500
Received: (qmail 19387 invoked by uid 2001); 7 Dec 2005 22:51:56 +0100
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20051207161130.GA10924@tumblerings.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13346>

Dear diary, on Wed, Dec 07, 2005 at 05:11:30PM CET, I got a letter
where Zack Brown <zbrown@tumblerings.org> said that...
> So my question is, why does cg-init ignore dotfiles within the directory when it
> first initializes the repository?

Precisely for Linus' reasons - by default, I believe your VCS shouldn't
care about your hidden files, because they are hidden, and probably not
content but kind of meta-content - the exception is .gitignore, but you
can add more even on cg-init time. I have to admit that cg-init
documentation wasn't sufficiently clear about this autoignoring stuff,
I've tried to improve that now, and cg-init will warn you (post hoc)
that it autoignored some files.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
