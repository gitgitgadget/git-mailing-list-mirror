From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/15] i18n support for git-gui
Date: Mon, 3 Sep 2007 13:17:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709031308160.28586@racer.site>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site>
 <Pine.LNX.4.64.0709021738090.28586@racer.site> <20070903044938.GQ18160@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 03 14:18:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISAsj-0008Hm-TD
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 14:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbXICMSL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 08:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbXICMSJ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 08:18:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:43613 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750809AbXICMSI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 08:18:08 -0400
Received: (qmail invoked by alias); 03 Sep 2007 12:18:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp014) with SMTP; 03 Sep 2007 14:18:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Dcew79X/DGTXStsUbaIQ6J//sB9RjO25uJuuZHL
	cTczKCnonhvedV
X-X-Sender: gene099@racer.site
In-Reply-To: <20070903044938.GQ18160@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57476>

Hi,

On Mon, 3 Sep 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > sorry for the fsckup with the first two patches; both should be attributed 
> > to Christian Stimming.
> > 
> > For convenience, I also uploaded that patch series (on top of your 
> > "git-gui: Initialize Tcl's msgcat library for internationalization" in 
> > your "pu" branch) to the "for-shawn" branch in git-gui-i18n.
> 
> That was *much* easier than the small patch bomb.  ;-)

Hehe.  I somehow had the impression that there were only a handful of 
patches.  Imagine how surprised I was when format-patch came up with 15!  

> I've swallowed this series down and added it to my `master` branch. I 
> found one bug in the [mc "..."] string definitions and fixed it (below). 
> I also applied Michele Ballabio's "remove does in some UI strings" patch 
> on top. Those two changes I'm sure will impact some of the translated 
> strings.  I guess someone needs to run `make update-po` and ask 
> translators to revise the individual languages?

Yes, will do so.

The thing is: these four changes are easy enough that update-po will still 
match them, and mark them with "fuzzy".

Now, before I go and bug my dear translators, I will play around with a 
custom diff driver for .po files which should be easier on the eye: it is 
not in the least funny to see gazillions of changes which are just line 
number changes, and to miss out the real modifications.

BTW I like your "quiet" patch...

Ciao,
Dscho
