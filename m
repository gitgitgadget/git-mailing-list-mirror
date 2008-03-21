From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: How to find where a branch was taken from.
Date: Fri, 21 Mar 2008 16:25:05 -0400
Message-ID: <20080321202505.GG29086@fieldses.org>
References: <47E37A63.9070209@glidos.net> <7v4pb0qw28.fsf@gitster.siamese.dyndns.org> <32541b130803211039h1f5b8da5k8fb353d46e57b05e@mail.gmail.com> <20080321183225.GA13583@hashpling.org> <32541b130803211148r651d03eev98a478b13e69f710@mail.gmail.com> <37fcd2780803211303r1a247739na79e78c609565010@mail.gmail.com> <alpine.LNX.1.00.0803211618150.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Charles Bailey <charles@hashpling.org>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Gardiner <osronline@glidos.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 21:26:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcnoa-0007ju-S0
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 21:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbYCUUZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 16:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754554AbYCUUZb
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 16:25:31 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54879 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741AbYCUUZa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 16:25:30 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1JcnnV-0005Er-By; Fri, 21 Mar 2008 16:25:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0803211618150.19665@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77766>

On Fri, Mar 21, 2008 at 04:22:11PM -0400, Daniel Barkalow wrote:
> On Fri, 21 Mar 2008, Dmitry Potapov wrote:
> 
> > On Fri, Mar 21, 2008 at 9:48 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> > >
> > >  "git show-branch" has logic very close to what we need here: if you
> > >  give it the names of your current branch and its parent, it'll show
> > >  you just the changes on both branches since the branchpoint.  But I
> > >  don't really want to know about additional changes on the parent, only
> > >  on the branch I'm working with, and I often prefer the output to be in
> > >  git-log's (very flexible) format instead of git-show-branch.
> > 
> > I believe that
> > 
> >    git log parent-branch..local-branch
> > 
> > should give you exactly what you want, i.e. all changes on your local
> > branch since it was copied from the parent branch.
> 
> Then you need to remember what the parent branch was. But:
> 
>   git log local-branch ^maybe-parent-1 ^maybe-parent-2 ...
> 
> should give you what you want.

http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#showing-commits-unique-to-a-branch

also has a couple amusing examples along these lines.

--b.
