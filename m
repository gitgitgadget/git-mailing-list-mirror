From: Jeff King <peff@peff.net>
Subject: Re: git-branch and git-remotes confusion
Date: Tue, 10 Apr 2007 08:25:17 -0400
Message-ID: <20070410122516.GA27388@coredump.intra.peff.net>
References: <46a038f90704100505i7bdd88a8q52186f7ce7ff0cdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 19:02:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbFPa-0003QU-2o
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 14:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbXDJMZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 08:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965275AbXDJMZU
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 08:25:20 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3177 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965153AbXDJMZT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 08:25:19 -0400
Received: (qmail 15414 invoked from network); 10 Apr 2007 12:25:56 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 10 Apr 2007 12:25:56 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Apr 2007 08:25:17 -0400
Content-Disposition: inline
In-Reply-To: <46a038f90704100505i7bdd88a8q52186f7ce7ff0cdf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44132>

On Wed, Apr 11, 2007 at 12:05:17AM +1200, Martin Langhoff wrote:

>   git-clone http://git.catalyst.net.nz/git/moodle-r2.git
>   git-branch --track origin/mdl18-olpc my18-olpc

Your arguments to git-branch are backwards. It should be:

  git-branch --track my18-olpc origin/mdl18-olpc

Also note that --track didn't show up until 1.5.1.  Other than that, it
should do what you expect (check out your .git/config before and after
to see the impact of --track).

-Peff
