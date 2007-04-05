From: Jeff King <peff@peff.net>
Subject: Re: How can git pull be up-to-date and git push fail?
Date: Thu, 5 Apr 2007 16:46:04 -0400
Message-ID: <20070405204604.GA24779@coredump.intra.peff.net>
References: <17940.59514.150325.738141@lisa.zopyra.com> <20070405134954.GA18402@coredump.intra.peff.net> <17941.655.192938.792088@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 22:46:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZYqq-0000p9-KA
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 22:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767305AbXDEUqK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 16:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767222AbXDEUqJ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 16:46:09 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2571 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767305AbXDEUqH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 16:46:07 -0400
Received: (qmail 25794 invoked from network); 5 Apr 2007 20:46:41 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Apr 2007 20:46:41 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2007 16:46:04 -0400
Content-Disposition: inline
In-Reply-To: <17941.655.192938.792088@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43852>

On Thu, Apr 05, 2007 at 09:07:11AM -0500, Bill Lear wrote:

> Here is the local:
> 
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = false
>         logallrefupdates = true
> [remote "origin"]
>         url = ssh://poire/home/jml/repos/new/fusion
>         fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master

I don't see anything there that should cause branches under refs/remotes
to be pushed. Was he using 'git-push --all' by any chance?

-Peff
