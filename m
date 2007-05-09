From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Wed, 9 May 2007 11:40:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705091139430.4167@racer.site>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
 <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
 <vpqbqgxak1i.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705062344230.29485@reaper.quantumfyre.co.uk>
 <20070507063505.GA31269@diana.vm.bytemark.co.uk> <20070508014114.GC11311@spearce.org>
 <464023A1.6618BC0A@eudaptics.com> <20070508102836.GB27119@diana.vm.bytemark.co.uk>
 <20070508124027.GA14366@fieldses.org> <20070508145311.GA31152@diana.vm.bytemark.co.uk>
 <20070509034556.GC27980@fieldses.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-319750203-1178703609=:4167"
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed May 09 11:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlieb-0006xj-5e
	for gcvg-git@gmane.org; Wed, 09 May 2007 11:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbXEIJkI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 05:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbXEIJkI
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 05:40:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:60824 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754069AbXEIJkG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 05:40:06 -0400
Received: (qmail invoked by alias); 09 May 2007 09:40:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 09 May 2007 11:40:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lXtUNrlXlsuf8yQ4ZcKqse3v3qe5I+FrbRgGG8t
	Zp2f2C7JOG3wx/
X-X-Sender: gene099@racer.site
In-Reply-To: <20070509034556.GC27980@fieldses.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46692>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-319750203-1178703609=:4167
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 8 May 2007, J. Bruce Fields wrote:

> On Tue, May 08, 2007 at 04:53:11PM +0200, Karl Hasselström wrote:
> > I would introduce it with a paragraph or two right where committing is
> > covered the first time. Explain that the empty file list box to the
> > left contains the changes that will be committed when you press the
> > commit button, and that the file list box on the right contains the
> > changes that won't be committed. By clicking on a file name you get to
> > see the diff to the file, and by clicking on the icon you move it to
> > the other file list box -- that is, you stage/unstage it.
> > 
> > And now comes the clever part: Introduce the index, by explaining that
> > it essentially _is_ the left file list box. Explain that git-add is
> > the command-line equivalent of moving changes to the left box, and
> > that git-commit without arguments simply commits what's in the index
> > -- exactly like git-gui's Commit button.
> > 
> > I think it could work. :-)
> 
> Definitely, sounds fun.
> 
> For the in-tree documentation, maybe I'm just my crusty text-centric
> commandline point of view, but I'd rather have the primary explanation
> continue to depend only on text and commandline examples, and then add a
> note telling people that playing with git-gui may help develop their
> intuition for the way the index works.
> 
> But I think it'd be interesting to try out the above approach with
> screenshots, etc., on a web page someplace.  It might also make a good
> visual aid for a talk.

Usually a wiki is a perfect place to start this...

Ciao,
Dscho

--8323584-319750203-1178703609=:4167--
