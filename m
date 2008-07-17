From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 15:00:28 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0807171438430.19665@iabervon.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com> <alpine.DEB.1.00.0807161902400.8986@racer> <32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com> <alpine.LNX.1.00.0807161605550.19665@iabervon.org>
 <861w1sn4id.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 21:01:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJYjN-0004tZ-IC
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 21:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757881AbYGQTAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 15:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755050AbYGQTAb
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 15:00:31 -0400
Received: from iabervon.org ([66.92.72.58]:55759 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760851AbYGQTA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 15:00:29 -0400
Received: (qmail 24663 invoked by uid 1000); 17 Jul 2008 19:00:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Jul 2008 19:00:28 -0000
In-Reply-To: <861w1sn4id.fsf@lola.quinscape.zz>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88903>

On Thu, 17 Jul 2008, David Kastrup wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > You're simply wrong. A ref isn't a name for a commit (the point of
> > having a ref is that it doesn't persist in naming the same commit). A
> > commit isn't a blob. If you start telling people complicated and wrong
> > things, they're surely going to be confused.
> >
> > Git maintains history as a directed graph, with each commit pointing
> > back at its history. Refs are the what holds the newest commits that
> > nothing else points back to. If directed graphs aren't in your users'
> > experience, you can put it this way: git maintains history like
> > knitting, where each new stitch holds on to one or more previous
> > stitches, and refs are the knitting needles that hold the ends where
> > you're working (except that knitting is a lot wider than software
> > development). gitk --all even provides the diagram you want to explain
> > it.
> 
> Complicated and right things are not much less confusing...
> 
> > SVN branches are incredible confusing because they fail to distinguish
> > the directory structure of the project's source tree from the
> > arrangement of available latest versions.
> 
> That is because there _is_ no difference.  You just store different
> versions in different places.  What they are named is a convention,
> nothing more, nothing less.

No, there's a difference. When you get a tarball of a project that uses 
SVN, the root of the tarball isn't the root of the repository. It's the 
root of some directory within the repository. And if you ask for a tarball 
of some branch, it's from some different directory in the repository. 
Projects are not at all unaware that there are particular subdirectories 
in the repository structure which contain roots of versions, and above 
that, the directory structure doesn't refer to the structure of a project 
snapshot.

Because SVN lacks a vital concept (graph-structured history), it uses the 
same implementation for two qualitatively different concepts. This is 
extremely confusing, and much more confusing than having a clean 
separation between the two concepts like git does.

	-Daniel
*This .sig left intentionally blank*
