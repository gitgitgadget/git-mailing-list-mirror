From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Wed, 21 Jun 2006 15:30:32 +0200
Organization: At home
Message-ID: <e7bhlf$5j2$1@sea.gmane.org>
References: <e79921$u0e$1@sea.gmane.org> <46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com> <20060621130535.G2b34d382@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jun 21 15:31:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft2nk-0005gJ-ID
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 15:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWFUNbV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 09:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWFUNbV
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 09:31:21 -0400
Received: from main.gmane.org ([80.91.229.2]:35773 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932128AbWFUNbU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 09:31:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ft2nT-0005c7-TG
	for git@vger.kernel.org; Wed, 21 Jun 2006 15:31:08 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 15:31:07 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 15:31:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22271>

Dennis Stosberg wrote:

> (2) Setting %ENV has no effect on spawned processes under mod_perl,
>     so the git commands would never find the project directories.
>     My first thought was to set $GIT_DIR on the commands' command
>     lines like in open($fh, '$GIT_DIR=blah git-rev-list ...') but it
>     would lead to an extra shell being spawned on every invocation
>     of a git command.
> 
>     So I added the possibility to set/override the path to the
>     repository with a command line parameter.  For simplicity I
>     handled that parameter in git.c.  The drawbacks are that it has
>     to be given before the command name and that it won't work when
>     commands are invoked as "git-command".

So now you have extra git redirector being spawned, instead of extra shell
being spawned. I wonder if using 'env' wouldn't be simplier, and how
portable 'env' is.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
