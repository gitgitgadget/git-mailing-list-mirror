From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Merging to and from non-current branches.
Date: Thu, 6 Aug 2009 13:41:58 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908061320030.2147@iabervon.org>
References: <D5200130-C7D7-4010-BF62-3A3374F2E3B0@mgreg.com> <alpine.LNX.2.00.0908042236240.2147@iabervon.org> <518952FC-626C-43FB-BD53-98DE849C9751@mgreg.com> <81b0412b0908051428g40b7678ewc549f079abbd03ee@mail.gmail.com>
 <C766A4F9-C12B-4F94-8B24-9BD3665B70E8@mgreg.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: "lists@mgreg.com" <lists@mgreg.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 19:42:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ6yd-0000uo-Sj
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 19:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437AbZHFRl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 13:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756361AbZHFRl6
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 13:41:58 -0400
Received: from iabervon.org ([66.92.72.58]:51961 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755924AbZHFRl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 13:41:58 -0400
Received: (qmail 11474 invoked by uid 1000); 6 Aug 2009 17:41:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Aug 2009 17:41:58 -0000
In-Reply-To: <C766A4F9-C12B-4F94-8B24-9BD3665B70E8@mgreg.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125100>

On Wed, 5 Aug 2009, lists@mgreg.com wrote:

> 
> On Aug 5, 2009, at 5:28 PM, Alex Riesen wrote:
> 
> >On Wed, Aug 5, 2009 at 04:48, lists@mgreg.com<lists@mgreg.com> wrote:
> > >I appreciate your post.  I understand what you're saying, and I'm not so
> > >much concerned about the logistics of what need to occur so much as a
> > >single
> > >command to intuitively handle it.  I've been doing a great deal of
> > >incremental development lately and it becomes rather tedious to have to
> > >checkout master, merge dev, re-checkout dev and proceed.  I'm not sure why
> > >this isn't currently possible with a single command.
> >
> >Because no one needed this sequence of commands for long enough.
> 
> As I said, I understand what is being said, but in IMHO it would seem that a
> merge of that nature would be immediately desirable.  Think of it more as a
> local "push".

You mean like "git push . dev:master"? That does work in the case where a 
content merge is not required (although not otherwise).

	-Daniel
*This .sig left intentionally blank*
