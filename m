From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Clone with local alternates?
Date: Wed, 19 Apr 2006 03:36:06 -0600
Message-ID: <m1vet5oqk9.fsf@ebiederm.dsl.xmission.com>
References: <1145404132.16166.97.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 11:38:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW98J-0003da-2K
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 11:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWDSJhz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 05:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWDSJhz
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 05:37:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8069 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750830AbWDSJhy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 05:37:54 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k3J9a8X0017375;
	Wed, 19 Apr 2006 03:36:08 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k3J9a7Gk017374;
	Wed, 19 Apr 2006 03:36:07 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1145404132.16166.97.camel@shinybook.infradead.org> (David
 Woodhouse's message of "Wed, 19 Apr 2006 00:48:51 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18914>

David Woodhouse <dwmw2@infradead.org> writes:

> Often I want to clone a remote repository but would like to use an
> existing local source tree as 'alternates'. 
>
> One way of doing this is to clone the local tree with 'git-clone -l -s',
> find the latest common commit shared with the remote tree to be fetched,
> revert to that with 'git-reset --head $last' and then pulling from the
> remote. 

Simpler than the git-reset you can simply do 
git-fetch remote branch:branch and git will find common ancestor
for you and create a new branch that mirrors the old one.

I mention this because it can be interesting to have branches
from several remote repositories all in one local repository.

Eric
