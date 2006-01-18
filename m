From: Petr Baudis <pasky@suse.cz>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 15:21:39 +0100
Message-ID: <20060118142139.GQ28365@pasky.or.cz>
References: <200601181325.59832.Mathias.Waack@rantzau.de> <20060118125158.GN28365@pasky.or.cz> <20060118140917.GA15438@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mathias Waack <Mathias.Waack@rantzau.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 15:20:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzEAm-0002qV-6s
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 15:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWAROUZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 09:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbWAROUY
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 09:20:24 -0500
Received: from w241.dkm.cz ([62.24.88.241]:59283 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030329AbWAROUY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 09:20:24 -0500
Received: (qmail 1008 invoked by uid 2001); 18 Jan 2006 15:21:39 +0100
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <20060118140917.GA15438@mythryan2.michonline.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14830>

Dear diary, on Wed, Jan 18, 2006 at 03:09:17PM CET, I got a letter
where Ryan Anderson <ryan@michonline.com> said that...
> ... Why would that be the optimal method?

Ow. I suppose that's what you call "blinded by invalid implicit
assumptions". Obviously, if you are ok with such a grand move, this is
the best.

This also reminds me that I should finally merge the cg-mv patch.

> 	git fetch ../r1/
> 	GIT_INDEX_FILE=.git/tmp-index git-read-tree FETCH_HEAD
> 	GIT_INDEX_FILE=.git/tmp-index git-checkout-cache -a -u
> 	git-update-cache --add -- $(GIT_INDEX_FILE=.git/tmp-index git-ls-files)
> 	cp .git/FETCH_HEAD .git/MERGE_HEAD
> 	git commit

But if you want to have an idea what's actually going on on the high
level, perhaps the

	cd r2
	cg-branch-add r1 ../r1/.git
	cg-fetch r1
	cg-merge -j r1

might be easier. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
