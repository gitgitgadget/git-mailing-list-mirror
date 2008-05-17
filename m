From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Sat, 17 May 2008 19:44:03 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805171939540.30431@racer>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>  <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com>  <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>  <alpine.DEB.1.00.0805161125320.30431@racer> 
 <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org>  <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com>  <alpine.DEB.1.00.0805171102480.30431@racer>  <e06498070805170744l7ad213aeqb779b0c0381e1de4@mail.gmail.com>
 <bd6139dc0805170912w14b7894fxfebe15c14e4c44ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Walter <stevenrwalter@gmail.com>,
	=?ISO-8859-15?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>,
	Kevin Ballard <kevin@sb.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 20:44:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxROl-0007eB-UU
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 20:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbYEQSoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 14:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbYEQSoA
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 14:44:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:46748 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752363AbYEQSn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 14:43:59 -0400
Received: (qmail invoked by alias); 17 May 2008 18:43:56 -0000
Received: from R06ea.r.pppool.de (EHLO racer.local) [89.54.6.234]
  by mail.gmx.net (mp010) with SMTP; 17 May 2008 20:43:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18KCe05O1cKkU2chj4hQaedrw/kOjDxf2//3hGVaG
	JSD/rsvbyro4b9
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0805170912w14b7894fxfebe15c14e4c44ef@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82357>

Hi,

On Sat, 17 May 2008, Sverre Rabbelier wrote:

> On Sat, May 17, 2008 at 4:44 PM, Steven Walter <stevenrwalter@gmail.com> 
> wrote:
>
> > With this dedication to backwards-compatibility, we'll be at Windows 
> > Vista quality in no time.

That is silly at best, especially given that Vista is _not_ 
backwards-compatible.  Not to mention that it is not forkable, because it 
is not Open Source.

> I very much agree here, given the nature of scripts (that is, being very 
> easy to update), I think we should try not to be too strict in 
> backwards-compatibility or we'll lose the flexibility that is very much 
> needed when developing a Good Product (tm) As long as such compatibility 
> breaking changes are marked (in BIG LETTERS) in the changelog/release 
> notes I think that would be a 'sacrifice' we should consider making.

Had you (one of our GSoc students) not replied, I would not even have 
bothered to say anything.

But I strongly disagree with the notion that it is okay to fsck with 
old-timers (who would be harmed by breaking backwards-incompatibility, 
and nobody else), especially given that it is mostly old-timers who turned 
Git into the Good Product(tm) it is.

Ciao,
Dscho
