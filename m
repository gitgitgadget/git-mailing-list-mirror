From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Repository Security
Date: Tue, 23 Jan 2007 10:41:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231036400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701221433.13257.andre@masella.no-ip.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 10:41:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9I9g-0006DY-DY
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 10:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932921AbXAWJlZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 04:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932927AbXAWJlZ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 04:41:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:36764 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932921AbXAWJlY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 04:41:24 -0500
Received: (qmail invoked by alias); 23 Jan 2007 09:41:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 23 Jan 2007 10:41:23 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andre Masella <andre@masella.no-ip.org>
In-Reply-To: <200701221433.13257.andre@masella.no-ip.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37493>

Hi,

On Mon, 22 Jan 2007, Andre Masella wrote:

> I've been using git for a while and really like it, but I have a concern 
> about security.
> 
> As I understand it, none of the repository backends allow any per-user 
> per-branch access control.

The idea in git (unless you really want to get the same setup as in CVS, 
which would be rather sad) is that every developer has at least one 
repository. Write-access: only one developer.

Now, to integrate you _pull_. No need for write-access for anybody else.

Of course, this means that all developers should have read-access to all 
repositories.

I already hear the complaint: "But you need a central repository!". If you 
_have_ to have a central repository, designate the integrator's repository 
central.

Ciao,
Dscho
