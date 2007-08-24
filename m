From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: tracking perms/ownership [was: empty directories]
Date: Fri, 24 Aug 2007 11:38:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708241136301.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1187716461.5986.71.camel@beauty> <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty> <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
 <1187905879.5986.199.camel@beauty>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Josh England <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Fri Aug 24 11:38:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOVcU-0000n9-Ik
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 11:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630AbXHXJiT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 05:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755415AbXHXJiT
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 05:38:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:56768 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751252AbXHXJiS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 05:38:18 -0400
Received: (qmail invoked by alias); 24 Aug 2007 09:38:17 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp031) with SMTP; 24 Aug 2007 11:38:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18vMYNtPN0viT7uA8rK5mEsJRfl0fWImg3dhNkFKN
	Ix+8ezABgvCzMZ
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <1187905879.5986.199.camel@beauty>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56565>

Hi,

On Thu, 23 Aug 2007, Josh England wrote:

> On Wed, 2007-08-22 at 16:25 -0700, Linus Torvalds wrote:
> > But if .gitattributes would work, you probably could introduce both full 
> > permissions and ownership rules there. We read git attributes for *other* 
> > reasons when checking files out _anyway_, ie we need the CRLF attribute 
> > stuff, so adding ownership attributes would not be at all odd.
> 
> So here's the initial thought.  Create two new gitattributes, 'perms'
> and 'ownership', which will track perms/ownership for files matching the
> given pattern.

I wonder why you do not just use the "smudge" and "clean" attributes, and 
store the ownership _and_ the permissions in .gitacls.

Yes, _maybe_ it is something other people might want, too, but let's start 
quick & easy, no?

Ciao,
Dscho
