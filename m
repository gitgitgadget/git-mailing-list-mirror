From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: undoing changes with git-checkout -f
Date: Tue, 10 Jan 2006 18:32:20 +0100
Message-ID: <81b0412b0601100932v2466151epe44f4c09b18dcc1c@mail.gmail.com>
References: <43C2D2C4.2010904@cc.jyu.fi>
	 <7vmzi5hy69.fsf@assigned-by-dhcp.cox.net>
	 <20060110045533.GO18439@ca-server1.us.oracle.com>
	 <Pine.LNX.4.63.0601101549360.26054@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0601100817h2a288a4ag337c749857f2c7fc@mail.gmail.com>
	 <Pine.LNX.4.63.0601101743180.26542@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 18:36:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwNNp-0005m1-Ty
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 18:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800AbWAJRdZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 12:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932803AbWAJRdZ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 12:33:25 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:64186 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932800AbWAJRdY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 12:33:24 -0500
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.200])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k0AHXMuR028007
	for <git@vger.kernel.org>; Tue, 10 Jan 2006 09:33:23 -0800
Received: by nproxy.gmail.com with SMTP id x29so174295nfb
        for <git@vger.kernel.org>; Tue, 10 Jan 2006 09:32:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fIPMvVEGgyjZ43LjAmhoK3vGuVosJkI1xbga3OXXsgVlAK6BnEFZk+goBrXG71TUdfJwh/PWgGqICYKlnDINlkBO1l/DySwhEsySyxshihXzH8BnoN3E7+iLK9DP5vI1OZId2z04Y6Cvms7l7CAWVHOkOC3wlhZhAsa23//vYs0=
Received: by 10.48.30.19 with SMTP id d19mr1012659nfd;
        Tue, 10 Jan 2006 09:32:21 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Tue, 10 Jan 2006 09:32:20 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601101743180.26542@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14430>

On 1/10/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > >       Can we teach the git:// fetch program to use CONNECT over HTTP
> > > > proxies?  rsync can do this, but git:// cannot, so firewalls that block
> > > > 9418 mean we use rsync://
> > >
> > > I think it is good and well with the proxy command support. Everybody can
> > > write a little script.
> > >
> > > Otherwise, where would it end? If you include http_proxy functionality in
> > > git, why not also https_proxy functionality? And if that, why not
> >
> > And, BTW, why not? It may as well stop here.
>
> Because it's not the purpose of git. It is the purpose of a tunnel. Let's
> not make the mistake of Microsoft here: integrate everything until
> everything breaks.

Of course, I do not propose to put the code into connect.c! Let it be
ip-tunnel.pl,
or something like that (which btw is really awkward to handle under a well-known
disabled OS).

But, it is not exactly standard tunnel, is it? I mean, can you use it
for something
else? If not, is there really a point _not_ to put it in the git
repository? As tunnel
script or program, or as an instruction file on how to setup a firewall?
