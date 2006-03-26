From: Petr Baudis <pasky@suse.cz>
Subject: Re: Following renames
Date: Mon, 27 Mar 2006 00:31:54 +0200
Message-ID: <20060326223154.GU18185@pasky.or.cz>
References: <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <44264426.8010608@michonline.com> <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <20060326100717.GD18185@pasky.or.cz> <Pine.LNX.4.64.0603260829550.15714@g5.osdl.org> <20060326191445.GQ18185@pasky.or.cz> <Pine.LNX.4.64.0603261415390.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 00:31:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNdm2-0003wB-PS
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 00:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWCZWbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 17:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWCZWbs
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 17:31:48 -0500
Received: from w241.dkm.cz ([62.24.88.241]:2434 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932085AbWCZWbr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 17:31:47 -0500
Received: (qmail 14411 invoked by uid 2001); 27 Mar 2006 00:31:54 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603261415390.15714@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18063>

Dear diary, on Mon, Mar 27, 2006 at 12:22:04AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> So commit "6" is uninteresting, and commit "5" will never even be
> looked at, since we decided that the history of "d" comes from the
> first parent with the same contents.

And this is the thing I have a problem with - this does not make much
sense to me, why can't we just follow all parents instead of arbitrarily
choosing one of them?

> which is correct (now, there are other histories _too_ that get us to the 
> same point, but the one you found this way was _a_ history).

Ok, in that case I want the _full_ history. :-)

> No, it's the expected output just because you expected merges to always 
> show up. Merges get ignored if any of the parents have the same content 
> already.

Eek. Can I avoid that? What was the reason for choosing this behavior?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
