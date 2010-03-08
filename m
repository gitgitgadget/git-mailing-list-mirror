From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] Documentation: reset: describe new "--keep" option
Date: Mon, 8 Mar 2010 09:47:45 +0100
Message-ID: <20100308084745.GB4827@m62s10.vlinux.de>
References: <20100305202537.25469.73470.chriscool@tuxfamily.org> <7vaaukadap.fsf@alter.siamese.dyndns.org> <201003072138.18583.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Mar 08 09:48:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoYd3-0004zU-ES
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 09:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630Ab0CHIrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 03:47:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:35495 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750814Ab0CHIrv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 03:47:51 -0500
Received: (qmail invoked by alias); 08 Mar 2010 08:47:49 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp072) with SMTP; 08 Mar 2010 09:47:49 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/tdGhe2GDtfATlxW6v1zug5nZVdsF52m46YZXHIy
	iRW+SPe2H9H65E
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 558DAD4001; Mon,  8 Mar 2010 09:47:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201003072138.18583.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141755>

On Sun, Mar 07, 2010 at 09:38:18PM +0100, Christian Couder wrote:
> On Sunday 07 March 2010 06:52:46 Junio C Hamano wrote:
> > Christian Couder <chriscool@tuxfamily.org> writes:
> > > and give an example to show how it can be used.
> > >
> > > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > > ---
> > 
> > Thanks.  With the example I think I can tell others that this at least has
> > one known use case that is not totally whacky.
> > 
> > I haven't re-read Peter Baumann's comments that you dismissed as a
> > mis-reading of your added documentation, but if somebody _can_ misread
> > what you wrote, that is a sign that it has a room to be improved for
> > clarity.
> 
> Ok, so instead of:
> 
> > +--keep::
> > +     Resets the index to match the tree recorded by the named commit,
> > +     but keep changes in the working tree. Aborts if the reset would
> > +     change files that are already modified in the working tree.
> 
> what about:
> 
> --keep::
>      Resets the index to match the tree recorded by the named commit,

My reading of this (non native english speaker): Given the --keep flag,
*only* the index is updated.

>      but changed files in the working tree are kept untouched. 
>      Aborts if the reset would touch any of them.

Huh? Does it touch the work tree, too? You propably know by now where this
leads :-)

I have to admit I like Junio's version better, because at least it is clear
that the worktree is also touched.

--
Peter
