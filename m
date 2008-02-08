From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Using thunderbird to post/apply patches?
Date: Fri, 8 Feb 2008 11:38:20 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802081135080.11591@racer.site>
References: <46a038f90802071521n674b61c2t5e4d4c740375b951@mail.gmail.com>  <47AB97EC.8030002@nrlssc.navy.mil> <76718490802072010x63e2082akf1aa92b12cd24030@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 12:38:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNRZF-0001zm-Eb
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 12:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbYBHLiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 06:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbYBHLiQ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 06:38:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:57484 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751855AbYBHLiO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 06:38:14 -0500
Received: (qmail invoked by alias); 08 Feb 2008 11:38:12 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp027) with SMTP; 08 Feb 2008 12:38:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/FsEWUzy/pvM2ZxE3Lze3tg3aWrz2G3SYv14x+a
	0qUfoWDGC7ad9h
X-X-Sender: gene099@racer.site
In-Reply-To: <76718490802072010x63e2082akf1aa92b12cd24030@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73076>

Hi,

On Thu, 7 Feb 2008, Jay Soffian wrote:

> On Feb 7, 2008 6:44 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> 
> > I also have mailnews.send_plaintext_flowed => false as suggested in 
> > SubmittingPatches.
> 
> Would teaching git-mailsplit to handle format=flowed be considered a 
> useful contribution?
> 
> (W/o sounding like a total script weenie, I'm actually wondering if 
> converting git-am, git-mailsplit, and git-mailinfo to Perl code wouldn't 
> be a bad idea... groking email is a lot more pleasant in Perl than shell 
> and/or C.)

FWIW I think you have it backwards.  It might look nicer in Perl, but we 
try very hard to consolidate the major pieces into C code.  This is done 
for several reasons:

- reducing dependencies (not everybody needs all git programs, so it even 
helps if one script is converted at a time), and

- making the experience nicer on Windows (reducing the foot-print, since 
Perl is _not_ commonly installed, and drastically improving performance, 
since the number of processes is reduced).

So no, I would not like these scripts being converted (back?) to scripts.

Thank you,
Dscho
