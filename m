From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Problems pushing???
Date: Sun, 8 Jul 2012 15:02:45 +0400
Message-ID: <20120708110244.GA14518@localhost.localdomain>
References: <1341738766823-7562695.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: pbGit <pblakeley@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 13:02:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnpGT-0001VZ-VS
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jul 2012 13:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab2GHLCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jul 2012 07:02:52 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:33509 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab2GHLCv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 07:02:51 -0400
Received: from proxysrv.domain007.com ([10.8.0.42])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q68B2kLL021620;
	Sun, 8 Jul 2012 15:02:47 +0400
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id CA392B20158; Sun,  8 Jul 2012 15:02:45 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <1341738766823-7562695.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201173>

On Sun, Jul 08, 2012 at 02:12:46AM -0700, pbGit wrote:

>   I have installed git locally to my machine.  It is running mac os lion. 
> This is intended to be the remote machine too. I have followed, what I think
> is the correct way to do this, using 
> http://www.petermac.com/setup-git-local-and-remote-repositories/ this .  All
> seemed to be ok until I tried to push.  When I try the following command.
> 
> git push --all --repo=<project>
> 
> I get the following output
> 
> Counting objects: 12, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (11/11), done.
> Writing objects: 100% (12/12), 5.23 KiB, done.
> Total 12 (delta 1), reused 0 (delta 0)
> remote: error: refusing to update checked out branch: refs/heads/master
[...]
> Hope someone can help with this because I have spent a bit of time trying to
> solve this and still stuck!!!
Becasue pushing to a so-called "non-bare" repository (this is a "normal"
repository, in which there is a work tree) either has no sense or
requires extra steps to reconcile the results of pushing with the
repository's work tree.  Most probably you should reconsider your
workflow.

Read [1] for an in-depth explanation.
Googling for "receive.denyCurrentBranch" will also provide you with
a number of useful links (such as stackoverflow discussions).

1. http://sitaramc.github.com/concepts/bare.html
