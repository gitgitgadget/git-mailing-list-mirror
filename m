From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add a post-tag hook
Date: Fri, 17 Apr 2009 15:19:44 -0700
Message-ID: <20090417221944.GS23604@spearce.org>
References: <cd3664ac0904171515u1e2fce41ubd34f60ec43fcafd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ammon Riley <ammon.riley@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 00:21:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuwR0-0000xS-PW
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 00:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758465AbZDQWTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 18:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbZDQWTq
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 18:19:46 -0400
Received: from george.spearce.org ([209.20.77.23]:50528 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbZDQWTp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 18:19:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0537438211; Fri, 17 Apr 2009 22:19:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <cd3664ac0904171515u1e2fce41ubd34f60ec43fcafd@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116798>

Ammon Riley <ammon.riley@gmail.com> wrote:
> Add a post-tag hook, to allow notifications when a tag is created.
> The hook is given the name of the newly created tag.

Why would you want to send notifications upon creating a tag in
your local repository?

Usually a tag is only interesting when it has been sent to a shared
public repository, which is by git push, and thus is caught by a
git receive-pack hook like post-update or post-receive.

> +HOOKS
> +-----
> +This command can run the `post-tag` hook. See linkgit:githooks[5]
> +for more information.
...
> +post-tag
> +--------
> +
> +This hook is invoked by 'git-tag'.  It takes one parameter, the name
> +of the tag, and is invoked after a tag is made.
> +
> +This hook is meant primarily for notification, and cannot affect
> +the outcome of 'git-tag'.

-- 
Shawn.
