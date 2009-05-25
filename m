From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: hg2git error
Date: Mon, 25 May 2009 13:43:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905251341370.4288@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0905241932301.26154@pacific.mpi-cbg.de> <20090525113418.GA3259@robert>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
To: Rocco Rutte <pdmef@gmx.net>
X-From: git-owner@vger.kernel.org Mon May 25 13:43:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8YaS-0005Yo-B6
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 13:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbZEYLnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 07:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbZEYLnP
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 07:43:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:34543 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750889AbZEYLnP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 07:43:15 -0400
Received: (qmail invoked by alias); 25 May 2009 11:43:15 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 25 May 2009 13:43:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193cdtMjqp3oXcdOBUpO49dOzhgAA768qFBFe36Op
	WzZC1a47J8/ANr
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090525113418.GA3259@robert>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119924>

Hi,

On Mon, 25 May 2009, Rocco Rutte wrote:

> * Johannes Schindelin wrote:
> 
> > Error: repository has at least one unnamed head: hg r533
> 
> I'm afraid there's nothing you can do except a) wait until somebody with
> push access to the repo merges or b) do that yourself. The error means
> that on a branch there's more than one head (i.e. childless
> revision). There's no equivalent concept in git which is why I don't
> know what to do. Generating fake branch names for git may be a little
> messy I think.

I disagree... The worst solution is to stop working at all.  A better 
solution would be to ignore the unnamed head, and the best solution would 
probably be to generate ref names that are _not_ branch names for such 
heads.

Ciao,
Dscho
