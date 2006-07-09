From: Petr Baudis <pasky@suse.cz>
Subject: Re: What *have* I done?
Date: Sun, 9 Jul 2006 23:21:13 +0200
Message-ID: <20060709212113.GS29115@pasky.or.cz>
References: <87u05ru30p.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 23:21:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzgia-0002gh-3R
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 23:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWGIVVQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 17:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbWGIVVQ
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 17:21:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51110 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161166AbWGIVVP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 17:21:15 -0400
Received: (qmail 18760 invoked by uid 2001); 9 Jul 2006 23:21:13 +0200
To: Nix <nix@esperi.org.uk>
Content-Disposition: inline
In-Reply-To: <87u05ru30p.fsf@hades.wkstn.nix>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23565>

  Hi,

Dear diary, on Sun, Jul 09, 2006 at 12:48:22AM CEST, I got a letter
where Nix <nix@esperi.org.uk> said that...
> loki 593 /usr/packages/linux/linux% cg-diff | diffstat

  Note that cg-diff -s might be useful.

> loki 594 /usr/packages/linux/linux% cg-reset
> loki 595 /usr/packages/linux/linux% cg-diff
> loki 596 /usr/packages/linux/linux%

  ...but when you switch away and switch back, the uncommitted changes
appear again?

  Just in case, don't the tree happen to simply stay the same as in the
branch you switched from? (Try cg-diff -r yourpreviousbranch.)

  And most importantly, does this also happen with just stock 0.17.3
cg-switch? With stock master cg-switch? (If both is no, you probably
forgot to cherrypick some associated cg-switch bugfix or something.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
