From: "Lasse Kliemann" <lasse-gmane-git-2009@mail.plastictree.net>
Subject: Re: gitosis: how to create absolutely empty repos
Date: Thu, 26 Feb 2009 11:54:20 +0000 (UTC)
Message-ID: <go5vtc$3dj$1@ger.gmane.org>
References: <go47ma$5n8$1@ger.gmane.org> <200902261023.46700.trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 12:56:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LceqS-00087d-Oi
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 12:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbZBZLyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 06:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753259AbZBZLyh
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 06:54:37 -0500
Received: from main.gmane.org ([80.91.229.2]:37136 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312AbZBZLyg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 06:54:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lceov-0003aK-Sj
	for git@vger.kernel.org; Thu, 26 Feb 2009 11:54:29 +0000
Received: from h1283867.stratoserver.net ([85.214.127.6])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 11:54:29 +0000
Received: from lasse-gmane-git-2009 by h1283867.stratoserver.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 11:54:29 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: h1283867.stratoserver.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111555>

Thomas Rast <trast@student.ethz.ch> writes:

Thank you for your reply!

> You can do "anything" to the repository and gitosis will create it.
> For example, doing an invalid push will work (you'll need to do this
> in a git repository to make git-push happy, but it doesn't matter what
> it contains):
> 
>  git push gitosis@server.example.com:repo.git :master
> 
> Note that _cloning_ such a repository is only possible since 86ac751
> (Allow cloning an empty repository, 2009-01-23), which is not in any
> released version yet, but will be in 1.6.2.

Not sure if it's the same, but cloning a local repository just initialized 
with 'git init' seems to work; it only gives a warning: "warning: remote HEAD 
refers to nonexistent ref, unable to checkout." Using git version 1.6.1.3.
