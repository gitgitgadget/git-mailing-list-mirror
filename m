From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 14:57:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606091450180.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> 
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> 
 <9e4733910606091113vdc6ab06l2d3582cb82b8fd09@mail.gmail.com> 
 <Pine.LNX.4.64.0606091158460.5498@g5.osdl.org> 
 <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com> 
 <Pine.LNX.4.64.0606091331170.5498@g5.osdl.org>
 <9e4733910606091356w391b4fdao23db5b2ce3c3e282@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 23:58:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoozY-000248-3a
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 23:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030550AbWFIV6E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 17:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030551AbWFIV6E
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 17:58:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42182 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030550AbWFIV6C (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 17:58:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k59Lvxgt001923
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 14:57:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k59LvwSR031947;
	Fri, 9 Jun 2006 14:57:58 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606091356w391b4fdao23db5b2ce3c3e282@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21564>



On Fri, 9 Jun 2006, Jon Smirl wrote:
> 
> They need the distributed thing whether they realize it or not. Some
> of the external projects like songbird and nvu are vulnerable to drift
> since they are running their own repositories.  Once a  few
> move/renames happen they can't easily stay in sync anymore. It has
> been over a year since NVU was merged back into the trunk.
> 
> That is the same reason I want it, so that I can work on stuff locally
> and have a repository. The core staff doesn't have this problem
> because they can make all the branches they want in the main
> repository.

Yes. Anyway, I think we'll get git working well for repositories that 
size, and eventually the core developers will notice how much better it 
is.

In the meantime, the fact that git-cvsimport can be done incrementally 
means that once we have the silly pack-file-mapping details worked out, it 
should be perfectly fine to run the 3-day import just once, and then work 
on it incrementally afterwards without any real problems.

So people like you who want to work on it off-line using a distributed 
system _can_ do so, realistically. Maybe not practically _today_, but I 
don't think the git issues are serious enough that we'd be talking about 
"months from now", but more of a "in a week or so we migh have something 
that works fine for your case".

[ They had this long discussion about languages on #monotone the other 
  day, and the reason I'll take C over anything else any day is the fact 
  that a well-written C program is literally only limited by hardware, 
  never by the language. The poor python/perl guys may write things more 
  quickly, but when they hit a language wall, they hit it. 

  I think we've got an excellent data model, and handling even something 
  huge like the _whole_ history of mozilla doesn't look very daunting at 
  all. I just want to have a real test-case to motivate me to look at the 
  problems. ]

> It would be better to rsync Martins copy, he has a lot more bandwidth.
> It will take over a day to copy it off my cable modem. I'm signed up
> to get FIOS as soon as they turn it on in my neighborhood, it's
> already wired on the poles.

Sure. I actually just have regular 128kbps DSL myself. I guess I should 
upgrade to 256 (the downside of having deer munching on the roses in our 
back yard is that I don't think I even have the option for anything 
faster), but I'm so damn well distributed that the slow 128kbps is 
actually more than enough - everything serious I do is local anyway.

So it will take me quite some time to download 2GB+, regardless of how fat 
a pipe the other end has ;)

		Linus
