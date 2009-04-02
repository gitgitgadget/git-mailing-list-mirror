From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix 'git checkout <submodule>' to update the index
Date: Thu, 2 Apr 2009 22:27:52 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904022227400.7464@intel-tinevez-2-302>
References: <cover.1238678601u.git.johannes.schindelin@gmx.de> <c267451c12c4ead4c222eebe6df460b46edd59c1.1238678601u.git.johannes.schindelin@gmx.de> <7vprfuesra.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:29:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpTXX-0005as-2H
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 22:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756331AbZDBU16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 16:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756218AbZDBU16
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 16:27:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:47094 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751019AbZDBU15 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 16:27:57 -0400
Received: (qmail invoked by alias); 02 Apr 2009 20:27:53 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp048) with SMTP; 02 Apr 2009 22:27:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wXzJe/DwwY6NKg6XD2tmF0xvlZ1QEZdkXmnbZ9J
	sPBVwszt9fPcp/
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vprfuesra.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115496>

Hi,

On Thu, 2 Apr 2009, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > While 'git checkout <submodule>' should not update the submodule's
> > working directory, it should update the index.  This is in line with
> > how submodules are handled in the rest of Git.
> >
> > While at it, test 'git reset [<commit>] <submodule>', too.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	I have no idea who thought that it would be a good idea to leave 
> > 	the submodules alone, but I think it is highly counterintuitive 
> > 	that
> >
> > 		git checkout <submodule>
> >
> > 	does not touch the index.
> 
> I do not see anything that treats submodule specially in the scripted 
> version and this check for S_ISGITLINK() has been there since the very 
> beginning of C rewrite 782c2d6 (Build in checkout, 2008-02-07), so it is 
> a regression fix that can go to maint (all the way down to 1.5.5 if you 
> want).

I would appreciate that.

Thanks,
Dscho
