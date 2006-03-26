From: Petr Baudis <pasky@suse.cz>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 22:31:16 +0200
Message-ID: <20060326203116.GR18185@pasky.or.cz>
References: <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <44264426.8010608@michonline.com> <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <20060326100717.GD18185@pasky.or.cz> <Pine.LNX.4.64.0603260829550.15714@g5.osdl.org> <20060326191445.GQ18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 22:31:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNbtH-0000VB-7Q
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 22:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWCZUbE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 15:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWCZUbE
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 15:31:04 -0500
Received: from w241.dkm.cz ([62.24.88.241]:5258 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751543AbWCZUbD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 15:31:03 -0500
Received: (qmail 1604 invoked by uid 2001); 26 Mar 2006 22:31:16 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20060326191445.GQ18185@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18057>

Dear diary, on Sun, Mar 26, 2006 at 09:14:45PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> Curiously, git-rev-list does something totally strange when trying to
> list per-file history at this point:
> 
> 	$ git-rev-list HEAD -- d
> 	4
> 
> Huh? (It should list 6, 5, 4 instead.)

Obviously not 6 since the file was not changed in that revision, but I'd
still expect it to list 5.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
