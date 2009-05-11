From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: merging multiple commit into one?
Date: Mon, 11 May 2009 23:29:24 +0200
Message-ID: <20090511212923.GA19844@macbook.lan>
References: <1de9d39c0905110621p6858bca8y8bb036a167754672@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: jean-luc malet <jeanluc.malet@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 23:29:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3d4I-00067e-LE
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 23:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760044AbZEKV31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 17:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760031AbZEKV30
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 17:29:26 -0400
Received: from darksea.de ([83.133.111.250]:39557 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760049AbZEKV3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 17:29:25 -0400
Received: (qmail 26093 invoked from network); 11 May 2009 23:29:11 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 11 May 2009 23:29:11 +0200
Content-Disposition: inline
In-Reply-To: <1de9d39c0905110621p6858bca8y8bb036a167754672@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118851>

On Mon, May 11, 2009 at 03:21:27PM +0200, jean-luc malet wrote:
> according to my knowledge of git, removing the commit and rewriting
> the last commit log so that it better reflect the modification will do
> the job but I'm not sure git allow it...

If you just want to get rid of the last commit

  git reset HEAD^

will remove the commit but keep your working directory untouched. In
such a workflow I find it easier to start the new commit from zero than
from the stashed stuff.

By the way. You might also take a look at the command

  git stash

which is especially crafted for saving work in progress.

cheers Heiko
