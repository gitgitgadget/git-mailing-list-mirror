From: Andreas Ericsson <ae@op5.se>
Subject: Re: cvs importer woes
Date: Tue, 27 Jun 2006 12:49:43 +0200
Message-ID: <44A10D47.3060708@op5.se>
References: <44A102F0.9090604@op5.se> <46a038f90606270342k2288cc2ds34ae05e089b8c906@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 27 12:49:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvB8e-0001Sq-Hf
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 12:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbWF0Ktp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 06:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933074AbWF0Ktp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 06:49:45 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:44722 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932694AbWF0Kto
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 06:49:44 -0400
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id ABC226BCBC; Tue, 27 Jun 2006 12:49:43 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606270342k2288cc2ds34ae05e089b8c906@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22726>

Martin Langhoff wrote:
> On 6/27/06, Andreas Ericsson <ae@op5.se> wrote:
> 
>> Sadly, the cvsimport command no longer works to create new repositories
>> from scratch.
> 
> 
> We are seeing some breakage in cvsimport that started with a patch of mine:
> 
> 8f732649bc4d5619a1b399e5808b3f4c662ad200 cvsimport: keep one index
> per branch during import
> 

I experimented a bit with that one too, but it worked for my (very 
small, no branches, no tags) cvs repo

> 
>> The culprit is definitely 061303f0b50a648db8e0af23791fc56181f6bf93.
>>
>> Any perl-literate takers? Otherwise, just reverting the patch makes
>> things work (for me) again.
> 
> 
> Don't just revert that patch, unless I'm wrong there is some subtle
> branch-creation breakage too.
> 

Dscho's patch on top of 061303f0b works wonders. Thanks all the same though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
