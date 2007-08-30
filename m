From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Git.pm: Add remote_refs() git-ls-remote frontend
Date: Thu, 30 Aug 2007 10:39:41 +0200
Organization: At home
Message-ID: <fb5vod$vvc$1@sea.gmane.org>
References: <20070825221143.6514.22516.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 10:40:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQfZR-00048U-Ll
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 10:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932AbXH3IkG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 04:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756097AbXH3IkG
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 04:40:06 -0400
Received: from main.gmane.org ([80.91.229.2]:41747 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755093AbXH3IkE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 04:40:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IQfZB-00070G-4L
	for git@vger.kernel.org; Thu, 30 Aug 2007 10:39:53 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 10:39:53 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 10:39:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57013>

[Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org]

Petr Baudis wrote:

> Should support all the important features, I guess. Too bad that
>       git-ls-remote --heads .
>       
> is subtly different from
> 
>       git-ls-remote . refs/heads/
> 
> so we have to provide the interface for specifying both.

Why do not use git-for-each-ref or git-show-refs? If I remember correctly
they _were_ faster than git-ls-remote or git-peek-remote...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
