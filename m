From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Unresolved issues
Date: Wed, 21 Feb 2007 01:39:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702210136050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702200934270.20368@woody.linux-foundation.org>
 <7vfy90v729.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702201621050.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 01:39:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJfWU-00044A-QF
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 01:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbXBUAjv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 19:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbXBUAjv
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 19:39:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:42544 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750828AbXBUAju (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 19:39:50 -0500
Received: (qmail invoked by alias); 21 Feb 2007 00:39:48 -0000
X-Provags-ID: V01U2FsdGVkX18UbPJcwxEU+FQYsyQUccF2P3ufjz5LrmjC3uDyR7
	s9kA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702201621050.4043@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40269>

Hi,

On Tue, 20 Feb 2007, Linus Torvalds wrote:

> 
> On Tue, 20 Feb 2007, Junio C Hamano wrote:
> > >
> > > No, that would be pretty horrid. So just tell everybody that it's based on 
> > > the working tree. I don't think it's likely to be a problem in practice.
> > 
> > Except for the initial checkout...
> 
> Yeah, that's true. That's indeed pretty nasty.

Um, I don't want to spoil the party, but was not the original idea of this 
auto-CRLF thing some sort of "emulation" of the CVS text checkout 
behaviour?

In that case, .gitattributes (I mean a tracked one) would be wrong, wrong, 
wrong.

It's a local setup if you want auto-CRLF or not. So, why not just make it 
a local setting (if in config or $GIT_DIR/info/gitattributes, I don't 
care) which shell patterns are to be transformed on input and/or output?

Ciao,
Dscho
