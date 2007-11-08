From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull opinion
Date: Thu, 8 Nov 2007 15:27:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711081525460.4362@racer.site>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com> 
 <7vd4uomfn8.fsf@gitster.siamese.dyndns.org>  <18223.46848.109961.552827@lisa.zopyra.com>
  <3abd05a90711052230y4d6151c6o3e7985a0c8e18161@mail.gmail.com> 
 <alpine.LFD.0.999.0711060812170.15101@woody.linux-foundation.org>
 <3abd05a90711071325y397434efq7d4e50cb7a1cf07e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:28:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq9Il-0003x7-8a
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 16:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758746AbXKHP11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 10:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756196AbXKHP11
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 10:27:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:40701 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754234AbXKHP10 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 10:27:26 -0500
Received: (qmail invoked by alias); 08 Nov 2007 15:27:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 08 Nov 2007 16:27:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+U72U8IMKU/2b17WQhuDIeB/K7R56Fvo3ffOKmPb
	FXG7iO0FNPhxQX
X-X-Sender: gene099@racer.site
In-Reply-To: <3abd05a90711071325y397434efq7d4e50cb7a1cf07e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64042>

Hi,

On Wed, 7 Nov 2007, Aghiles wrote:

> On 11/6/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > Now, I do think that we could relax the rule so that "files that are 
> > modified must be clean in the working tree" could instead become 
> > "files that actually don't merge _trivially_ must be clean in the 
> > working tree". But basically, if it's not a trivial merge, then since 
> > it's done in the working tree, the working tree has to be clean (or 
> > the merge would overwrite it).
> 
> I really think this is a good idea. It seems to me that the first "bad"
> surprise a svn/cvs/bk user will have is the result of a "git pull" command
> on a dirty tree. With the proposed change, and if I understand correctly:
>   - users that are used to commit often and fetch into clean trees
> will never be bothered by this change.
>   - users that are used to "update" often are expecting to resolve
> conflicts in their working copy anyway.

But the latter ones will likely not understand why all of a sudden their 
working tree has to be clean sometimes (when there was no trivial 
merge possible).

Besides, I think it is not trivial to implement.

Not my itch,
Dscho
