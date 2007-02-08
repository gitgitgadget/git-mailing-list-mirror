From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Thu, 8 Feb 2007 01:56:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702080155390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17866.20355.744025.133326@lisa.zopyra.com>
 <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
 <7vd54l60gg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071525270.8424@woody.linux-foundation.org>
 <7vtzxx4k1c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071539390.8424@woody.linux-foundation.org>
 <7v8xf94hq1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702080140230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz3p321n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 01:56:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HExa6-00043S-PI
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 01:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161509AbXBHA4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 19:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422822AbXBHA4G
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 19:56:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:33175 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161509AbXBHA4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 19:56:04 -0500
Received: (qmail invoked by alias); 08 Feb 2007 00:56:01 -0000
X-Provags-ID: V01U2FsdGVkX19K9qx2NDRKXqawq68ZBZ3yFymyEtmaOwTDAReUXo
	9eyg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vmz3p321n.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39025>

Hi,

On Wed, 7 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Well, you would not know if the user gave you '-g' before you
> >> ask setup_revisions() to parse the options, and once you let it
> >> do its thing, you would not know if it also found an explicit
> >> output format given by the end user, so your cannot sanely make
> >> default depend on '-g'.
> >> 
> >> I suspect that it would have to be either somewhat involved or
> >> outright hacky.  
> >
> > Well, we could always make CMIT_FMT_DEFAULT _not_be the same as _MEDIUM, 
> > and if it still is the same _after_ parsing the options, set it to MEDIUM 
> > explicitely. Same goes for the abbrev thing.
> 
> I think we are in agreement.  I showed an outright hacky one
> because I am not ready to do somewhat involved one at the end of
> the rc period.

I fully agree. That's also why I am not pressing on other changes.

Ciao,
Dscho
