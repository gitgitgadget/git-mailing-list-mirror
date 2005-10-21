From: Petr Baudis <pasky@suse.cz>
Subject: Re: How do I clear the directory cache
Date: Fri, 21 Oct 2005 23:43:26 +0200
Message-ID: <20051021214326.GJ30889@pasky.or.cz>
References: <2b05065b0510170720n5333f03l1941e84c1288fc5d@mail.gmail.com> <20051020085931.GW30889@pasky.or.cz> <2b05065b0510202023i62ab7c03uea1381d76535dcc7@mail.gmail.com> <20051021105235.GF30889@pasky.or.cz> <2b05065b0510211340y9551767i53fe53c0dc14460a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 23:43:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET4fk-0008DI-6F
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 23:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVJUVn3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 17:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVJUVn3
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 17:43:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23201 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751232AbVJUVn2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 17:43:28 -0400
Received: (qmail 14677 invoked by uid 2001); 21 Oct 2005 23:43:26 +0200
To: eschvoca <eschvoca@gmail.com>
Content-Disposition: inline
In-Reply-To: <2b05065b0510211340y9551767i53fe53c0dc14460a@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10451>

Dear diary, on Fri, Oct 21, 2005 at 10:40:07PM CEST, I got a letter
where eschvoca <eschvoca@gmail.com> told me that...
> On 10/21/05, Petr Baudis <pasky@suse.cz> wrote:
> > Dear diary, on Fri, Oct 21, 2005 at 05:23:28AM CEST, I got a letter
> > where eschvoca <eschvoca@gmail.com> told me that...
> > > cg-status -<status_flag>  # list files with given status flag (without
> > > status flag in column 1)
> > >   git-ls-files [--others|--deleted|etc] --exclude-per-directory=/.gitignore
> >
> > All right, this might be useful. Implemented as cg-status -s '?' and such,
> > thanks for the idea.
> 
> This is great but it would be easier to work with if there was another
> switch to turn off printing
> out the status flag.  Otherwise you have to 'sed' or 'awk' out the
> status flag which is a pain, especially when files have spaces in
> them.

Not such a huge pain, but if we already have -s... I added -n which does
what you want.

> Also, the "cg-add -r" exits when a file is bad.  It would have saved
> me a few hours if it would keep not exit on a failure (and add the bad
> files to .gitignore ... but that is probably asking for too much).

I don't like the idea of adding the files automagically to .gitignore,
but it won't abort the whole operation because of them anymore.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
