From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Document and test the new % shotcut for the tracked
 branch
Date: Fri, 20 Mar 2009 12:48:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903201247440.6865@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de> <1237543471-27248-1-git-send-email-git@drmicha.warpmail.net> <alpine.DEB.1.00.0903201128380.10279@pacific.mpi-cbg.de> <20090320111656.GA8940@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	Junio C Hamano <gitster@pobox.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Mar 20 12:51:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkdFP-0002JO-2Z
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 12:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbZCTLsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 07:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbZCTLsy
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 07:48:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:56855 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750920AbZCTLsx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 07:48:53 -0400
Received: (qmail invoked by alias); 20 Mar 2009 11:48:51 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp004) with SMTP; 20 Mar 2009 12:48:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GI+txHjnGq9dzb18wdgcLEv0pbz//AaYm/D9bed
	dC1YI6GywmRrTd
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090320111656.GA8940@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113943>

Hi,

On Fri, 20 Mar 2009, Petr Baudis wrote:

> On Fri, Mar 20, 2009 at 11:31:31AM +0100, Johannes Schindelin wrote:
> > I had it ready yesterday!  But the real problem is not addressed by 
> > your patch, either: '%<branch>' is a legal branch name.
> > 
> > I briefly considered <branch>^{tracked}, but
> > 
> > - the ^{} codepath does not try to substitute branch _names_, so we'd 
> >   have to duplicate that ^{} detection, and,
> > 
> > - it is really cumbersome to write.
> 
> We already have @{N} to do one branch-based substitution, so what about 
> following this convention? Can't we have @{t}?

Have you ever tried a German keyboard layout?  You would not say that @{} 
is easy to write if you did.

Besides, @{<string>} is already taken for the date-based reflog.

Ciao,
Dscho
