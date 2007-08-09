From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-filter-branch
Date: Thu, 9 Aug 2007 10:38:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708091037220.21857@racer.site>
References: <20070809063453.GA12602@glandium.org> <Pine.LNX.4.64.0708090954550.21857@racer.site>
 <20070809091550.GB20321@glandium.org> <Pine.LNX.4.64.0708091018340.21857@racer.site>
 <20070809093051.GA21458@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 11:38:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ4Tn-0008Eg-SU
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 11:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761059AbXHIJix (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 05:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760482AbXHIJiw
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 05:38:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:37306 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753021AbXHIJiw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 05:38:52 -0400
Received: (qmail invoked by alias); 09 Aug 2007 09:38:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 09 Aug 2007 11:38:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18j8RQ4EdgjmRXDLKkZa3/CDsW3GQM9SuD5eNCbkR
	ipxtVRlDWv0tRf
X-X-Sender: gene099@racer.site
In-Reply-To: <20070809093051.GA21458@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55439>

Hi,

On Thu, 9 Aug 2007, Mike Hommey wrote:

> On Thu, Aug 09, 2007 at 10:19:20AM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > In the description in the manpage:
> > >    Lets you rewrite git revision history by creating a new branch from
> > >    your current branch, applying custom filters on each revision.
> > >    (...)
> > >    The command takes the new branch name as a mandatory argument and the
> > >    filters as optional arguments
> > > 
> > > And in example:
> > >    Now, you will get the rewritten history saved in the branch newbranch
> > >    (your current branch is left untouched).
> > > 
> > > I must say this is a feature that would actually be nice to have...
> > 
> > To compare with the old one?  Use reflogs:
> > 
> > 	git filter-branch --some-option master
> > 	git diff master@{1}..master
> 
> To have, for example, a branch tracking an upstream (svn or whatever)
> repository and have a branch based on it, only differing in the fact that
> some directories get removed.

You can always achieve the same effect by

	$ git branch new-branch master
	$ git filter-branch <options> master

Anyway, I'm off for a few days.

Ciao,
Dscho
