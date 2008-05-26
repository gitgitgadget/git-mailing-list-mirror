From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-grep: add --color to highlight matches
Date: Mon, 26 May 2008 11:16:05 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805261113050.30431@racer>
References: <20080524043118.GA23118@laptop> <m3ve142jkc.fsf@localhost.localdomain> <fcaeb9bf0805240220x78943f8ap67344a508531faa0@mail.gmail.com> <200805241259.13132.jnareb@gmail.com> <483A7B1F.1050608@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon May 26 12:16:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0ZlA-0006si-0I
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 12:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbYEZKQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 06:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbYEZKQE
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 06:16:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:49048 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752064AbYEZKQC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 06:16:02 -0400
Received: (qmail invoked by alias); 26 May 2008 10:16:00 -0000
Received: from R4980.r.pppool.de (EHLO racer.local) [89.54.73.128]
  by mail.gmx.net (mp022) with SMTP; 26 May 2008 12:16:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/65oM2P/f6/gCX9l2TRGn/L6oc/Dyn8Bmkx7eZQ1
	IpF2JVtEvGB7Yk
X-X-Sender: gene099@racer
In-Reply-To: <483A7B1F.1050608@op5.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82914>

Hi,

On Mon, 26 May 2008, Andreas Ericsson wrote:

> I can't help but think that colorization for external-grep systems only 
> would still be worthwhile, as the majority of git users are on such 
> systems. It'd still be a separate implementation from adding it to the 
> internal grep functionality anyways, so it's not as if work would be 
> lost by going half the way here.

Huh?  I thought that the external grep is only a matter of fallback for 
performance reasons (if the files are already checked out), or if the user 
specifies the external grep explicitely.

At least for the platform we bend over most, our beloved anachronistic M$ 
Windows, I do not recall forcing external grep.

Besides, it would be a kludge at best to work _twice_ to find out the 
search terms, once in the external grep, and a second time in the coloring 
code.  So I think it should not be done.

Ciao,
Dscho
