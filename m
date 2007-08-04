From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 4 Aug 2007 12:38:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708041235190.14781@racer.site>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net> <200708040341.36147.ismail@pardus.org.tr>
 <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net> <46B3F762.1050306@midwinter.com>
 <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net> <46B418AA.4070701@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Ismail_D=F6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 13:39:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHHyV-0002FC-6M
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 13:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760159AbXHDLjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 07:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759706AbXHDLjM
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 07:39:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:49244 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758784AbXHDLjL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 07:39:11 -0400
Received: (qmail invoked by alias); 04 Aug 2007 11:39:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 04 Aug 2007 13:39:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mQVlmVdvmnUnF6eTwwHQjWZBJI+HSrx98n5zNHi
	FT9shKgNlPsNcC
X-X-Sender: gene099@racer.site
In-Reply-To: <46B418AA.4070701@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54826>

Hi,

On Sat, 4 Aug 2007, Steven Grimm wrote:

> Junio C Hamano wrote:
>
> >  * How much can we really rely on your fork to be kept
> >    maintained?  When we need newer mark-up that is not offered
> >    by AsciiDoc 7 clone, is it our plan to model that after
> >    AsciiDoc X (X > 7), or we just come up with an extension of
> >    our own?
> >   
> 
> My thought would be to come up with our own syntax; that's a logical 
> result of me not considering this anything but "a formatter whose input 
> looks suspiciously like AsciiDoc".

There have been a few suggestions to step away from asciidoc in this 
thread now.  IMNSVHO the only switch which would actually make sense, 
would be towards the Wiki format.

Why?

Because right now, we have a _ton_ of documentation on the Gitwiki, and 
no easy way to import it back.  We also have at least one document which 
is (semi-regularly) converted from ascii to Wiki markup.

Wiki markup is relatively easy to read (a bit more disruptive that 
asciidoc), but granted, it is lacking features such as the conditional 
thing Junio mentioned.

Ciao,
Dscho
