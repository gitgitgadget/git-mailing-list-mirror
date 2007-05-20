From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Sun, 20 May 2007 21:27:17 +0200
Message-ID: <200705202127.17723.johan@herland.net>
References: <20070520181447.GA10638@ferdyx.org>
 <200705202053.32291.johan@herland.net> <20070520191821.GF13197@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: "Fernando J. Pereda" <ferdy@ferdyx.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 21:27:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpr4F-0003d2-AR
	for gcvg-git@gmane.org; Sun, 20 May 2007 21:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859AbXETT1l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 15:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755929AbXETT1l
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 15:27:41 -0400
Received: from smtp.getmail.no ([84.208.20.33]:64544 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755859AbXETT1k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 15:27:40 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIC00G1NU235F00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 20 May 2007 21:27:39 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIC00I7SU1I9L40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 20 May 2007 21:27:18 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIC001D8U1IT3B0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 20 May 2007 21:27:18 +0200 (CEST)
In-reply-to: <20070520191821.GF13197@ferdyx.org>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47894>

On Sunday 20 May 2007, Fernando J. Pereda wrote:
> On Sun, May 20, 2007 at 08:53:32PM +0200, Johan Herland wrote:
> > I use KMail with Maildir for all my mail, except for my "patches" mail folder 
> > where I copy patches to import into my repos (which is in mbox format). 
> > KMail makes it easy to mix mbox and Maildir folders, so it's not really a 
> > big deal for me, but I would of course prefer Maildir support if it's 
> > possible to get it right.
> > 
> > Not sure how I feel about the usefulness of the patch if it requires correct 
> > sorting, and most mail clients turn out to _not_ sort correctly. Of course 
> > I have no idea what most mail clients do, but KMail seems to get it about 
> > right, AFAICS (mail filename starts with timestamp, so they're at least 
> > sorted roughly on (arrival) date).
> 
> [ I sent this only to Johan, re-sending to the rest of the people now.
> Sorry Johan for the dupe ]
> 
> I discussed this with a pine user in #git and we concluded (looking at
> the respective code) that both Mutt and Pine generate correct filenames
> based on when that mail arrived to the Maildir.
> 
> I use Mutt, and to test it I picked a thread that didn't arrive in
> order, tagged and copied it to a different Maildir, patches were
> splitted in correct order.

Well, if Mutt, Pine, and KMail all get it right, then it looks like a 
useful feature to add.

Does anybody now of (current versions of) mail clients that do _not_ 
get this right?


-- 
Johan Herland, <johan@herland.net>
www.herland.net
