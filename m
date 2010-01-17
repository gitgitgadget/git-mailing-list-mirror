From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git Wiki Move
Date: Mon, 18 Jan 2010 00:06:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001172357420.4985@pacific.mpi-cbg.de>
References: <20100113232908.GA3299@machine.or.cz> <20100114012449.GB3299@machine.or.cz> <4B4EF1E0.3040808@eaglescrag.net> <vpqbpgxrn32.fsf@bauges.imag.fr> <4B4F68E8.5050809@eaglescrag.net> <4B50F7DB.7020204@eaglescrag.net> <vpqwrzhszye.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 00:01:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWe7M-0003zO-Gh
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 00:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641Ab0AQXBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 18:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754398Ab0AQXBH
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 18:01:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:42686 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753000Ab0AQXBE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 18:01:04 -0500
Received: (qmail invoked by alias); 17 Jan 2010 23:01:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 18 Jan 2010 00:01:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189CuUUMLw9Xs15wlWCDABUGSVaCxQfIDpR6sSbys
	in2DeZzY1pOFIu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <vpqwrzhszye.fsf@bauges.imag.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46999999999999997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137349>

Hi,

On Sun, 17 Jan 2010, Matthieu Moy wrote:

> "J.H." <warthog19@eaglescrag.net> writes:
> 
> > Quick update - I think I've got the vast majority of the obvious and
> > simple to correct problems fixed at http://git.wiki.kernel.org anyone
> > want to run through and see if there's anything else that would be
> > considered a show stopper?
> 
> The main page is locked, and there are some broken links formatting in
> the News section: http://git.wiki.kernel.org/index.php/Main_Page#News
> I'm user "Moy" there if you want to let me fix them.

I think I managed to edit them.

> You should set $wgLogo to some Git logo, among
> http://git.or.cz/gitwiki/GitRelatedLogos

Best would be the standard one: http://git.or.cz/git-logo.png but I would 
actually also like http://henrik.nyh.se/uploads/git-logo.png.

> You can also add a few links to the sidebar, by editting:
> http://git.wiki.kernel.org/index.php/MediaWiki:Sidebar
> 
> (it seems I don't have permission to do it myself).

You need to be in the Sysop list to do so.  Warthog, if you trust me :-) 
would you mind adding me to that group?  You can do that by visiting

http://git.wiki.kernel.org/index.php/Special:Userrights

when you are a sysop.

> I suggest taking the ones of the front-page:
> 
> * Starting points
> ** Installation|Installation
> ** InterfacesFrontendsAndTools|Git Tools
> ** GitDocumentation|Git Documentation
> ** GitCommunity|Git Community Support
> ** GitProjects|Projects using Git
> ** GitFaq|FAQ
> ** GitHosting|Git Hosting
> ** GitLinks|Git Links
> ** GitComparison|Git Compared

Let's not forget

* navigation
** mainpage|mainpage-description
** recentchanges-url|recentchanges
** randompage-url|randompage
** helppage|help
* SEARCH
* TOOLBOX

BTW there is a file KHTMLFixes.css in the directory skins/monobook/ which 
makes the layout break with Chromium.  Apparently, it is no longer needed 
by KHTML anyway.  So could you please replace that file with an empty one, 
or comment out the offending part, like so:

	/* #column-content { margin-left: 0; } */

Thank you,
Dscho
