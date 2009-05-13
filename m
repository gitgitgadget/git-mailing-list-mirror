From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: switching upstream tips
Date: Wed, 13 May 2009 09:57:18 +0200
Message-ID: <4A0A7D5E.1010909@viscovery.net>
References: <4A0A6BD1.7050907@gmail.com>	 <81b0412b0905130019x114d53d1v86833217bff613bc@mail.gmail.com>	 <4A0A777E.7080506@gmail.com> <81b0412b0905130041t327ef5f2m3b6d1dfac51fc1b1@mail.gmail.com> <4A0A7BA1.4030500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 09:57:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M49LG-00039D-NF
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 09:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbZEMH5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 03:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbZEMH5V
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 03:57:21 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:18566 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbZEMH5V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 03:57:21 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M49L4-0002pt-Q6; Wed, 13 May 2009 09:57:19 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7610754D; Wed, 13 May 2009 09:57:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A0A7BA1.4030500@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118997>

Ittay Dror schrieb:
> Alex Riesen wrote:
>> 2009/5/13 Ittay Dror <ittay.dror@gmail.com>:
>>>> Alex Riesen wrote:
>>>>> * Reorder my history so that my commits are on top of the tip of
>>>>> the old
>>>>> upstream repository.
>>>>>         
>>>> Look at "git rebase -i" (interactive rebase)
>>>>       
>>> well, i was hoping for something more automatic. git rebase will list
>>> all
>>> commits without author, so i'll have to manually figure which of them is
>>> mine from the commend and reorder
>>>     
>>
>> git rebase will list only commits not on upstream (simplified).
>> Has nothing to do with author being absent.
>>   
> tried git rebase, this is what i get:
>> git rebase -i upstream master
> fatal: Needed a single revision
> Invalid base

I guess it should have been

   git rebase -i --onto new-upstream old-upstream master

That is, you take commits old-upstream..master and transplant them onto
new-upstream.

-- Hannes
