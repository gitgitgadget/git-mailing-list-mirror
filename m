From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCHv3 2/3] git-svn: Warn about changing default for
 --prefix in Git v2.0
Date: Sat, 12 Oct 2013 22:33:57 +0000
Message-ID: <20131012223357.GA4344@dcvr.yhbt.net>
References: <1381015833-696-1-git-send-email-johan@herland.net>
 <1381496227-28700-1-git-send-email-johan@herland.net>
 <1381496227-28700-3-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tfnico@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Oct 13 00:34:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VV7l3-00052R-Qf
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 00:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab3JLWd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 18:33:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37389 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753Ab3JLWd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 18:33:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96CFF44C004;
	Sat, 12 Oct 2013 22:33:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1381496227-28700-3-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236062>

Johan Herland <johan@herland.net> wrote:
> In Git v2.0, we will change the default --prefix for init/clone from
> none/empty to "origin/" (which causes SVN-tracking branches to be
> placed at refs/remotes/origin/* instead of refs/remotes/*).
> 
> This patch warns users about the upcoming change, both in the git-svn
> manual page, and on stderr when running init/clone in the "multi-mode"
> without providing a --prefix.
> 
> Cc: Eric Wong <normalperson@yhbt.net>
> Signed-off-by: Johan Herland <johan@herland.net>

Thanks!

1/2 and 2/3 signed-off and pushed to git://git.bogomips.org/git-svn.git
