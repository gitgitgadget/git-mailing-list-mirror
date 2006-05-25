From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: importing cvs logical modules
Date: Thu, 25 May 2006 06:56:12 +0200
Organization: At home
Message-ID: <e53ddc$ol1$1@sea.gmane.org>
References: <93c3eada0605242148u4656bc31p96d84a16703f0fe0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu May 25 06:56:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj7tj-0008O5-Qr
	for gcvg-git@gmane.org; Thu, 25 May 2006 06:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWEYE4d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 00:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWEYE4d
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 00:56:33 -0400
Received: from main.gmane.org ([80.91.229.2]:60549 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965024AbWEYE4c (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 00:56:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fj7ta-0008Mk-81
	for git@vger.kernel.org; Thu, 25 May 2006 06:56:26 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 May 2006 06:56:26 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 May 2006 06:56:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20725>

Geoff Russell wrote:

> Then to join the git repositories together in the desired way. I think
> this would be generally useful and not just solve my problem.
> 
> e.g. Suppose I have 3 git repositories: Progs, xxxx, yyyy
> 
>            Progs/.git
>            xxxx/.git
>            yyyy/.git
> 
> I'd like to make 1 git repository Progs with xxxx and yyyy as child trees.
> 
>            Progs/.git
>            Progs/xxxx
>            Progs/yyyy
> 
> Does this sound useful to anyone else, or is it already possible?

It is done. TODO branch in git.git repository on kernel.org is pushed to
from *separate* git-todo.git repository. BTW. working are of repositories
can be joined (although it needs entry in .gitignore):

   Progs/.git
   Progs/TODO/.git

-- 
Jakub Narebski
Warsaw, Poland
