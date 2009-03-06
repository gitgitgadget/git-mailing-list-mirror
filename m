From: Josef Wolf <jw@raven.inka.de>
Subject: Re: git-svn and repository hierarchy?
Date: Fri, 6 Mar 2009 18:57:24 +0100
Message-ID: <20090306175724.GB14554@raven.wolf.lan>
References: <20090303185108.GA11278@raven.wolf.lan> <eaa105840903031135o4cf72ed0oe3fffed69cb7ce03@mail.gmail.com> <20090303223600.GB11278@raven.wolf.lan> <eaa105840903031618s5e0b6f24j64aade8d752fb11@mail.gmail.com> <20090304192752.GC11278@raven.wolf.lan> <eaa105840903041406k36088763w5a70fe1d7458dfb1@mail.gmail.com> <20090305180529.GD11278@raven.wolf.lan> <eaa105840903051148s3515e8b7x9d7b8f9be12da735@mail.gmail.com> <20090306161026.GA14554@raven.wolf.lan> <eaa105840903060858g5b8f31bpb9a59d563835a9d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 19:01:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfeMn-0002Av-2Q
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 19:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbZCFSAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 13:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbZCFSAP
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 13:00:15 -0500
Received: from quechua.inka.de ([193.197.184.2]:44878 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996AbZCFSAO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 13:00:14 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LfeLD-0001ic-V0; Fri, 06 Mar 2009 19:00:11 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 65C3B2C90B; Fri,  6 Mar 2009 18:57:24 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <eaa105840903060858g5b8f31bpb9a59d563835a9d5@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112473>

On Fri, Mar 06, 2009 at 11:58:36AM -0500, Peter Harris wrote:
> On Fri, Mar 6, 2009 at 11:10 AM, Josef Wolf wrote:
> > On Thu, Mar 05, 2009 at 02:48:14PM -0500, Peter Harris wrote:
> >>
> >> True, but in my experience it happens considerably less often with
> >> git. I find and fix most of my typos when reviewing my change-set
> >> before doing a "git push" or "git svn dcommit".
> >
> > So you are rewriting yourself but not accept rewrites by svn ;-)
> 
> No, I am not rewriting myself *after I publish*. I see the smiley, but
> I think you missed the point.
> 
> "git push" or "svn ci" is the end of the rewrites.

I see.  Thanks for the clarification!

> >> Indeed. Or even not-so-random names, such as cloneX/topic-name if you
> >> prefer.
> >
> > That would have the risk of multiple clones pushing to the same branch.
> 
> Only if cloneX pushes to cloneY/topic-name. Does each clone not have a
> unique name?

I'd rather not rely on the clones having unique names.

> > Does that look sane?
> 
> No. But it doesn't look any more insane than any other workflow
> involving Subversion that I can think of. :-)

OK, I parse that as "there's not much room for improvement" :-)

Thanks for your great help!  I have learned a lot in this thread!
