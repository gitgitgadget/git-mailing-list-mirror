From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git rebase to move a batch of patches onto the current branch
Date: Fri, 25 Jul 2008 15:16:11 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0807251509390.19665@iabervon.org>
References: <32541b130807241257j7820a591if8ca01c66bbcd6b2@mail.gmail.com>  <20080724201333.GA3760@blimp.local>  <32541b130807241316x4f85bcdfw12857be575fb3289@mail.gmail.com>  <20080724203049.GC3760@blimp.local>
 <32541b130807241342h483169d7we955512879075161@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:17:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMSmw-00035B-AW
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 21:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939AbYGYTQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 15:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755709AbYGYTQN
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 15:16:13 -0400
Received: from iabervon.org ([66.92.72.58]:53587 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019AbYGYTQM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 15:16:12 -0400
Received: (qmail 31084 invoked by uid 1000); 25 Jul 2008 19:16:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jul 2008 19:16:11 -0000
In-Reply-To: <32541b130807241342h483169d7we955512879075161@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90090>

On Thu, 24 Jul 2008, Avery Pennarun wrote:

> On 7/24/08, Alex Riesen <raa.lkml@gmail.com> wrote:
> > Avery Pennarun, Thu, Jul 24, 2008 22:16:06 +0200:
> > > On 7/24/08, Alex Riesen <raa.lkml@gmail.com> wrote:
> >
> > > >     gcp3 ()
> >  > >     {
> >  > >         git format-patch -k --stdout --full-index "$@" | git am -k -3 --binary
> >  > >     }
> >  >
> >  > But that'll give up when there are conflicts, right?  git-rebase lets
> >  > me fix them in a nice way.
> >
> > No, it same as in rebase. You'll fix them and do "git am --resolved".
> >  See manpage of git am.
> 
> Hmm, cool.
> 
> So that command isn't too easy to come upon by accident.  If I wanted
> to submit a patch to make this process a bit more obvious, would it
> make sense to simply have git-cherry-pick call that sequence when you
> give it more than one commit?

Before terribly long, we'll have "git sequencer", which should be easy to 
get to do the "rebase -i" thing with cherry-pick-style usage (somebody 
would just need to write code to generate the correct series of pick 
statements).

	-Daniel
*This .sig left intentionally blank*
