From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Mon, 25 Feb 2008 01:35:27 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802250130310.19024@iabervon.org>
References: <200802202203.m1KM37aR012221@mi1.bluebottle.com> <alpine.LSU.1.00.0802202221130.17164@racer.site> <7v4pc316gq.fsf@gitster.siamese.dyndns.org> <76718490802201726t677b1498ma3bdb3dbf25dd781@mail.gmail.com> <alpine.LFD.1.00.0802201735030.7833@woody.linux-foundation.org>
 <alpine.LNX.1.00.0802202351400.19024@iabervon.org> <7vk5kyyirk.fsf@gitster.siamese.dyndns.org> <7vwsotoey8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802242319200.19024@iabervon.org> <7vfxvho8r7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 07:36:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTWwv-0000sl-Ke
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 07:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbYBYGfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 01:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758655AbYBYGf3
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 01:35:29 -0500
Received: from iabervon.org ([66.92.72.58]:50608 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714AbYBYGf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 01:35:28 -0500
Received: (qmail 22669 invoked by uid 1000); 25 Feb 2008 06:35:27 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Feb 2008 06:35:27 -0000
In-Reply-To: <7vfxvho8r7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74994>

On Sun, 24 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Thanks; that's exactly what I would have done (assuming I didn't miss 
> > places like last time). Except that it should say that it's still 
> > undefined if you use:
> >
> >         [url "foo"]
> >                 insteadOf = "baz"
> >         [url "bar"]
> >                 insteadOf = "baz/sub"
> >
> > in that you can't predict whether "baz/sub/a" will be "bar/a" or 
> > "foo/sub/a". This is actually what I'm most concerned about, since there 
> > is actually a logical expectation (the one that matches more will be used 
> > in preference to the less specific one), but that's not implemented. 
> > Someday, we'll probably want to implement it, and that'll change the 
> > behavior of this particular case.
> 
> I'd say that that is a reasonable expectation, and it would be
> fair to say that if we have it, the topic will be in 1.5.5 and
> otherwise it won't.
> 
> This might be a bit over-engineered, but should do the job.

Very nice. And if we've got your over-engineered prefix-replacement code 
here, maybe I'll use it to also do the prefix-replacement for refspec 
patterns.

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

	-Daniel
*This .sig left intentionally blank*
