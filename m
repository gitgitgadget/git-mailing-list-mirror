From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [irq/urgent]: created 3786fc7: "irq: make variable static"
Date: Wed, 22 Oct 2008 19:04:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810221859590.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081022061730.GA5749@elte.hu> <m3ljwgj3xy.fsf@localhost.localdomain> <20081022132148.GA17393@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 22 18:58:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksh2d-0004Qc-23
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 18:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbYJVQ5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 12:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbYJVQ5G
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 12:57:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:36138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752250AbYJVQ5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 12:57:05 -0400
Received: (qmail invoked by alias); 22 Oct 2008 16:57:03 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 22 Oct 2008 18:57:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18MtLZQCoYM6J5J7/qMFJ9d32aNlI0w6r2cga6pmA
	SJvqO1YxqPBJ1G
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081022132148.GA17393@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98884>

Hi,

On Wed, 22 Oct 2008, Jeff King wrote:

> On Wed, Oct 22, 2008 at 03:50:52AM -0700, Jakub Narebski wrote:
> 
> > About printing either forward (git-describe, e.g. 
> > v1.6.0.2-590-g67f6062) or backward (git-name-rev, e.g. 
> > tags/v1.6.0-rc2~8): you can use git-name-rev in filter mode (git log 
> > ... | git name-rev --stdin), or "git log --decorate", or '%d' in 
> > --pretty format specifier (this is very new thing).
> 
> The "--decorate" and "%d" code just decorates branch _tips_. My 
> impression is that he wanted to see the branch mentioned even if the 
> commit was not at the tip. It would be possible to extend this to print 
> name-rev output, but it would be computationally and memory-intensive, I 
> suspect.

FWIW I tried to do this "on-the-fly", but that did not bode well with 
things like

	git log --decorate=any --no-walk master $(git rev-parse master~10)

If you're interested in code:

http://thread.gmane.org/gmane.comp.version-control.git/52123/focus=52126

Ciao,
Dscho
