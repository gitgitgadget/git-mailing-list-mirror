From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Git wiki
Date: Wed, 3 May 2006 10:06:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605030958370.4086@g5.osdl.org>
References: <20060502232553.GL27689@pasky.or.cz> <7virooj92i.fsf@assigned-by-dhcp.cox.net>
 <4d8e3fd30605030139k33c5a404k54861fdd02c87134@mail.gmail.com>
 <20060503090007.GM27689@pasky.or.cz> <4d8e3fd30605030213r625ce87fw5cbee554f1c20fbd@mail.gmail.com>
 <Pine.LNX.4.64.0605030934220.28543@localhost.localdomain>
 <20060503142957.GA9056@spearce.org> <4458C5D7.8010501@op5.se>
 <Pine.LNX.4.64.0605030817580.4086@g5.osdl.org> <20060503164732.GB9820@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Shawn Pearce <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 19:07:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbKoL-0000MX-KI
	for gcvg-git@gmane.org; Wed, 03 May 2006 19:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWECRGp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 13:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWECRGp
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 13:06:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12266 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030253AbWECRGo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 13:06:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k43H6RtH007952
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 May 2006 10:06:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k43H6P8r007288;
	Wed, 3 May 2006 10:06:26 -0700
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <20060503164732.GB9820@thunk.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19502>



On Wed, 3 May 2006, Theodore Tso wrote:
> 
> Of course, a lot of it is that git *is* much more powerful, much like
> the difference between a stickshift with a racing clutch (git) and a
> car with an automatic transmission (hg).

I don't think that's necessarily a good comparison.

The "easy things" are easy even with git. Our explanation pages and 
tutorials just tend to want to show off, and do more than they need to. 

Even the "everyday git in 20 commands" actually starts out scaring people 
with listing commands that they don't need to know about immediately. The 
whole fsck/count-object/pruning thing shouldn't even be mentioned until 
after you've shown how easy it is to just do

	git init-db
	git add .
	git commit -a

to import an old project, and then do an example commit or something 
(one of the early examples).

So yeah. We should have a main page that starts off with the "everyday 
git" link (preferably further simplified) very prominently, and just looks 
less scary.

People are probably already expecting the worst - partly because git is 
newer than some of the other projects (not hg, but svn/svk/monotone etc), 
and partly because I was actively trying to not over-promise or over-sell 
early on when it wasn't clear how good git was going to get..

So looking pretty and easy to use is clearly important, and I think git 
has the _capability_ for that, we've not just documented it that way.

			Linus
