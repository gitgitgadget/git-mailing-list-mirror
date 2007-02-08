From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Thu, 8 Feb 2007 01:41:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702080140230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17866.20355.744025.133326@lisa.zopyra.com>
 <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
 <7vd54l60gg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071525270.8424@woody.linux-foundation.org>
 <7vtzxx4k1c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071539390.8424@woody.linux-foundation.org>
 <7v8xf94hq1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 01:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HExOa-00083Y-Im
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 01:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161365AbXBHAlv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 19:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422881AbXBHAlu
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 19:41:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:47200 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422855AbXBHAll (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 19:41:41 -0500
Received: (qmail invoked by alias); 08 Feb 2007 00:41:39 -0000
X-Provags-ID: V01U2FsdGVkX1/o6u5avsrotmVIxIg1x1Xea41T86Y/iiPbAfzkqa
	Jexg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v8xf94hq1.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39022>

Hi,

On Wed, 7 Feb 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > With "--pretty=oneline --abbrev-commit" I'll agree that it's actually 
> > fairly pretty.
> >
> > Maybe we can make "-g" default to that? As it is, I'd otherwise still use 
> > "less" just because there is less typing...
> >
> > 			Linus
> 
> Well, you would not know if the user gave you '-g' before you
> ask setup_revisions() to parse the options, and once you let it
> do its thing, you would not know if it also found an explicit
> output format given by the end user, so your cannot sanely make
> default depend on '-g'.
> 
> I suspect that it would have to be either somewhat involved or
> outright hacky.  

Well, we could always make CMIT_FMT_DEFAULT _not_be the same as _MEDIUM, 
and if it still is the same _after_ parsing the options, set it to MEDIUM 
explicitely. Same goes for the abbrev thing.

Ciao,
Dscho
