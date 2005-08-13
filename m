From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Sat, 13 Aug 2005 19:57:16 -0400
Message-ID: <20050813235716.GB6844@mythryan2.michonline.com>
References: <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org> <E1E35vU-0004nP-JR@highlab.com> <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org> <E1E3IOG-0005HO-AK@highlab.com> <20050811201558.GA2874@mars.ravnborg.org> <20050811202410.GB5411@kiste.smurf.noris.de> <42FBCD73.3090507@chandlerfamily.org.uk> <pan.2005.08.12.08.34.45.679778@smurf.noris.de> <Pine.LNX.4.62.0508120139230.19902@qynat.qvtvafvgr.pbz> <20050812103555.GG5411@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <david.lang@digitalinsight.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 01:58:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E45sn-0000Vc-Gg
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 01:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVHMX5j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 19:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVHMX5j
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 19:57:39 -0400
Received: from mail.autoweb.net ([198.172.237.26]:22721 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S1751334AbVHMX5i (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 19:57:38 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E45sM-0003NW-Oh; Sat, 13 Aug 2005 19:57:19 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E45sK-0004jz-00; Sat, 13 Aug 2005 19:57:16 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1E45sK-0003H1-9G; Sat, 13 Aug 2005 19:57:16 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050812103555.GG5411@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 12, 2005 at 12:35:55PM +0200, Matthias Urlichs wrote:
> David Lang:
> > after so many years of software development (and with the policy of never 
> > having conflicting command names) what three letter combinations are still 
> > avilable?
> > 
> Lots.
> 
> > I'm assuming that the much smaller pool of two letter commands was long 
> > since exhausted, but if not what two letter commands are available?
> > 
> Lots of them, I hope, but all of them obscure.
> 
> We even have 25 one-letter commands that are free. My /usr/bin/ only has
> 'w'. And if we run out, we could branch off into other alphabets;
> unfortunately, not everybody has a quick way to type an ??. Or ??. Or ???. ;-)

"gt" seems free on my machine here.  I haven't poke around at all the
other ones that have slightly different sets of software, but searching
on the Debian packages search engine:

http://packages.debian.org/cgi-bin/search_contents.pl?word=%2Fusr%2Fbin%2Fgt&searchmode=searchfiles&case=insensitive&version=unstable&arch=i386

cogito in Debian seems to have taken it already for git, anyway.

We can make the conversion easy for people by providing this shell
script for a few weeks:

	#!/bin/sh
	echo "Don't get a git - use gt!
	gt $*

-- 

Ryan Anderson
  sometimes Pug Majere
