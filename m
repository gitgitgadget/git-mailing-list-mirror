From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] add -C[NUM] to git-am
Date: Thu, 08 Feb 2007 09:35:48 +0100
Organization: At home
Message-ID: <eqena5$fb5$2@sea.gmane.org>
References: <7vejp17m3t.fsf@assigned-by-dhcp.cox.net> <20070207211910.GK12140@mellanox.co.il> <7vfy9h13yu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 09:35:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF4kN-0003Yn-Hn
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 09:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422859AbXBHIfL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 03:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422981AbXBHIfL
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 03:35:11 -0500
Received: from main.gmane.org ([80.91.229.2]:58806 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422859AbXBHIfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 03:35:09 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HF4kA-0001nB-Ti
	for git@vger.kernel.org; Thu, 08 Feb 2007 09:35:02 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 09:35:02 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 09:35:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39048>

Junio C Hamano wrote:

> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> 
>>> Quoting r. Junio C Hamano <junkio@cox.net>:
>>> 
>>> FWIW, I am in favor although I do not foresee myself ever using
>>> it.  However, this has slight ramifications.
>>> 
>>>  - we will be keeping applymbox after all.  shouldn't this be
>>>    side-ported to it?
>>
>> OK.
>>
>>>  - am is used as a workhorse for rebase.  shouldn't this be
>>>    accessible through its command line as well?
>>
>> How will it be used?
> 
> Although I do not foresee myself using -C<num> that applies to
> the whole series inexactly for "git am" to begin with, I would
> imagine somebody who wants to say "git am -C1" may want to say
> something like "git rebase -C1 origin/master",

What about "git rebase --merge"? 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
