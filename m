From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links
Date: Wed, 26 Apr 2006 10:44:03 +0200
Organization: At home
Message-ID: <e2nbrl$p6l$1@sea.gmane.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain> <7vwtde2q1z.fsf@assigned-by-dhcp.cox.net> <444EAE7C.5010402@vilain.net> <e2mv30$k08$1@sea.gmane.org> <e2n01t$m8j$1@sea.gmane.org> <7vzmi8sxt1.fsf_-_@assigned-by-dhcp.cox.net> <e2n4am$1vn$1@sea.gmane.org> <7vlktssudl.fsf_-_@assigned-by-dhcp.cox.net> <e2n72h$aqe$1@sea.gmane.org> <7virowrd1y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Apr 26 10:44:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYfd9-0003UE-1u
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 10:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWDZIoE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 04:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWDZIoD
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 04:44:03 -0400
Received: from main.gmane.org ([80.91.229.2]:24243 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751243AbWDZIoC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Apr 2006 04:44:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYfcl-0003S6-ES
	for git@vger.kernel.org; Wed, 26 Apr 2006 10:43:51 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 10:43:51 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Apr 2006 10:43:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19193>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> BTW. I have lately stumbled upon (somewhat Vault and Subversion biased)
>>  http://software.ericsink.com/Beyond_CheckOut_and_CheckIn.html
>> Read about Share and Pin -- it's about subprojects (when you edit out the
>> flawed "branch as folder" approach of author).

By the way I mentioned this link only because it *might* be interesting what
others need subproject support for and how others think of it and implement
it.

> Not really.  You can easily do that by checking out another
> project in a separate subdirectory.
> 
> My private working area for git.git is structured like this:
> 
> /home/junio/git.junio/.git
>         Makefile
>                               COPYING
>                               Documentation/
>                               ...
>                               Meta/.git
>                               Meta/TODO
>                               Meta/Make
>                               Meta/TO
>                               Meta/WI
>                               ...
> 
> Notice two .git directories?  That's right.
[...] 
> Meta/.git is a separate repository that is a clone of "todo"
> branch of git.git repository.  The top-level .git repository
> does not even have "todo" branch.  I just happen to push into
> the same public repository git.git at kernel.org from these two
> separate repositories.

And top-level .git repository is told to ignore Meta directory?

Interesting idea...

-- 
Jakub Narebski
Warsaw, Poland
