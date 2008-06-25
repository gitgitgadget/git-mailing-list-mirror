From: "David Jeske" <jeske@willowmail.com>
Subject: Re: policy and mechanism for less-connected clients
Date: Wed, 25 Jun 2008 21:34:16 -0000
Message-ID: <1784.50359167091$1214430241@news.gmane.org>
References: <willow-jeske-01l6XqjOFEDjC=91jv>
	<willow-jeske-01l6@3PlFEDjCVAh-01l6XqjPFEDjCY6P>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>, git@vger.kernel.org
To: "David Jeske" <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 23:43:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBcm3-0001sx-Vv
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 23:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbYFYVm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 17:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752760AbYFYVm1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 17:42:27 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60627 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752770AbYFYVm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 17:42:27 -0400
Received: (qmail 4325 invoked by uid 90); 25 Jun 2008 21:42:21 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Wed, 25 Jun 2008 21:34:16 -0000
In-Reply-To: <willow-jeske-01l6XqjOFEDjC=91jv>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86356>

Some answers thanks to Jakub...

-- David Jeske wrote:
> : "ncvs up" ->
> :
> : git stash; git pull; git apply;
> : git diff --stat <baseof:current branch> - un-pushed filenames
> : git-show-branch <current branch> - un-pushed comments
>
> Question: when I say "baseof:current branch", I mean "the common-ancestor
> between my local-repo tracking branch and the remote-repo branch it's
> tracking". How do I find that out?

I'm told I need...

git diff --stat `git-merge-base HEAD ORIG_HEAD`

> : "ncvs commit" -> "git commit; git push <only this branch>;"
>
> Question: how do I only push the branch I'm on? "eg" says it does this, but
> from a quick look at the code, it wasn't obvious to me how.

and...

git push HEAD


which just leaves this one....

Question: How do I create a branch on a remote repo when I'm on
my local machine, without sshing to it?
