From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] Merge strategy 'applyreject'
Date: Wed, 13 Sep 2006 23:16:17 +0200
Message-ID: <20060913211617.GJ23891@pasky.or.cz>
References: <20060913210817.GA30782@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 23:16:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNc5q-0000uM-7m
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 23:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWIMVQX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 17:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWIMVQX
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 17:16:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55728 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751209AbWIMVQW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 17:16:22 -0400
Received: (qmail 6405 invoked by uid 2001); 13 Sep 2006 23:16:17 +0200
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060913210817.GA30782@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26950>

Dear diary, on Wed, Sep 13, 2006 at 11:08:17PM CEST, I got a letter
where Shawn Pearce <spearce@spearce.org> said that...
> Create merge strategy 'applyreject'.
> 
> The applyreject merge strategy is a two head merge strategy which performs
> the merge by obtaining the diff between the common base and the branch
> being merged and applies it to the current branch using git-apply --reject.
> Consequently any failures are written to .rej files, rather than using
> the RCS <<<<<<< ======= >>>>>>> format.

So, it's essentially the same as the classic resolve strategy, just
handling rejects differently? I think that should be more obvious from
its name, perhaps resolve-rej?

.rej files, what a nuisance to handle those... :)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
