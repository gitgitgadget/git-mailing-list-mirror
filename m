From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-svn strangeness with tags and Squirrelmail repo
Date: Wed, 20 Jun 2007 12:33:17 +0200
Message-ID: <20070620103317.GF12089@xp.machine.xx>
References: <46a038f90706192205y71a77f5al5ca199b3ac382d71@mail.gmail.com> <20070620072446.GC25010@muzzle> <46a038f90706200213p2d1e3ba3nf58107584afe4901@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 12:33:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0xUj-0004S1-IF
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 12:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731AbXFTKdA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 06:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754265AbXFTKdA
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 06:33:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:39969 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753531AbXFTKc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 06:32:59 -0400
Received: (qmail invoked by alias); 20 Jun 2007 10:32:58 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp028) with SMTP; 20 Jun 2007 12:32:58 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18+cp89gek+fmXAhhxDPDUORUkhlisfCSDqkWkgZQ
	ySIKVjADyUeA3H
Mail-Followup-To: Martin Langhoff <martin.langhoff@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46a038f90706200213p2d1e3ba3nf58107584afe4901@mail.gmail.com>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50556>

On Wed, Jun 20, 2007 at 09:13:18PM +1200, Martin Langhoff wrote:
[...]
> > >   [svn-remote "svn"]
> > >        url = http://squirrelmail.svn.sourceforge.net/svnroot/squirrelmail
> > >        fetch = trunk/squirrelmail:refs/heads/svn/trunk
> > >        branches = branches/*/squirrelmail:refs/heads/svn/*
> > >        tags = tags/*/squirrelmail:refs/tags/svn/*
> >
> > git-svn expects 'refs/remotes/' in the local ref name.  Otherwise,
> > the left-hand side is correct.
> 
>  Good to know!
> 
> > > and when I do that -- trunk and branches do what I want, but tags
> > > aren't imported anymore. :-/
> >
> > Now its odd to me that trunks and branches even works with those ref
> > names.
> 
>  I'm lucky then ;-)
> 
>  My reason for the "alternative" locations is to match a bit better the
>  v1.5.0 behaviour re branches, tags and remotes, and to run the import
>  directly into a bare repo on git.catalyst.net.nz
> 
>  - Tags, by virtue of landing under refs/remotes are being treated as
>  heads rather than tags. That's why I want to have them in
>  refs/tags/<bla>/*
> 

But Tags are just heads in SVN. There are many repos where a tag changes
in time and so tags are often used as they were branches where you
develop on.

>  - If branches + trunk end up in refs/remotes then my bare repo /
>  gateway doesn't work well - -refs/remotes aren't cloned or fetched
> 
>  - gitweb refuses to show those heads/tags (maybe it's because it's an
>  old version?)
> 
[ Not sure about this, but could it be that gitweb never shows branches
  under refs/remotes ? ]

-Peter
