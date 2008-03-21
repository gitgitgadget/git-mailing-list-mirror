From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: How to find where a branch was taken from.
Date: Fri, 21 Mar 2008 16:22:11 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803211618150.19665@iabervon.org>
References: <47E37A63.9070209@glidos.net>  <7v4pb0qw28.fsf@gitster.siamese.dyndns.org>  <32541b130803211039h1f5b8da5k8fb353d46e57b05e@mail.gmail.com>  <20080321183225.GA13583@hashpling.org>  <32541b130803211148r651d03eev98a478b13e69f710@mail.gmail.com>
 <37fcd2780803211303r1a247739na79e78c609565010@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Charles Bailey <charles@hashpling.org>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Gardiner <osronline@glidos.net>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 21:23:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcnll-0006fo-Ba
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 21:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761260AbYCUUWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 16:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761125AbYCUUWR
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 16:22:17 -0400
Received: from iabervon.org ([66.92.72.58]:55388 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755681AbYCUUWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 16:22:16 -0400
Received: (qmail 15551 invoked by uid 1000); 21 Mar 2008 20:22:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Mar 2008 20:22:11 -0000
In-Reply-To: <37fcd2780803211303r1a247739na79e78c609565010@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77765>

On Fri, 21 Mar 2008, Dmitry Potapov wrote:

> On Fri, Mar 21, 2008 at 9:48 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> >
> >  "git show-branch" has logic very close to what we need here: if you
> >  give it the names of your current branch and its parent, it'll show
> >  you just the changes on both branches since the branchpoint.  But I
> >  don't really want to know about additional changes on the parent, only
> >  on the branch I'm working with, and I often prefer the output to be in
> >  git-log's (very flexible) format instead of git-show-branch.
> 
> I believe that
> 
>    git log parent-branch..local-branch
> 
> should give you exactly what you want, i.e. all changes on your local
> branch since it was copied from the parent branch.

Then you need to remember what the parent branch was. But:

  git log local-branch ^maybe-parent-1 ^maybe-parent-2 ...

should give you what you want.

	-Daniel
*This .sig left intentionally blank*
