From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFD Use git for off-site backups
Date: Sun, 13 May 2007 13:16:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705131251370.6410@racer.site>
References: <20070513093417.GA18546@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Sun May 13 13:16:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnC40-0003PG-Mj
	for gcvg-git@gmane.org; Sun, 13 May 2007 13:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbXEMLQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 07:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755628AbXEMLQ0
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 07:16:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:44645 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754561AbXEMLQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 07:16:26 -0400
Received: (qmail invoked by alias); 13 May 2007 11:16:24 -0000
Received: from R1e8f.r.pppool.de (EHLO noname) [89.54.30.143]
  by mail.gmx.net (mp050) with SMTP; 13 May 2007 13:16:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19uF5ZZBzduWzau2Rup1Po6Du0++dJ40zoBzSKzR+
	swuDnO7rjP/vyl
X-X-Sender: gene099@racer.site
In-Reply-To: <20070513093417.GA18546@cip.informatik.uni-erlangen.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47140>

Hi,

On Sun, 13 May 2007, Thomas Glanzmann wrote:

> I am thinking about using git for doing differential backups of a whole
> machines. And I would like to know what is necessary to obtain that. In
> such a scenario the machine to be backed up should have a local index
> file but sends its objects directly to the remote machine via git-via-ssh
> or git protocol.

I think that this setup (have objects remotely) will kill performance 
pretty quickly. You have to compare to other blobs in order to find 
reasonable deltas...

> Is it possible to store extra information like extended attributes / 
> acls in git?

There has been talk about pre-commit scripts which put this information 
into a file, and a post-checkout script to resurrect these metadata, but I 
haven't seen functional versions of these scripts yet.

Ciao,
Dscho
