From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cherry-pick particular object
Date: Wed, 29 Mar 2006 00:54:29 +0200
Message-ID: <20060328225429.GD27689@pasky.or.cz>
References: <20060328113107.20ab4c21.sebastien@xprima.com> <BAYC1-PASMTP02B05019F52DE48793CB39AED30@CEZ.ICE> <Pine.LNX.4.64.0603281435410.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sean <seanlkml@sympatico.ca>,
	=?iso-8859-1?Q?S=E9bastien?= Pierre <sebastien@xprima.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 00:54:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FON57-0000Ct-Vu
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 00:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWC1Wyb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 17:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWC1Wyb
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 17:54:31 -0500
Received: from w241.dkm.cz ([62.24.88.241]:19074 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964775AbWC1Wyb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 17:54:31 -0500
Received: (qmail 25851 invoked by uid 2001); 29 Mar 2006 00:54:29 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603281435410.15714@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18137>

Dear diary, on Wed, Mar 29, 2006 at 12:44:02AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> Ie you can have a tree like this:
> 
> 	100644 blob f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f    abc
> 	120000 blob f2ba8f84ab5c1bce84a7b441cb1959cfc7093b7f    file
> 
> where the first one is a regular file called "abc" (which contains the 
> string "abc"), and the second is the _symlink_ that points to "abc".
> 
> They share the exact same blob, and what distinguishes them is the 
> filemode info from git-read-tree.

Huh? Didn't you rather want to say that "file" will point to a blob
containing just the "abc" string (the symlink target)? ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
