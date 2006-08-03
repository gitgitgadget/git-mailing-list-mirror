From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Creating diffs
Date: Thu, 03 Aug 2006 14:39:47 +0200
Organization: At home
Message-ID: <easqpi$o51$1@sea.gmane.org>
References: <20060803122937.GI5016@robert.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 03 14:40:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8cUc-0003ES-Ea
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 14:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWHCMj5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 08:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWHCMj5
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 08:39:57 -0400
Received: from main.gmane.org ([80.91.229.2]:17625 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932426AbWHCMj4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 08:39:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G8cUF-00037g-0L
	for git@vger.kernel.org; Thu, 03 Aug 2006 14:39:39 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Aug 2006 14:39:39 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Aug 2006 14:39:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24722>

Rocco Rutte wrote:

> However, when I do:
> 
>    $ git diff source:file dest:file
> 
> I get:
> 
>    --- a/source:file
>    +++ b/source:file
> 
> But I'd like to drop the branchname. Can I do that without filtering 
> everything through sed(1)?

If I remember correctly there were two patches which solved it differently:
one gave

   --- a/source:file
   +++ b/dest:file

second (and I guess it is better solution)

   --- a/file
   +++ b/file

Unfortunately they seem unapplied...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
