From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make '!' aliases more useful
Date: Tue, 3 Jul 2007 02:37:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707030220460.4071@racer.site>
References: <Pine.LNX.4.64.0707012249590.4438@racer.site> <20070702145549.GB4720@thunk.org>
 <Pine.LNX.4.64.0707021654450.4071@racer.site> <20070702160810.GD4720@thunk.org>
 <7vr6nqwgdi.fsf@assigned-by-dhcp.cox.net> <20070703011429.GB5322@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 03 03:37:49 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5XKv-0003CT-Ei
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 03:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758504AbXGCBhs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 21:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758469AbXGCBhs
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 21:37:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:40349 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758455AbXGCBhr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 21:37:47 -0400
Received: (qmail invoked by alias); 03 Jul 2007 01:37:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 03 Jul 2007 03:37:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KTShCHFZKWQX0d2K8DurPjxmTHUrl7nVrD/fnjD
	GTiVbB7UssBpMK
X-X-Sender: gene099@racer.site
In-Reply-To: <20070703011429.GB5322@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51439>

Hi,

On Mon, 2 Jul 2007, Theodore Tso wrote:

> On Mon, Jul 02, 2007 at 04:11:21PM -0700, Junio C Hamano wrote:
> > > Such a point exists, I agree, but I would draw after $* and $1/$2/$3
> > > interpolation.  There is a lot more value that gets added with
> > > positional arguments support, and it makes git aliases more usable on
> > > platforms such as Windows where scripting capability is much more
> > > limited.
> > 
> > That actually sounds sensible, but you could alias
> > 
> > 	!sh -c 'command $2 $1 $3'
> > 
> > to reorder the parameters, couldn't you?
> 
> Um, how would that work on the Windows platform?
> 
> (I'm assuming here that we are trying to support Windows better, since
> there are projects such as Mozilla, and MySQL that care very much
> about first class Windows support.  We could say this isn't important
> enough, and that would be fine; but I wanted to at least raise the
> question.)

Windows support for those people unwilling to use cygwin amounts to 
anything, but a command line interface. Since aliases are _bound_ to 
the command line, I do not really get your point here.

In my view of things, for Windows support it is first of all important to 
get rid of the dependency on bash in the core parts. Then we should 
continue on the work Han-Wen did with his gub, and produce a proper 
Windows-clicky-style installer which installs git-gui with a proper 
Windows Start Menu item. But of course, then we should brace ourselves for 
a lot of clueless^Winterested users.

Ciao,
Dscho
