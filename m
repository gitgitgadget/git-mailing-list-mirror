From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Support for configurable git command aliases (v2)
Date: Sun, 4 Jun 2006 23:20:51 +0200
Message-ID: <20060604212050.GV10488@pasky.or.cz>
References: <20060604211931.10117.82695.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 23:20:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn01G-0005iq-Hf
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 23:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWFDVUT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 17:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWFDVUT
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 17:20:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15510 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932253AbWFDVUT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 17:20:19 -0400
Received: (qmail 10372 invoked by uid 2001); 4 Jun 2006 23:20:51 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060604211931.10117.82695.stgit@machine.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21285>

Dear diary, on Sun, Jun 04, 2006 at 11:19:31PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> This patch adds support for configurable aliases for git commands -
> "alias.WHATEVER = which ever" will kick in when you do "git WHATEVER"
> and substitute WHATEVER with "which ever" (splitted to arguments at
> whitespaces).
> 
> The second version does all the work in handle_aliases() which was
> inspired by Johannes Schindelin's patch.
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>

And I forgot to mention that it also adds the interactivity test
requested by Janek - aliases are now interpreted only when stdout is a
tty.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
