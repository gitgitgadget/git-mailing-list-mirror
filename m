From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Git Submodule would not work. The push does not work
Date: Fri, 29 Jun 2012 05:36:10 +0200
Message-ID: <1340940970.21992.1.camel@centaur.cmartin.tk>
References: <1340924055050-7562323.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: salmanmanekia <salmanmanekia@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 05:36:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkS0M-0007NV-Bw
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 05:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737Ab2F2DgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 23:36:13 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:55505 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754296Ab2F2DgK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 23:36:10 -0400
Received: from [192.168.1.2] (brln-4d0c2572.pool.mediaWays.net [77.12.37.114])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id A749146149;
	Fri, 29 Jun 2012 05:36:04 +0200 (CEST)
In-Reply-To: <1340924055050-7562323.post@n2.nabble.com>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200802>

On Thu, 2012-06-28 at 15:54 -0700, salmanmanekia wrote:
> I have been trying to create a submodule in git After issuing the git
> submodule init i see the folders for the submodule. After that i add, commit
> and try to push those files in the master repo but it would not allow me to
> do soo

This doesn't seem to be related to submodules.

> 
> Salman@PC_HOME ~/git/breakit-web-app (master)
> $ git push origin master
> error: refs/heads/master does not point to a valid object! 
> Counting objects: 4, done.
> Delta compression using up to 2 threads.
> Compressing objects: 100% (3/3), done.
> Writing objects: 100% (3/3), 421 bytes, done.
> Total 3 (delta 1), reused 0 (delta 0)
> remote: bb/acl: salmanmanekia is allowed. accepted payload.
> error: Ref refs/heads/master is at 6a47a0fd398610a75bdab8976f842dc0efd89f86
> but expected 00000000000000000000000000000000000000000
> remote: error: failed to lock refs/heads/master
> 
> To ssh://git@bitbucket.org/majuri/breakit-web-app.git
> ! [remote rejected] master -> master (failed to lock)
> error: failed to push some refs to
> 'ssh://git@bitbucket.org/majuri/breakit-web-app.git'

There error messages come from a hook being run on the bitbucket
servers. They're the only ones who can know what they mean and how to
solve it.

   cmn
