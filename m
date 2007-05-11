From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: Use "git config --global" instead of editing ~/.gitconfig
Date: Thu, 10 May 2007 23:46:53 -0400
Message-ID: <20070511034653.GB26896@fieldses.org>
References: <200705102353.31821.johan@herland.net> <20070510220253.GZ13719@fieldses.org> <20070510230045.GF4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 11 05:47:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmM63-0003ZW-1k
	for gcvg-git@gmane.org; Fri, 11 May 2007 05:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbXEKDrE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 23:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756673AbXEKDrD
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 23:47:03 -0400
Received: from mail.fieldses.org ([66.93.2.214]:59346 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994AbXEKDrD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 23:47:03 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HmM5l-0008GX-IX; Thu, 10 May 2007 23:46:53 -0400
Content-Disposition: inline
In-Reply-To: <20070510230045.GF4489@pasky.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46932>

On Fri, May 11, 2007 at 01:00:45AM +0200, Petr Baudis wrote:
> However, in that case I think this is not the good point to show
> ~/.gitconfig. Your goal at that point should be to get the user able
> to commit as simply as possible,

Sure.

> and having to manually edit some config file is unnecessary hassle
> when you can just use these two simple commands;

I don't get it; why are the two commands "simple", and editing a file a
"hassle"?  In terms of, say, time required, or number of keystrokes, I
suspect the two are about the same.  And it seems to me that:

	- As users of a tool designed mainly to track changes to text
	  files, git users are likely to be pretty proficient at editing
	  text files.
	- People also need to be able to view the configuration and
	  change it.  If they make a typo on the first try, they may
	  need to do this sooner rather than later.  With a config file,
	  this is trivial.  With git-config, you have to learn at least
	  one new thing (how to query values).
	- The config file is easier to read than the git-config output.
	- You're going to have to edit some text anyway to plug your
	  name in, so we can't make this a pure cut-n-paste from the
	  docs.

> also, we use the same commands in tutorials, crash courses etc. So I
> really think that consistency is better here. The more viable strategy
> is to mention that git-config really just plays with simple text files
> at some...  later point. :-)

So while I'm not convinced of the value of consistency here, if we have
to have consistency, I'd rather standardize on config-file-editing.

--b.
