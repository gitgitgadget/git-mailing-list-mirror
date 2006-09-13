From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 18:05:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609131804050.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com> 
 <20060913152451.GH23891@pasky.or.cz> <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 13 18:05:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNXEq-0000Fj-UC
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 18:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWIMQFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 12:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWIMQFW
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 12:05:22 -0400
Received: from mail.gmx.de ([213.165.64.20]:26075 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750923AbWIMQFV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 12:05:21 -0400
Received: (qmail invoked by alias); 13 Sep 2006 16:05:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 13 Sep 2006 18:05:19 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26918>

Hi,

On Wed, 13 Sep 2006, Jon Smirl wrote:

> Moving the refs into refs/abandoned would work too. We would need new
> git commands to do this and flags on the visualization tools to
> include the abandoned branches. On the other hand doing this is
> recording state about the repository in the refs directory instead of
> writing this state into the repo itself.

Well, the refs directory is _part_ of the repository. Think about it, if 
you do not know which branches are in the object database, you lack a lot 
of information.

BTW the moving of a branch to a tag in refs/abandoned/ is trivial.

Ciao,
Dscho
