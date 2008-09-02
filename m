From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Tue, 2 Sep 2008 21:43:33 +0200
Message-ID: <200809022143.33294.robin.rosenberg.lists@dewire.com>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue Sep 02 21:47:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KabqM-0006Qc-7j
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 21:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbYIBTqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 15:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbYIBTqH
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 15:46:07 -0400
Received: from av8-1-sn3.vrr.skanova.net ([81.228.9.183]:45306 "EHLO
	av8-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbYIBTqG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 15:46:06 -0400
Received: by av8-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 2232F382AB; Tue,  2 Sep 2008 21:46:04 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av8-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 0155F3827F; Tue,  2 Sep 2008 21:46:04 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id B977D37E43;
	Tue,  2 Sep 2008 21:46:02 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94696>

tisdagen den 2 september 2008 21.31.45 skrev Pieter de Bie:
> Sometimes I work on a detached HEAD and then forget about it. If I then create
> some commits and checkout another branch, I have to dig through my reflog to
> find the older commits. I know that "git commit" adds has a "Not currently on
> any branch", but it's not very noticeable and also doesn't work when you
> specify a commit message on the command line.
> 
> I suggest to add some extra output to the STDOUT after a commit if we're on a
> detached HEAD. The quick patch below adds output like:
> 
> Vienna:git pieter$ ./git commit --allow-empty -m"test"
> Created commit 6ce62c8b: test
> You are on a detached head, so this commit has not been recorded in a branch.
> If you don't want to lose this commit, checkout a branch and then run:
> 	git merge 6ce62c8bfcfb341106f3587d1c141c3955c2544c
> 
> Are there any comments to this / strong opinions against such a change?

Probably doesn't hurt, but I think you should enable the git prompt. That will
give you notice before committing.

-- robin
