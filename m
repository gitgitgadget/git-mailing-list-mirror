From: Ray Lehtiniemi <rayl@shawcable.com>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Tue, 18 Apr 2006 19:20:34 -0600
Message-ID: <200604181920.35223.rayl@shawcable.com>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
 <46a038f90604181714j6fce1867wc17952d898f8e7ae@mail.gmail.com>
 <20060419002159.GD8915@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 19 03:21:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW1Nz-0003iD-Ls
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 03:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWDSBVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 21:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWDSBVg
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 21:21:36 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:54579 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750931AbWDSBVg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 21:21:36 -0400
Received: from pd4mr6so.prod.shaw.ca (pd4mr6so-qfe3.prod.shaw.ca [10.0.141.69])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0IXY004NL3QBD110@l-daemon> for git@vger.kernel.org; Tue,
 18 Apr 2006 19:20:35 -0600 (MDT)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
 by pd4mr6so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0IXY005923QA2R70@pd4mr6so.prod.shaw.ca> for
 git@vger.kernel.org; Tue, 18 Apr 2006 19:20:34 -0600 (MDT)
Received: from s0106001109ed07db.cg.shawcable.net ([68.147.121.172])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0IXY00AY63QA0U20@l-daemon> for git@vger.kernel.org; Tue,
 18 Apr 2006 19:20:34 -0600 (MDT)
In-reply-to: <20060419002159.GD8915@spearce.org>
To: Shawn Pearce <spearce@spearce.org>
Content-disposition: inline
User-Agent: KMail/1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18898>


one more lightweight vote in favor....  such a feature would eliminate a few 
shell scripts i cobbled together which essentially allow me to say

  git diff 8a6352:path/to/module 5f3461:moved/and/hacked/copy


On Tuesday 18 April 2006 18:21, Shawn Pearce wrote:
> Not that my voice carries much weight, but a coworker has been
> asking for this feature to be added to pg for months.  I've just
> been too lazy to get around to writing the shell code to do it.
> Making it part of git cat-file seems like a good idea, making it
> usable by other tools like git diff just rocks.  :-)
>
> I think its a very worthwhile addition.
>
> Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > On 4/19/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > >   What do people think? Have you ever wanted to
> > >   access individual files in some random revision? Do you think this is
> > >   useful?
> >
> > Definitely, I've several times had to go through contortions to do
> > this easily, and I've ended up turning to gitweb often to quickly see
> > the state of a file at a given revision.
> >
> > > With this, you can do something like
> > >
> > >         git cat-file blob v1.2.4:Makefile
> > >
> > > to get the contents of "Makefile" at revision v1.2.4.
> > >
> > > Now, this isn't necessarily something you really need all that often,
> > > but the concept itself is actually pretty powerful. We could, for
> > > example, allow things like
> > >
> > >         git diff v0.99.6:git-commit-script..v1.3.0:git-commit.sh
> >
> > These two examples are more than enough -- I buy ;-)
