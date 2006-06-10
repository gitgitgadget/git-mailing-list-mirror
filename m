From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] shared repository settings enhancement.
Date: Sat, 10 Jun 2006 03:38:38 +0200
Organization: At home
Message-ID: <e6d7qk$64r$1@sea.gmane.org>
References: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com> <7virnam435.fsf@assigned-by-dhcp.cox.net> <7vver9lu8g.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606091743410.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Jun 10 03:38:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FosR0-0008AK-Tk
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 03:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWFJBik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 21:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWFJBik
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 21:38:40 -0400
Received: from main.gmane.org ([80.91.229.2]:13212 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932366AbWFJBij (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 21:38:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FosQw-0008A2-BB
	for git@vger.kernel.org; Sat, 10 Jun 2006 03:38:38 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jun 2006 03:38:38 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jun 2006 03:38:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21580>

Linus Torvalds wrote:

> 
> 
> On Fri, 9 Jun 2006, Junio C Hamano wrote:
>>
>> This lets you say:
>> 
>>      [core]
>>              sharedrepository = 075
> 
> I really think it's better to express this as some more traditional 
> number.
> 
> I had to think about what 075 meant, while saying
> 
>       [core]
>               sharedrepository = 0644

Yet another solution would be to actually set umask.

-- 
Jakub Narebski
Warsaw, Poland
