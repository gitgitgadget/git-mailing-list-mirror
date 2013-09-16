From: Adam Spiers <git@adamspiers.org>
Subject: Re: cdgit: cd relative to git workdir root
Date: Mon, 16 Sep 2013 20:25:10 +0100
Message-ID: <20130916192510.GA12433@gmail.com>
References: <201309162101.14879.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	vcs-home <vcs-home@lists.madduck.net>
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Mon Sep 16 21:25:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLeQC-0005PM-Bk
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 21:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054Ab3IPTZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 15:25:13 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:34021 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab3IPTZM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 15:25:12 -0400
Received: from localhost (8.5.8.b.9.2.d.1.0.6.4.3.d.d.1.2.0.d.3.7.6.a.1.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:11a6:73d0:21dd:3460:1d29:b858])
	by coral.adamspiers.org (Postfix) with ESMTPSA id D3FB82E342;
	Mon, 16 Sep 2013 20:25:10 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <201309162101.14879.thomas@koch.ro>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234841>

On Mon, Sep 16, 2013 at 09:01:14PM +0200, Thomas Koch wrote:
> Hi,
> 
> I frequently have the need to cd back to the root of the current git workdir 
> and created to alias for this:
> 
> git alias root = rev-parse --show-toplevel
> 
> shell alias cdgit = cd $(git root)
> 
> Maybe somebody likes this.

I do, and I was about to copy it into my own config when I discovered
that I'd already done this 4 years ago and totally forgotten about it :)

> Now it would be cool, to have an alias to cd into a specific subdir of the git 
> worktree and have zsh (or bash) auto completion for this like
> 
> git clone git://git.kernel.org/pub/scm/git/git.git
> cd git/gitweb/static/js/lib (just to be somewhere deep)
> cdgit con<tab>/com<tab> (becomes: cdgit contrib/completion)
> 
> Somebody with zsh/bash skills who already did this?

I hadn't done this before today, but it's easy in zsh:

  https://github.com/aspiers/git-config/commit/89df1d78

Of course, _gitcd needs to be somewhere on your $fpath so it can be
autoloaded.
