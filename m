From: Bruce Stephens brs <bruce.stephens@isode.com>
Subject: Re: How can I do an automatic stash when doing a checkout?
Date: Sun, 18 Dec 2011 11:45:55 +0000
Message-ID: <84ty4ycdcc.fsf@cenderis.demon.co.uk>
References: <jcki8u$oip$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: DeMarcus <demarcus@hotmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 18 12:52:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcFIH-0002H6-Lw
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 12:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664Ab1LRLwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 06:52:22 -0500
Received: from rufus.isode.com ([62.3.217.251]:35465 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578Ab1LRLwU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 06:52:20 -0500
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Dec 2011 06:52:20 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1324208756;
 d=isode.com; s=selector; i=@isode.com;
 bh=QdUpKdlWCdiBbYmQEk8INHDKB+MtINglA6x2yq20qa4=;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
  In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
  Content-ID:Content-Description;
 b=EIUCq5nBZLriwAAoChTEBVhaFS3fDzU45pcdZ56ez2LzJJxh8RBPSb4cCxHepd/oUgK1A5
	0tMgd4ALJc/6terR99DxtdMK6X+txa59zirzYdi+CZXvzk0cakule+ff4yMcQLTec7jczh
	+Rac/zB+hf+06YGX2/O81j/mlsh7tqE=;
Received: from cenderis.isode.com (cenderis.demon.co.uk [62.49.17.254]) 
          by rufus.isode.com (submission channel) via TCP with ESMTPA 
          id <Tu3ScwBaK8Vh@rufus.isode.com>; Sun, 18 Dec 2011 11:45:56 +0000
X-SMTP-Protocol-Errors: PIPELINING
X-Hashcash: 1:20:111218:demarcus@hotmail.com::YQOku0olPAEs+YnF:000000000000000000000000000000000000000002DoI
X-Hashcash: 1:20:111218:git@vger.kernel.org::f8uuHXC03S6a1p4V:0000000000000000000000000000000000000000002bAm
In-Reply-To: <jcki8u$oip$1@dough.gmane.org> (demarcus@hotmail.com's message of
	"Sun, 18 Dec 2011 12:19:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187419>

DeMarcus <demarcus@hotmail.com> writes:

[...]

> This is not how it works with git, where when I want to change branch
> I have to do a git checkout. However, that leaves all the modified and
> untracked files in the directory of the branch I switched to. This is
> seldom the behavior I want.
>
> With the git stash command I can clean the directory the way I want
> but the stash command is not connected to a particular branch.
>
> Is there a way to have git checkout do an automatic stash when doing a
> checkout to another branch, and then do an automatic git stash apply
> with the correct stash when changing back to the previous branch
> again?

You probably don't want to use stash. Just commit whatever partial work
you've done.

You could also just checkout different branches in different
directories. Nothing wrong with doing that in git.

[...]
