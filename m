From: Petr Baudis <pasky@suse.cz>
Subject: Re: Towards CVS code-exchange and gateways
Date: Wed, 26 Oct 2005 10:53:02 +0200
Message-ID: <20051026085302.GF30889@pasky.or.cz>
References: <46a038f90510251357l23886747s8024a4326ad4e392@mail.gmail.com> <46a038f90510252035yb4167e1w2ee54d82896e5906@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 26 10:55:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUh2U-0000PB-Ag
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 10:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbVJZIxG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 04:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbVJZIxG
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 04:53:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11673 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932595AbVJZIxF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2005 04:53:05 -0400
Received: (qmail 20087 invoked by uid 2001); 26 Oct 2005 10:53:02 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90510252035yb4167e1w2ee54d82896e5906@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10655>

Dear diary, on Wed, Oct 26, 2005 at 05:35:41AM CEST, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> told me that...
> Update here: Sven sent me a cool 4 line shell script that has the
> basics. Next thing I know, and I was dumped into a boring presentation
> -- so I turned it into a more complete Perl script. Still incomplete &
> extremely untested, but showing the basics.
> 
> Give me a couple more boring presentations and we'll be done ;-)

Can I then import from the CVS incrementally later? I guess from the
cvsimport code that it just tries to always import everything but the
already imported commits get the same hashes so it magically imports
"incrementally"... (The code could use some descriptive comments, it is
rather spaggetish.)

If someone really desperately needs this, BTW, you might be able to
merge two Monotone branches (.git and .cvssync) to get two-way
incremental GIT and CVS interface, and then do that through Monotone.
;-))

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
