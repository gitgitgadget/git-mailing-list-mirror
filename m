From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Show of hands, how many set USE_NSEC
Date: Fri, 8 Aug 2008 18:55:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808081854120.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080808163455.GE9152@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:52:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRVC9-0005WO-JL
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 18:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbYHHQuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 12:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbYHHQuy
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 12:50:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:47533 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751019AbYHHQuw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 12:50:52 -0400
Received: (qmail invoked by alias); 08 Aug 2008 16:50:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 08 Aug 2008 18:50:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PKAM2hpQPsMinh05tqY8vEe7rCu4ttZu8cEBHxt
	P6DMs78bEUj0W5
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080808163455.GE9152@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91694>

Hi,

On Fri, 8 Aug 2008, Shawn O. Pearce wrote:

> How many users really build their Git with USE_NSEC=1?

I don't.

> I'm trying to come up with a sane way for jgit to realize it should 
> truncate the milliseconds out of a timestamp before it comes to the 
> index record.

You could add a config variable.  I hope that soon, we no longer need to 
share the same index between C Git and JGit (I hope for a delta 
pack implementation in Java...)

Ciao,
Dscho
