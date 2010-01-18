From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git Wiki Move
Date: Mon, 18 Jan 2010 10:53:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001181044410.4985@pacific.mpi-cbg.de>
References: <20100113232908.GA3299@machine.or.cz> <20100114012449.GB3299@machine.or.cz> <4B4EF1E0.3040808@eaglescrag.net> <vpqbpgxrn32.fsf@bauges.imag.fr> <4B4F68E8.5050809@eaglescrag.net> <4B50F7DB.7020204@eaglescrag.net> <vpqwrzhszye.fsf@bauges.imag.fr>
 <alpine.DEB.1.00.1001172357420.4985@pacific.mpi-cbg.de> <4B53AEAC.6060100@eaglescrag.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 10:47:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWoCx-0004x4-C5
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 10:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250Ab0ARJrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 04:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229Ab0ARJre
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 04:47:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:39453 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753193Ab0ARJrd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 04:47:33 -0500
Received: (qmail invoked by alias); 18 Jan 2010 09:47:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 18 Jan 2010 10:47:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dzt117kVdyoYRZcT83uJSbnyEwEb4zBpAG9IPWK
	kkekORXsarmD9T
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B53AEAC.6060100@eaglescrag.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48999999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137377>

Hi,

On Sun, 17 Jan 2010, J.H. wrote:

> On 01/17/2010 03:06 PM, Johannes Schindelin wrote:
> 
> > On Sun, 17 Jan 2010, Matthieu Moy wrote:
> > 
> >> You should set $wgLogo to some Git logo, among 
> >> http://git.or.cz/gitwiki/GitRelatedLogos
> > 
> > Best would be the standard one: http://git.or.cz/git-logo.png but I 
> > would actually also like http://henrik.nyh.se/uploads/git-logo.png.
> 
> I'd leave that up to the greater community.  The second one there would 
> fit better on the page honestly, but I don't want to go making a logo 
> decision for the entirety of the project.

Why not set the logo to the second one, and at the same time start one of 
our famous bikeshedding fests?  (Anyone answering to that question, please 
change the subject to "Wiki logo".)

> >> You can also add a few links to the sidebar, by editting: 
> >> http://git.wiki.kernel.org/index.php/MediaWiki:Sidebar
> >>
> >> (it seems I don't have permission to do it myself).
> > 
> > You need to be in the Sysop list to do so.  Warthog, if you trust me :-) 
> > would you mind adding me to that group?  You can do that by visiting
> > 
> > http://git.wiki.kernel.org/index.php/Special:Userrights
> > 
> > when you are a sysop.
> 
> Done.

Thank you very much!

> >> I suggest taking the ones of the front-page:
> >>
> >> * Starting points
> >> ** Installation|Installation
> >> ** InterfacesFrontendsAndTools|Git Tools
> >> ** GitDocumentation|Git Documentation
> >> ** GitCommunity|Git Community Support
> >> ** GitProjects|Projects using Git
> >> ** GitFaq|FAQ
> >> ** GitHosting|Git Hosting
> >> ** GitLinks|Git Links
> >> ** GitComparison|Git Compared
> > 
> > Let's not forget
> > 
> > * navigation
> > ** mainpage|mainpage-description
> > ** recentchanges-url|recentchanges
> > ** randompage-url|randompage
> > ** helppage|help
> > * SEARCH
> > * TOOLBOX

Changed as suggested.

> > BTW there is a file KHTMLFixes.css in the directory skins/monobook/ 
> > which makes the layout break with Chromium.  Apparently, it is no 
> > longer needed by KHTML anyway.  So could you please replace that file 
> > with an empty one, or comment out the offending part, like so:
> > 
> > 	/* #column-content { margin-left: 0; } */
> 
> I'm not keen on making changes since that file is still coming from the
> shipping version of mediawiki and I'm trying, quite a lot, to not run a
> modified version of it.  I've got enough troubles with the fact that
> that one change would affect 22 wikis in a single go.
> 
> As bad as it is to say this, I'd rather wait for 1.16 to come out vs. 
> modify it in place.  Mediawiki is claiming they are in continuous 
> integration development with quarterly releases but their last release 
> was June of 2009, so take that as you will.

Fair enough.  As long as Chromium has a fairly small share of the market, 
I think it is safe to tell everybody to wait a little until the side bar 
is no longer displayed at the left _below_ the main body text.  AFAICT the 
problem was solved with Wikipedia, so the next release should magically 
fix the issue.

Thanks,
Dscho
