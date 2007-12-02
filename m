From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Sun, 2 Dec 2007 17:23:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712021718460.27959@racer.site>
References: <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org>
 <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net>
 <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net>
 <alpine.LFD.0.99999.0711292004340.9605@xanadu.home>
 <20071130011748.GC11683@coredump.intra.peff.net> <474FB938.3040209@op5.se>
 <20071130150948.GA22095@coredump.intra.peff.net> <7vve7jqz92.fsf@gitster.siamese.dyndns.org>
 <20071130212500.GB25946@coredump.intra.peff.net> <Pine.LNX.4.64.0711302306580.27959@racer.site>
 <FFEBE8BB-E764-4DD0-A7DC-8CC01659D9BC@wincent.com> <Pine.LNX.4.64.0712021637250.27959@racer.site>
 <4752E3D0.6030802@obry.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sun Dec 02 18:24:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IysYX-000568-5C
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 18:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbXLBRYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 12:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbXLBRYR
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 12:24:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:53922 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751526AbXLBRYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 12:24:16 -0500
Received: (qmail invoked by alias); 02 Dec 2007 17:24:14 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp008) with SMTP; 02 Dec 2007 18:24:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vDAQ6tU3vWKzz0X93t20bM9sQQcyWteh6cDkxcz
	p84W9O4g0JCOUu
X-X-Sender: gene099@racer.site
In-Reply-To: <4752E3D0.6030802@obry.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66801>

Hi,

On Sun, 2 Dec 2007, Pascal Obry wrote:

> Johannes Schindelin a ?crit :
> > Okay, how many executables are there in your /usr/bin/?  Here there 
> > are 2973. Guess what.  I am not intimidated by that number.
> 
> Good, and look in /usr/bin, all those 2973 binary are all disconnected.
> 
> Here we are speaking about a tool as a whole : Git.

No, we are speaking about different commands, such as commit, fetch, push, 
etc.

I refuse to believe that you cannot see the equivalence.

> I've read many documentations before grabbing the system and I've not
> been impressed by the number of binaries in /usr/bin... Because I've
> almost never looked there.

Exactly my point.

> Most of the time I'm using "git <tab>" and the bash completion feature 
> is just right for me.

Bash completion is really something fine.

But even without, I do not see a problem: many cvs users used only three 
out of 32 commands (most CVS users I personally know/knew only called add, 
commit and update).  You could even see all 32 commands when calling the 
clunky command line "cvs --help-commands".  I am convinced we're already 
more user-friendly than that.

Ciao,
Dscho
