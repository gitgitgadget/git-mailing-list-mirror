From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 20:07:23 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803122005330.1656@racer.site>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil>
 <m3prtzyens.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:08:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZWIv-0003de-3G
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 20:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbYCLTHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 15:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbYCLTHS
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 15:07:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:35165 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751701AbYCLTHR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 15:07:17 -0400
Received: (qmail invoked by alias); 12 Mar 2008 19:07:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp009) with SMTP; 12 Mar 2008 20:07:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zdfFFXnlzJQEjAkvaU/hgIo+hSTBx4p1Xq0c1LB
	HKG4gp93t8RNtV
X-X-Sender: gene099@racer.site
In-Reply-To: <m3prtzyens.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76972>

Hi,

On Wed, 12 Mar 2008, Jakub Narebski wrote:

> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
> > Is 'git-gc --prune' still useful to end users when those in-the-know 
> > can use git-prune when they really want all loose unreferenced objects 
> > to be removed?
> 
> It is one command less to remember (just like with "git tag --verify" 
> and "git verify-tag"), so I'm all for "git gc --prune" to remain.

I don't care one way or the other.

> > Also, what about clones created with --shared or --reference? Should 
> > there be a way to disable this functionality? gc.pruneExpire never
> 
> That would be nice.

Okay, so I just remove the !approxidate() check.  Then, "gc.pruneExpire = 
never" should work as you expect it to.

Ciao,
Dscho
