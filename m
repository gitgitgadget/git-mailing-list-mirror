From: Greg KH <greg@kroah.com>
Subject: Re: GIT Web Interface
Date: Tue, 19 Apr 2005 10:41:19 -0700
Message-ID: <20050419174119.GA22145@kroah.com>
References: <20050419004415.GA10628@vrfy.org> <20050419005244.GR5554@pasky.ji.cz> <1113926385.29953.7.camel@localhost.localdomain> <20050419165247.GB32259@kroah.com> <20050419173242.GA32478@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 19:38:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNwfi-0006Mj-Lj
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 19:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVDSRmF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 13:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVDSRmF
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 13:42:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:29895 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261469AbVDSRlp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 13:41:45 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3JHffi18634;
	Tue, 19 Apr 2005 10:41:41 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DNwit-6BG-00; Tue, 19 Apr 2005 10:41:19 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
In-Reply-To: <20050419173242.GA32478@vrfy.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 07:32:42PM +0200, Kay Sievers wrote:
> On Tue, Apr 19, 2005 at 09:52:48AM -0700, Greg KH wrote:
> > On Tue, Apr 19, 2005 at 05:59:45PM +0200, Kay Sievers wrote:
> > > On Tue, 2005-04-19 at 02:52 +0200, Petr Baudis wrote:
> > > > Dear diary, on Tue, Apr 19, 2005 at 02:44:15AM CEST, I got a letter
> > > > where Kay Sievers <kay.sievers@vrfy.org> told me that...
> > > > > I'm hacking on a simple web interface, cause I missed the bkweb too much.
> > > > > It can't do much more than browse through the source tree and show the
> > > > > log now, but that should change... :)
> > > > >   http://ehlo.org/~kay/gitweb.pl?project=linux-2.6
> > > > 
> > > > Hmm, looks nice for a start. (But you have obsolete git-pasky tree there! ;-)
> > > 
> > > Yeah, it's fresh now. :)
> > > 
> > > > > How can I get the files touched with a changeset and the corresponding
> > > > > diffs belonging to it?
> > > > 
> > > > diff-tree to get the list of files, you can do the corresponding diffs
> > > > e.g. by doing git diff -r tree1:tree2. Preferably make a patch for it
> > > > first to make it possible to diff individual files this way.
> > > 
> > > Ah, nice! Got it working.
> > 
> > Looks good, care to post the updated version?
> 
> Sure, but expect it to change dramatically tonight. :)

Ok, how about putting a link to it somewhere then, so you don't have to
be bothered with people like me asking for the latest copy? :)

thanks,

greg k-h
