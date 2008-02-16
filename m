From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] mailinfo: support rfc3676 (format=flowed) text/plain
 messages
Date: Sat, 16 Feb 2008 02:30:35 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802160227180.30505@racer.site>
References: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com>  <alpine.LSU.1.00.0802151035100.30505@racer.site> <76718490802151043q56340ea9i247dbb1601f8d225@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 03:31:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQCpk-0003IH-M6
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 03:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755813AbYBPCam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 21:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755741AbYBPCam
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 21:30:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:48715 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754671AbYBPCal (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 21:30:41 -0500
Received: (qmail invoked by alias); 16 Feb 2008 02:30:39 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp053) with SMTP; 16 Feb 2008 03:30:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qfD5oOhDqQJGy72nwxXXYKcnmFUCdgrRAtj4VF/
	7QDVO5+UCDbde8
X-X-Sender: gene099@racer.site
In-Reply-To: <76718490802151043q56340ea9i247dbb1601f8d225@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74000>

Hi,

On Fri, 15 Feb 2008, Jay Soffian wrote:

> On Fri, Feb 15, 2008 at 5:41 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >  > +             char *cp = line;
> >  > +             while (*cp == '>' && *cp != 0)
> >  > +                     cp++;
> >
> >  How about using strchrnul()?
> 
> Actually strchrnul() here isn't correct. I want to strip leading '>' 
> only. strchrnul() will search for the first occurrence (skipping over 
> non-'>' to do so), which is not what I want.

Oh, okay, I read again.

You just wanted to strip the leading ">".  So I know even less what you 
tried to do.  But then, I do not know anything about format=flawed either.

Ciao,
Dscho
