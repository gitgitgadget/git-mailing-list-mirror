From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-svn: failure to clone logcheck's repo
Date: Fri, 13 Jul 2007 11:56:20 +0200
Message-ID: <20070713095620.GC18199@xp.machine.xx>
References: <20070713093622.GA21001@lapse.madduck.net> <20070713094710.GB18199@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 11:55:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Hru-0003SD-Jl
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 11:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934929AbXGMJzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 05:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762139AbXGMJzJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 05:55:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:58473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761997AbXGMJzH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 05:55:07 -0400
Received: (qmail invoked by alias); 13 Jul 2007 09:55:05 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp018) with SMTP; 13 Jul 2007 11:55:05 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19cwHQy7LpcRABFeXBUr4w9s18JhOj6Wt5i5C0kxA
	1dweYP3ovt0iq+
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070713094710.GB18199@xp.machine.xx>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52377>

On Fri, Jul 13, 2007 at 11:47:10AM +0200, Peter Baumann wrote:
> On Fri, Jul 13, 2007 at 11:36:22AM +0200, martin f krafft wrote:
> > Hi list,
> > 
> > I am trying to access the logcheck repository with git-svn. Even
> > though I can happily clone the trunk:
> > 
> >   git-svn clone svn://svn.debian.org/svn/logcheck/logcheck/trunk git
> > 
> > as soon as I try to clone the entire thing with tags and branches:
> > 
> >   git-svn clone -T trunk -t tags -b branches
> >     svn://svn.debian.org/svn/logcheck/logcheck git
> > 
> > it barfs:
> > 
> >   Initialized empty Git repository in .git/
> >   Using higher level of URL: svn://svn.debian.org/svn/logcheck/logcheck => svn://svn.debian.org/svn/logcheck
> >   r19 = 95d0625b6c62935cfd3e44ec7dca5b6f6b05ab44 (trunk)
> >   [...]
> >   r20 = a3e5240dcc4d064b46273584800d3ae7a1e21330 (trunk)
> >   Found possible branch point: svn://svn.debian.org/svn/logcheck/logcheck/trunk => svn://svn.debian.org/svn/logcheck/logcheck/branches/VENDOR, 20
> >   Found branch parent: (VENDOR) a3e5240dcc4d064b46273584800d3ae7a1e21330
> >   Following parent with do_switch
> >   Successfully followed parent
> >   r21 = 0ffcb70923d77c1d24019362e1ed1cd18d05f235 (VENDOR)
> >   Malformed network data: Malformed network data at /usr/local/bin/git-svn line 1029
> > 
> > I think I'll be fine with *not* preserving logcheck's history when
> > I move it to git, but thought best to let you know since this may be
> > a bug in git-svn.
> > 
> 
> This is a known problem. If I remember correctly,it is save to just
> resume the import with git-svn fetch, and nothing bad should happen.
> 
> Just search the list archive for more info (sorry, I don't have a
> reference to the thread)

Just found it. Look e.g. here on the comment from Eric Wong:

http://thread.gmane.org/gmane.comp.version-control.git/50962/focus=275913

-Peter
