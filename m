From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Wed, 7 Nov 2007 15:04:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711071501270.4362@racer.site>
References: <11944127311587-git-send-email-shawn.bohrer@gmail.com>
 <Pine.LNX.4.64.0711071110040.4362@racer.site> <20071107145434.GB6768@mediacenter.austin.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:06:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpmTS-00026H-Vq
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759260AbXKGPE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 10:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759252AbXKGPE5
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 10:04:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:34863 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759217AbXKGPE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 10:04:56 -0500
Received: (qmail invoked by alias); 07 Nov 2007 15:04:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 07 Nov 2007 16:04:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9N6tdbUO9I2QhuPB8Yr7WAuaocEPzAZIz4dKyhM
	N83jXFW0T2nWL4
X-X-Sender: gene099@racer.site
In-Reply-To: <20071107145434.GB6768@mediacenter.austin.rr.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63817>

Hi,

On Wed, 7 Nov 2007, Shawn Bohrer wrote:

> On Wed, Nov 07, 2007 at 11:10:45AM +0000, Johannes Schindelin wrote:
> > 
> > you still have quite a number of instances where you wrap just one line 
> > into curly brackets:
> > 
> > 	if (bla) {
> > 		[just one line]
> > 	}
> 
> Crap.  OK I count one instance unless you count:
> 
> 	if (foo) {
> 		one_line();
> 	} else if (bar) {
> 		one_line();
> 		two_lines();
> 	} else {
> 		something_else();
> 	}

I do count them.  Personally, I find it highly distracting and ugly.  
Besides, we have the convention of putting the "}" not into the same line 
as "else".  (See keyword "uncuddling" in the list archives.)

While it may be true that some parts of the code follow these rules less 
strictly, it does not mean that we should introduce more of that kind.

BTW there are plenty of examples in the existing code which illustrate our 
implicit coding conventions.

> Now I suppose I can get rid of the curly braces here as well but I 
> personally find that strange and ugly.  So is there an official 
> guideline on if else statements?

Not yet ;-)  I can add it to the tentative v3 of Documentation/CodingStyle 
or CodingConventions or however the list would like to name it.

Ciao,
Dscho
