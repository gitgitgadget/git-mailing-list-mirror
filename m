From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Cogito-0.15
Date: Tue, 20 Sep 2005 02:35:15 +0200
Message-ID: <20050920003515.GC13537@pasky.or.cz>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7vwtleyml5.fsf@assigned-by-dhcp.cox.net> <20050919011428.GF22391@pasky.or.cz> <20050919231538.GA4074@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964802AbVITAfT@vger.kernel.org Tue Sep 20 02:37:12 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964802AbVITAfT@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHW6f-0003bI-NO
	for glk-linux-kernel-3@gmane.org; Tue, 20 Sep 2005 02:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVITAfT (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 19 Sep 2005 20:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVITAfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 20:35:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58323 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964803AbVITAfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 20:35:17 -0400
Received: (qmail 15556 invoked by uid 2001); 20 Sep 2005 02:35:15 +0200
To: Pavel Machek <pavel@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050919231538.GA4074@elf.ucw.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8936>

Dear diary, on Tue, Sep 20, 2005 at 01:15:38AM CEST, I got a letter
where Pavel Machek <pavel@suse.cz> told me that...
> Hi!

Hi,

> >   this is the release of Cogito-0.15. It fixes several minor bugs, and
> > adds a feature or two. The most important thing though is that this
> > depends on Git-core-0.99.7 and uses the new command names. Everyone is
> > encouraged to upgrade at least to this Cogito version in the next few
> > days, since the older Cogito versions likely won't work with the future
> > Git-core releases.
> > 
> >   To stay in sync with the Git terminology, Cogito also renames its
> > cg-pull to cg-fetch. Since this is a major naming change (I'm not too
> > happy about it, personally), cg-pull will stay aliased to cg-fetch for
> > at least one (likely two) next major Cogito releases (it also produces a
> > warning when invoked as cg-pull). In the more distant future, cg-pull
> > will slowly become the new name of cg-update, to make it confusing.
> 
> Could we keep at least the cg-update name?

yes, I want to retain it. I'm not 100% decided yet whether to actually
use the pull term for anything in Cogito. Previous usage reportedly
confused some, the new usage actually confuses me and apparently some
other people. So I might just avoid the 'pull' term in the future
altogether. Not decided yet, though, and opinions obviously welcomed.

> It is certainly not a *pull* because it does update local repository
> (and tree, too).

AIUI, that's what makes it a pull for *cough* some people. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
