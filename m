From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Unresolved issues
Date: Wed, 21 Feb 2007 02:12:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702210206390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702200934270.20368@woody.linux-foundation.org>
 <7vfy90v729.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702201621050.4043@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702210136050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702201648000.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 02:12:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJg2R-0000vX-Vt
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 02:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbXBUBMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 20:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbXBUBMx
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 20:12:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:40966 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932266AbXBUBMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 20:12:52 -0500
Received: (qmail invoked by alias); 21 Feb 2007 01:12:51 -0000
X-Provags-ID: V01U2FsdGVkX18MlohOzs8MRkuwdTzJOg3SBXcU3XbUXkULQXRCsH
	qocw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702201648000.4043@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40272>

Hi,

On Tue, 20 Feb 2007, Linus Torvalds wrote:

> On Wed, 21 Feb 2007, Johannes Schindelin wrote:
> >
> > Um, I don't want to spoil the party, but was not the original idea of this 
> > auto-CRLF thing some sort of "emulation" of the CVS text checkout 
> > behaviour?
> > 
> > In that case, .gitattributes (I mean a tracked one) would be wrong, wrong, 
> > wrong.
> > 
> > It's a local setup if you want auto-CRLF or not. So, why not just make it 
> > a local setting (if in config or $GIT_DIR/info/gitattributes, I don't 
> > care) which shell patterns are to be transformed on input and/or output?
> 
> That is a good point. We *could* just make it a ".git/config" issue, 
> which has the nice benefit that you can just set up some user-wide rules 
> rather than making it be per-repo.

Yes, that's a nice side effect.

> Of course, the config language may not be wonderful for this.

Like you wrote in your example, most shell patterns are no problem in the 
config.

> And make the default built-in ones be good enough that in _practice_ you 
> never even need this in the first place.

This is really, really important. We already see many users using git, 
expecting it somehow to figure out what they want without them having read 
TFM.

Anyhow, I am right now talking with Junio (on IRC; my 2nd day wasting 
time in chatspace ;-), among other things about the import/export filters. 
We should at least keep in mind that this would be nice to have, and leave 
a door open for them when we do this stuff.

Ciao,
Dscho
