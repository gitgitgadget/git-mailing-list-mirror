From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Branch relationships
Date: Mon, 15 May 2006 03:48:53 +0200
Message-ID: <200605150348.53879.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org> <200605150104.46762.Josef.Weidendorfer@gmx.de> <7vslncyxez.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 03:49:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfSD1-0004U8-Ah
	for gcvg-git@gmane.org; Mon, 15 May 2006 03:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWEOBtP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 21:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWEOBtO
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 21:49:14 -0400
Received: from mail.gmx.de ([213.165.64.20]:24463 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751377AbWEOBtO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 21:49:14 -0400
Received: (qmail invoked by alias); 15 May 2006 01:49:12 -0000
Received: from p5496C0FC.dip0.t-ipconnect.de (EHLO noname) [84.150.192.252]
  by mail.gmx.net (mp039) with SMTP; 15 May 2006 03:49:12 +0200
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
In-Reply-To: <7vslncyxez.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20003>

On Monday 15 May 2006 01:55, you wrote:
> > After a "git clone", we would have
> >
> >  [remote "origin"]
> >    url = ...
> >    fetch = master:origin
> >
> >  [branch "master"]
> >    origin = "origin" ; upstream of master is local branch "origin"
> 
> Doesn't that arrangement force people to use tracking branches?

I think we already had the same discussion some time ago ;-)
This asks for support of a way to specify a remote origin branch
without any local tracking, like
  origin = "<remotebranch> of <remote>"

But not supporting this in a first step should be no problem, as
you always can do "git pull somewhere that-head" directly.

A side-effect of the origin-arrangement would be that branching
off a tracking branch would automatically update it on pull from
the new branch. I would see this as improvement of usability as
"generating a local development branch from a remote one" does
not need any special command.
