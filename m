From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 09 Jun 2006 22:44:48 +0200
Organization: At home
Message-ID: <e6cmjn$no5$1@sea.gmane.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> <9e4733910606091113vdc6ab06l2d3582cb82b8fd09@mail.gmail.com> <Pine.LNX.4.64.0606091158460.5498@g5.osdl.org> <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 09 22:45:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fonqu-00064l-7K
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 22:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbWFIUpD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 16:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965200AbWFIUpB
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 16:45:01 -0400
Received: from main.gmane.org ([80.91.229.2]:56510 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965171AbWFIUpA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 16:45:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fonqd-00060u-Uy
	for git@vger.kernel.org; Fri, 09 Jun 2006 22:44:51 +0200
Received: from 212-87-13-71.sds.uw.edu.pl ([212.87.13.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 22:44:51 +0200
Received: from jnareb by 212-87-13-71.sds.uw.edu.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 22:44:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212-87-13-71.sds.uw.edu.pl
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21554>

Jon Smirl wrote:

> Martin has also brought up the problem with needing a partial clone so
> that everyone doesn't have to bring down the entire repository. A
> trunk checkout is 340MB and Martin's git tree is 2GB (mine 2.7GB).  A
> kernel tree is only 680M.

Partial/shallow nor lazy clone we don't have (although there might be some
shallow clone partial solutions in topic branches and/or patches flying
around in git mailing list). Yet.

But you can do what was done for Linux kernel: split repository into current
and historical, and you can join them (join the history) if needed using
grafts. And even if one need historical repository, it is neede to
clone/copy only _once_. With alternatives (using historical repository as
one of alternatives for current repository) someone who has both
repositories does need only a little more space, I think, than if one used
single repository.

-- 
Jakub Narebski
Warsaw, Poland
