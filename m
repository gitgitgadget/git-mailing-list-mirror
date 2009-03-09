From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: push problem for new repo on repo.or.cz
Date: Mon, 9 Mar 2009 17:14:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903091713010.6358@intel-tinevez-2-302>
References: <49B53DAF.9080004@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 09 17:16:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgi90-00008N-O2
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 17:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbZCIQOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 12:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752073AbZCIQOa
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 12:14:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:41710 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752028AbZCIQO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 12:14:29 -0400
Received: (qmail invoked by alias); 09 Mar 2009 16:14:26 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp026) with SMTP; 09 Mar 2009 17:14:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19My2cZKaVMTz9TjMxbdZIQYrGcjRVQ89ftqkHu2H
	wkf07uKZD2s0yw
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49B53DAF.9080004@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112715>

Hi,

On Mon, 9 Mar 2009, Michael J Gruber wrote:

> I have problems pushing into a new project on repo.or.cz. My user (mjg)
> is added in the admin interface, the key is correct because I've been
> using it for a while already for other projects (forks though). I'm
> using a qualified refspec. What else could be wrong on my side, assuming
> it's not the scripts on repo.or.cz? My git is 1.6.2.

I guess it is your impatience.

Users are not really added from the web interface, that would be 
dangerous, as the web application would need more permissions than it 
deserves.  Therefore, the web application writes to a file which is 
handled by a cron job with those permissions.

So, wait 10 minutes and try again; I am sure it will work then.

Ciao,
Dscho
