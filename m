From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Wed, 7 Nov 2007 14:17:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711071414140.4362@racer.site>
References: <11944127311587-git-send-email-shawn.bohrer@gmail.com>
 <Pine.LNX.4.64.0711071110040.4362@racer.site> <18225.48553.44088.269677@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 15:17:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iplif-0001pJ-Bt
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 15:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757625AbXKGORH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 09:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757554AbXKGORG
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 09:17:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:44466 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757625AbXKGORF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 09:17:05 -0500
Received: (qmail invoked by alias); 07 Nov 2007 14:17:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 07 Nov 2007 15:17:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+d7QRuivGdISfCeDe50bhUn95J86ce0PnqwiXv/h
	MSNV9zcs3d5iaF
X-X-Sender: gene099@racer.site
In-Reply-To: <18225.48553.44088.269677@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63808>

Hi,

On Wed, 7 Nov 2007, Bill Lear wrote:

> On Wednesday, November 7, 2007 at 11:10:45 (+0000) Johannes Schindelin writes:
>
> > you still have quite a number of instances where you wrap just one 
> > line into curly brackets:
> >
> >	if (bla) {
> >		[just one line]
> >	}
> 
> I've always found this a thoughtful practice.  It helps ensure nobody 
> writes:
> 
>        if (bla)
>            just_one_line();
>            /* perhaps a comment, other stuff ... */
>            just_another_line();

But if there is only one line and you fail to add curly brackets when 
adding a second line, well, uhm, then I cannot help you with anything.

BTW I was talking about _one_ line, not a line and another one with a 
comment.

> It also is nice for others who come along and extend the branch from 
> just one line to multiple ones, as the brackets are already in place.

The fact is: these lines will stay single lines most likely for eternity.

> Why do you find it objectionable?

It distracts.  It's ugly.  It's unnecessary.

Ciao,
Dscho
