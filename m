From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Call Me Gitless
Date: Mon, 18 Aug 2008 20:32:32 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808182027240.19665@iabervon.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>  <alpine.LNX.1.00.0808181512160.19665@iabervon.org>  <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 02:33:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVFAV-0000rY-DG
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 02:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbYHSAcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 20:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754540AbYHSAce
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 20:32:34 -0400
Received: from iabervon.org ([66.92.72.58]:59250 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754344AbYHSAce (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 20:32:34 -0400
Received: (qmail 3092 invoked by uid 1000); 19 Aug 2008 00:32:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Aug 2008 00:32:32 -0000
In-Reply-To: <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92794>

On Mon, 18 Aug 2008, Tarmigan wrote:

> On Mon, Aug 18, 2008 at 1:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > (2) Some concepts in git are different from what they are used to, without
> >    any good reason.  IOW, the concepts have room for improvement, and our
> >    UI is based on these faulty concepts.
> >
> > (3) Some concepts in git may be exactly the same with other systems, yet
> >    our UI may operate differently from them without any good reason.
> 
> One confusing part of the porcelain may be the way that git's revert
> is different from other systems' revert.  What would people think
> about something like this somewhere in git-revert(1)?
> 
> +DISCUSSION
> +----------
> +If you are more familiar with another SCM, 'git revert' may not do what you
> +expect.  Specifically, if you want to throw away all changes in your working
> +directory, you should read the man page for 'git reset', particulary the
> +'--hard' option.  If you want to extract specific files as they were in a
> +previous commit, you should read the man page for 'git checkout -- <filename>'.

"as they were in a particular commit"; it works for the current commit as 
well as older ones. And skip the first sentence; even people who aren't 
familiar with another SCM are reasonably likely to be attracted by the 
name "revert" as being descriptive of what they want to do.

I think this is a good idea, although clever placement is necessary to 
neither distract people who really do want "revert" nor get missed by 
people who are looking in the wrong place.

	-Daniel
*This .sig left intentionally blank*
