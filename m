From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0 of 7] [resend] - Improve handling remotes, origin,
 submodules
Date: Mon, 4 Feb 2008 18:15:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041813110.7372@racer.site>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com>  <alpine.LSU.1.00.0802032237320.7372@racer.site>  <47A68C01.9000600@gmail.com>  <alpine.LSU.1.00.0802041443420.7372@racer.site> <30e4a070802040924g550671ccsb11108c71c99e378@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 19:17:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM5sJ-00080p-Mg
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 19:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441AbYBDSQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 13:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754387AbYBDSQL
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 13:16:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:48508 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754117AbYBDSQK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 13:16:10 -0500
Received: (qmail invoked by alias); 04 Feb 2008 18:16:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 04 Feb 2008 19:16:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+QJD0wZ5+QZPq5hLVX8R7zeHSl16wX5wiDlOxgkw
	U5gOs9TPOyw0Ry
X-X-Sender: gene099@racer.site
In-Reply-To: <30e4a070802040924g550671ccsb11108c71c99e378@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72538>

Hi,

On Mon, 4 Feb 2008, Mark Levedahl wrote:

> On Feb 4, 2008 9:48 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > Should something like core.origin still be an issue (which I doubt, 
> > for the same reason you do not change the _name_ of the environment 
> > variable $HOME), we can still continue discussing that.

Actually, I said more things.  Things about fixing git-submodule first, so 
that you can ask it to update via different remotes than "origin".  And 
then try to argue for the rest.

> BIG difference here:
> $HOME = <name> of home directory, <name> is arbitrary. Files there are
> found as $HOME/<foo> or <name>/foo, they are the same, and I am free
> to set HOME=<arbitrary name>.
> 
> Currently
> $ORIGIN=origin, i.e., the default is *named* origin, not the default
> name is given by $ORIGIN.

"origin" is just the name of the default origin, holding the remote URL.  
Just like "HOME" is just the name of the variable holding the home 
directory.

But really.  Fix git-submodule first.

Ciao,
Dscho
