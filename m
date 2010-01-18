From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git Wiki Move
Date: Mon, 18 Jan 2010 13:03:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001181258540.3044@intel-tinevez-2-302>
References: <20100113232908.GA3299@machine.or.cz> <20100114012449.GB3299@machine.or.cz> <4B4EF1E0.3040808@eaglescrag.net> <vpqbpgxrn32.fsf@bauges.imag.fr> <4B4F68E8.5050809@eaglescrag.net> <4B50F7DB.7020204@eaglescrag.net> <vpqwrzhszye.fsf@bauges.imag.fr>
 <alpine.DEB.1.00.1001172357420.4985@pacific.mpi-cbg.de> <4B53AEAC.6060100@eaglescrag.net> <alpine.DEB.1.00.1001181044410.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 13:04:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWqKj-0001AC-D7
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 13:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297Ab0ARMDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 07:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754481Ab0ARMDq
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 07:03:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:43507 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751524Ab0ARMDo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 07:03:44 -0500
Received: (qmail invoked by alias); 18 Jan 2010 12:03:41 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp066) with SMTP; 18 Jan 2010 13:03:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18lHwMiYK4ld1wV4WakYIrjs+9ETWRPNkdrns22qV
	egtLb9Gz3Hr/E0
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.00.1001181044410.4985@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.56999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137384>

Hi,

On Mon, 18 Jan 2010, Johannes Schindelin wrote:

> On Sun, 17 Jan 2010, J.H. wrote:
> 
> > On 01/17/2010 03:06 PM, Johannes Schindelin wrote:
> > 
> > > BTW there is a file KHTMLFixes.css in the directory skins/monobook/ 
> > > which makes the layout break with Chromium.  Apparently, it is no 
> > > longer needed by KHTML anyway.  So could you please replace that 
> > > file with an empty one, or comment out the offending part, like so:
> > > 
> > > 	/* #column-content { margin-left: 0; } */
> > 
> > I'm not keen on making changes since that file is still coming from 
> > the shipping version of mediawiki and I'm trying, quite a lot, to not 
> > run a modified version of it.  I've got enough troubles with the fact 
> > that that one change would affect 22 wikis in a single go.
> > 
> > As bad as it is to say this, I'd rather wait for 1.16 to come out vs. 
> > modify it in place.  Mediawiki is claiming they are in continuous 
> > integration development with quarterly releases but their last release 
> > was June of 2009, so take that as you will.
> 
> Fair enough.  As long as Chromium has a fairly small share of the 
> market, I think it is safe to tell everybody to wait a little until the 
> side bar is no longer displayed at the left _below_ the main body text.  
> AFAICT the problem was solved with Wikipedia, so the next release should 
> magically fix the issue.

Actually, in a rare case of cleverness, I found out how to fix it (at 
least for me, it works):

	http://git.wiki.kernel.org/index.php/MediaWiki:Monobook.css

Of course, this is only a work-around, and it will get broken once 
Monobook changes dimensions (or more).  But hopefully Chromium will be 
fixed by then, extending the canvas into the negative arm of the x axis 
whenever needed.  And then I will happily delete the custom Monobook.css.

These are the things left that I would like to see soon:

- add a link from the old Wiki (with rewrite rules)

- use whatever logo (anything is better than the sunflower)

- enable anonymous edits

- a major cleanup of the broken autolinks and faulty formatting.

The latter point is probably the most tedious one, so I suggest that only 
those get a vote on the logo who fix at least 3 pages.

Ciao,
Dscho
