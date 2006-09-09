From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/7] gitweb: Trying to improve history view speed
Date: Sat, 09 Sep 2006 11:24:53 +0200
Organization: At home
Message-ID: <edu180$vvs$1@sea.gmane.org>
References: <200609061504.40725.jnareb@gmail.com> <edtuot$p76$2@sea.gmane.org> <7vvenxwglc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Sep 09 11:24:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLz4k-0006KZ-TL
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 11:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWIIJYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 05:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWIIJYa
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 05:24:30 -0400
Received: from main.gmane.org ([80.91.229.2]:60569 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751403AbWIIJYa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 05:24:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLz4d-0006JC-MD
	for git@vger.kernel.org; Sat, 09 Sep 2006 11:24:27 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 11:24:27 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 11:24:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26741>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Jakub Narebski wrote:
>>
>>> Shortlog:
>>>  [PATCH 1/7] gitweb: Make pickaxe search a feature
>>>  [PATCH 2/7] gitweb: Paginate history output
>>>  [PATCH 3/7] gitweb: Use @hist_opts as git-rev-list parameters
>>>              in git_history
>>>  [PATCH 4/7] gitweb: Add parse_rev_list for later use
>>>  [PATCH 5/7] gitweb: Use parse_rev_list in git_shortlog and git_history
>>>  [PATCH 6/7] gitweb: Assume parsed revision list in git_shortlog_body
>>>              and git_history_body
>>>  [PATCH 7/7] gitweb: Set page to 0 if it is not defined, in git_history

> I do not know about 4, 5 and 6.  I didn't look at them at all
> the first time you sent them out, since I got an impression that
> you did not understand how git-rev-list was supposed to work
> when you did them.
> 
> Now Linus explained it to you, I suspect they would probably
> need to be rethought?

Well, first they don't offer that much of speed improvement even for the
first page of output. And probably would be slower than current
implementation for the next-to-last, or the last page. So yes, patches 4-6
are to be rethought, if not dropped at all.   

By the way, what do you all do with the "failed experiments", to have them
saved somewhere, but to not make trouble for normal operations?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
