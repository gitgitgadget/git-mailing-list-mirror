From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-diff fixed to work with BSD xargs
Date: Wed, 21 Sep 2005 12:11:13 +0200
Message-ID: <20050921101113.GF24902@pasky.or.cz>
References: <11253960093915-git-send-email-martin@catalyst.net.nz> <pan.2005.09.21.07.33.14.533314@smurf.noris.de> <20050921081547.GA24902@pasky.or.cz> <20050921100631.GQ14206@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 12:15:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI1ZQ-0000AM-32
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 12:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVIUKLR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 06:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVIUKLR
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 06:11:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63139 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750810AbVIUKLQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 06:11:16 -0400
Received: (qmail 3822 invoked by uid 2001); 21 Sep 2005 12:11:14 +0200
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050921100631.GQ14206@kiste.smurf.noris.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9039>

Dear diary, on Wed, Sep 21, 2005 at 12:06:31PM CEST, I got a letter
where Matthias Urlichs <smurf@smurf.noris.de> told me that...
> Hi,

Hi,

> Petr Baudis:
> > 
> > $filter is a file name. -s tests whether the file of that name exists
> > and is non-empty.
> > 
> True -- but it's still a bug.
> 
> If the name itself is empty (or has spaces), you get wrong results.

but the name is never empty. It can contain spaces, and this should be
fixed, but we have a lot of places to fix in Cogito if it is to work
right with $TMPDIR containing spaces (what a weird idea).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
