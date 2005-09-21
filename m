From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] cg-diff fixed to work with BSD xargs
Date: Wed, 21 Sep 2005 12:54:51 +0200
Message-ID: <20050921105451.GA24934@kiste.smurf.noris.de>
References: <11253960093915-git-send-email-martin@catalyst.net.nz> <pan.2005.09.21.07.33.14.533314@smurf.noris.de> <20050921081547.GA24902@pasky.or.cz> <20050921100631.GQ14206@kiste.smurf.noris.de> <20050921101113.GF24902@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 12:57:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI2Gw-0002A6-E4
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 12:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVIUKz6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 06:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVIUKz6
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 06:55:58 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:27797 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1750817AbVIUKz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 06:55:57 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EI2Fa-0008RG-Ql; Wed, 21 Sep 2005 12:55:16 +0200
Received: (nullmailer pid 25141 invoked by uid 501);
	Wed, 21 Sep 2005 10:54:51 -0000
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050921101113.GF24902@pasky.or.cz>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9042>

Hi,

Petr Baudis:
> but the name is never empty.

OK, OK, I'll shut up already... my fault, I guess, from not having scanned
the whole file.

> It can contain spaces, and this should be
> fixed, but we have a lot of places to fix in Cogito if it is to work
> right with $TMPDIR containing spaces (what a weird idea).

There are enough people out there whose tempdir is named "Temporary
Items" or similar, so I guess somebody (i.e. me ;-) should walk through
the shell scripts and try not to get brain lock-up as he scans for that
sort of problem.

Of course, I also need a few hours to complete the SVN interpreter, and
a few hours to finalize a draft implementation of a *real* git library,
and ... well, if somebody wants the stuff badly enough to actually pay
for it I'm listening.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The cruelest thing that has happened to Lincoln since he was shot by Booth
was to fall into the hands of Sandburg.
					-- Edmund Wilson
