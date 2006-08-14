From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
Date: Mon, 14 Aug 2006 12:49:45 +0200
Organization: At home
Message-ID: <ebpket$7dt$1@sea.gmane.org>
References: <7vzme7g8wt.fsf@assigned-by-dhcp.cox.net> <20060814063309.GD21963@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Aug 14 12:49:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCa0Y-00083q-Nd
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 12:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbWHNKtL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 06:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbWHNKtL
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 06:49:11 -0400
Received: from main.gmane.org ([80.91.229.2]:58064 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751983AbWHNKtK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 06:49:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GCa0J-00081c-ER
	for git@vger.kernel.org; Mon, 14 Aug 2006 12:49:07 +0200
Received: from host-81-190-23-158.torun.mm.pl ([81.190.23.158])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 12:49:07 +0200
Received: from jnareb by host-81-190-23-158.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 12:49:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-158.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25348>

Michael S. Tsirkin wrote:

> Quoting r. Junio C Hamano <junkio@cox.net>:
[...]
>> I have been hesitant to claim that it does not make any sense to
>> use more than one tracking branch for the same remote branch,
>> because the only reason I might say so is because I haven't
>> thought of a good usage pattern to do so.
>> 
>> But apparently you do use more than one local branch to keep
>> track of one remote branch.  How do you use it for?  Do you feel
>> it is a good feature to be able to do that, or do you think it
>> is just a mistake and more sensible error message is what we
>> would really want?
>> 
> 
> Well, what I was *trying* to do is simply add a more descriptive name for
> the linus master branch to my existing tree.
> So it seemed like an obvious idea to add
> 
> Pull: master:origin
> Pull: master:linus_master

Couldn't you do this via symlinks or symrefs? 

BTW. Do we support symrefs other than HEAD, and does reflog works with
symref heads, and symlinked heads?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
