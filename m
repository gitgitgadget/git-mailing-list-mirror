From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/8] Add a lockfile function to append to a file
Date: Sun, 20 Apr 2008 17:14:36 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804201714230.5084@eeepc-johanness>
References: <alpine.LNX.1.00.0804171950140.19665@iabervon.org> <7vtzhxce9g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 18:15:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JncC2-00087k-Gl
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 18:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbYDTQOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 12:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbYDTQOU
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 12:14:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:45832 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750765AbYDTQOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 12:14:19 -0400
Received: (qmail invoked by alias); 20 Apr 2008 16:14:17 -0000
Received: from R16f8.r.pppool.de (EHLO eeepc-johanness.st-andrews.ac.uk) [89.54.22.248]
  by mail.gmx.net (mp006) with SMTP; 20 Apr 2008 18:14:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/9/IoTMQ/I9z3A/DnFUEHO2mkacKiiv8Q2qqmbp
	9Le0hXIFcTh+Pm
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vtzhxce9g.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79962>

Hi,

On Sat, 19 Apr 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This takes care of copying the original contents into the replacement
> > file after the lock is held, so that concurrent additions can't miss
> > each other's changes.
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> > How about this? Also doesn't leak a fd and catches trying to append to a 
> > file you can't read. Should I worry about mmap failing after the open?
> 
> We have copy.c to copy small existing files, while detecting failure to
> copy properly.  How about doing something like this instead?

I like it.

Ciao,
Dscho
