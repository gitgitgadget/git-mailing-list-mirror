From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svn: Protect against "diff.color = true".
Date: Fri, 31 Aug 2007 22:53:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708312251510.28586@racer.site>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
 <7vveav21uv.fsf@gitster.siamese.dyndns.org> <20070831152153.GA30745@muzzle>
 <7v4pifzawc.fsf@gitster.siamese.dyndns.org> <7v4pifxuia.fsf_-_@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0708312237340.28586@racer.site> <7vtzqfwf5c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>,
	Robert Newson <robert.newson@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:53:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IREQc-0001gC-6C
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbXHaVxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbXHaVxQ
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:53:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:50787 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752680AbXHaVxP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:53:15 -0400
Received: (qmail invoked by alias); 31 Aug 2007 21:53:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 31 Aug 2007 23:53:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/iNUcasb/iAZoOUAWXQhClKvjfsD9O8vilLYiR56
	7Qszx4xULTiUg2
X-X-Sender: gene099@racer.site
In-Reply-To: <7vtzqfwf5c.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57225>

Hi,

On Fri, 31 Aug 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 31 Aug 2007, Junio C Hamano wrote:
> >
> >>   I do not have an easy access to SVN repo
> >>   to interoperate with, so a testing by real-world users and an
> >>   Ack is appreciated.
> >
> > I just tested on a busybox clone: Works as expected.  Without your patch, 
> > I get the uninitialised values, with your patch it is fine.
> >
> > ACK.
> 
> Thanks.
> 
> It's customary that the privilege to issue Ack is reserved to
> the primary owner of the code.  We are a relatively small
> friendly community and it is not a big deal, but if you ever
> work on the kernel, be somewhat more careful.  People are picky
> over there on such details.

Happily, we are a much friendlier bunch here ;-)

Besides, since I feel we're really close to 1.5.3 now, I thought that you 
might want to here as many positive votes as you can get.

But yes, I'll keep that in mind ;-)

Ciao,
Dscho
