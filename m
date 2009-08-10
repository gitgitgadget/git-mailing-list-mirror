From: Jeff King <peff@peff.net>
Subject: Re: fatal: bad revision 'HEAD'
Date: Sun, 9 Aug 2009 21:18:03 -0400
Message-ID: <20090810011803.GA435@coredump.intra.peff.net>
References: <06DCECD0-45F0-4695-86D4-7C54EFE4E640@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joel Mahoney <joelmahoney@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 03:18:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaJWf-0006wb-Mw
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 03:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481AbZHJBSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 21:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754476AbZHJBSF
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 21:18:05 -0400
Received: from peff.net ([208.65.91.99]:38676 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754449AbZHJBSE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 21:18:04 -0400
Received: (qmail 10158 invoked by uid 107); 10 Aug 2009 01:20:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 21:20:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 21:18:03 -0400
Content-Disposition: inline
In-Reply-To: <06DCECD0-45F0-4695-86D4-7C54EFE4E640@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125394>

On Sun, Aug 09, 2009 at 03:15:46PM -0600, Joel Mahoney wrote:

> I am having trouble installing Ruby on Rails plugins from github.
> when I run e.g. script/install plugin git://github.com/thoughtbot/
> paperclip.git I get:
> 
> > Initialized empty Git repository in /path/to/my/project/vendor/
> plugins/paperclip/.git/
> > fatal: bad revision 'HEAD'
> > refusing to pull with rebase: your working tree is not up-to-date

I can "git clone" that repository just fine. What is it exactly that
installing a Rails plugin does with git? Can you try setting GIT_TRACE=1
in the environment and running your script to show us what git commands
it is executing?

-Peff
