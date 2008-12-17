From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Get rid of the last remnants of
	GIT_CONFIG_LOCAL
Date: Wed, 17 Dec 2008 07:53:09 -0800
Message-ID: <20081217155309.GA32487@spearce.org>
References: <alpine.DEB.1.00.0812142310210.25197@racer> <alpine.DEB.1.00.0812142311360.25197@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 17 16:56:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCyjF-0007kj-RT
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 16:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbYLQPxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 10:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbYLQPxL
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 10:53:11 -0500
Received: from george.spearce.org ([209.20.77.23]:49039 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbYLQPxK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 10:53:10 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8EB1038200; Wed, 17 Dec 2008 15:53:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0812142311360.25197@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103356>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> In dc871831(Only use GIT_CONFIG in "git config", not other programs),
> GIT_CONFIG_LOCAL was rested in peace, in favor of not reading
> /etc/gitconfig and $HOME/.gitconfig at all when GIT_CONFIG is set.
> 
> 	You might want to hold off on that, as git-gui is supposed to be 
> 	less tightly coupled to git.git than, say, git-svn.
> 
> 	The commit removing support for GIT_CONFIG_LOCAL is from Mon Jun 
> 	30 03:37:47 2008 -0400...

Nah, that's in Git 1.6.0.  This block of code is only useful on
Windows, where most people are probably running a more msysgit
style system than some random mashup of Git and git-gui versions.

Plus, wasn't there just some discussion about how this warning
is perhaps harmful to the user because it doesn't really help
her to resolve the problem?

I applied it anyway.  Its quite unlikely anyone runs git-gui on
Windows with GIT_CONFIG_LOCAL in their environment.

-- 
Shawn.
