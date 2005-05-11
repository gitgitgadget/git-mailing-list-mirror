From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Core and Not-So Core
Date: Wed, 11 May 2005 13:02:19 +1000
Message-ID: <2cfc403205051020023e84ec7b@mail.gmail.com>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
	 <20050510225235.GD26384@pasky.ji.cz>
	 <2cfc403205051017505b57da72@mail.gmail.com>
	 <Pine.LNX.4.62.0505102226020.5426@localhost.localdomain>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 11 04:55:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVhNU-0005BZ-EC
	for gcvg-git@gmane.org; Wed, 11 May 2005 04:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVEKDC3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 23:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVEKDC3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 23:02:29 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:30524 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261891AbVEKDCU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 23:02:20 -0400
Received: by rproxy.gmail.com with SMTP id j1so31418rnf
        for <git@vger.kernel.org>; Tue, 10 May 2005 20:02:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EGqVSZxofEeXlL9dHIZXxSLQZn78/ZJIngqHRgDds7GUpbQTiDjOgktOE4nt4ypvcX6PdNR9LXfZOiARB4rgZJVKPcCbqnFfGAQ1zD2Nq0W3rhjtubp5LClaSN3BLuIfh4ydT8PTKAUymvPwQnUyG6vlTcmi3tvxdbN+djWBvAQ=
Received: by 10.39.3.79 with SMTP id f79mr173982rni;
        Tue, 10 May 2005 20:02:19 -0700 (PDT)
Received: by 10.38.104.59 with HTTP; Tue, 10 May 2005 20:02:19 -0700 (PDT)
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0505102226020.5426@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/11/05, Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 11 May 2005, Jon Seymour wrote:
> > I agree in principle, though I'd like users to be able to easily
> > switch between the Eclipse and git tools view of the workspace if they
> > want to - who am I to say how a user should work? Eclipse does this
> > kind of thing quite well with CVS precisely because it shares the
> > workspace structures with the CVS command line tools rather than
> > "re-inventing" the wheel.
> 
> In this case you just need to manage to use the current index format
> somehow.
> 
> Honestly I don't think Linus might be interested into changing the index
> format just to make a Java implementation happier.  So your best bet is
> probably to use it as is or ignore it entirely.
> 

Agreed - I am not proposing a change to the index format, merely
highlighting that the index format is closely bound to the
workspace-oriented toolset and that the workspace-oriented toolset is
distinct from the repository-oriented toolset; different
workspace-oriented toolsets will have different requirements for their
index files and so their index files might quite rightly differ in
both form and substance.

That said, their is no harm making my set of tools interoperable with
the git tools, where that is possible so that the user can decide to
use which ever toolset fits the job immediately at hand. With this in
mind, a published specification of the index format would help, but I
am not going insist on that. I am certainly not going to ask for
changes to it! Life is too short :-)

jon.
