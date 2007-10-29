From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: remote#branch
Date: Mon, 29 Oct 2007 18:32:56 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710291832290.4362@racer.site>
References: <20071015233800.6306e414@paolo-desktop> <20071016021933.GH12156@machine.or.cz>
 <Pine.LNX.4.64.0710161139530.25221@racer.site> <20071016210904.GI26127@efreet.light.src>
 <Pine.LNX.4.64.0710162228560.25221@racer.site> <20071027204757.GA3058@efreet.light.src>
 <Pine.LNX.4.64.0710280000240.4362@racer.site> <20071029174000.GA4449@efreet.light.src>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Oct 29 19:34:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImZRD-0005pD-DW
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 19:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbXJ2Sd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 14:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753007AbXJ2Sd5
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 14:33:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:39884 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753340AbXJ2Sd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 14:33:57 -0400
Received: (qmail invoked by alias); 29 Oct 2007 18:33:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp005) with SMTP; 29 Oct 2007 19:33:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GdlUvQN8Gwjfv0wdlakBQ7m0O0xIftvK6sadZjr
	POFxI1aoPvD2Fh
X-X-Sender: gene099@racer.site
In-Reply-To: <20071029174000.GA4449@efreet.light.src>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62625>

Hi,

On Mon, 29 Oct 2007, Jan Hudec wrote:

> On Sun, Oct 28, 2007 at 00:01:57 +0100, Johannes Schindelin wrote:
> 
> > On Sat, 27 Oct 2007, Jan Hudec wrote:
> > 
> > > On Tue, Oct 16, 2007 at 22:35:25 +0100, Johannes Schindelin wrote:
> > >
> > > > ',' is allowed in ref names, so ',' is out.
> > > 
> > > Actually since many characters that are allowed in ref name are not 
> > > allowed in URL at all, the ref-name has to be url-escaped. Which 
> > > brings all characters back in, because they can always be specified 
> > > escaped.
> > 
> > No.  The URL part of it has to be encoded.  But the ref names do 
> > _not_.  (If we really want to have a way to specify the remote URL and 
> > the branch(es) we want to fetch _at the same time_.)
> 
> If the branch names are not url-escaped, than the result is not an URL. 
> Which is just ugly and confusing. If it looks like an URL, it should 
> better be one.

So all you're saying is: it is not possible.

Well, discussion ended, I guess.

Ciao,
Dscho
