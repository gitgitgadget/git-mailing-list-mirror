From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] rebase -i: support single-letter abbreviations for the
 actions
Date: Sat, 29 Sep 2007 23:13:47 +0200
Message-ID: <46FEC00B.7050208@qumranet.com>
References: <Pine.LNX.4.64.0709290231300.28395@racer.site> <46FE7D0B.4060806@qumranet.com> <Pine.LNX.4.64.0709292156090.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 29 23:14:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibjdd-0008K8-FI
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 23:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbXI2VOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 17:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753606AbXI2VOF
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 17:14:05 -0400
Received: from il.qumranet.com ([82.166.9.18]:35105 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753520AbXI2VOE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 17:14:04 -0400
Received: from [10.64.7.42] (unknown [10.64.7.42])
	by il.qumranet.com (Postfix) with ESMTP id E923925028F;
	Sat, 29 Sep 2007 23:14:12 +0200 (IST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0709292156090.28395@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59492>

Johannes Schindelin wrote:
> Hi,
>
> On Sat, 29 Sep 2007, Avi Kivity wrote:
>
>   
>> Johannes Schindelin wrote:
>>     
>>> When you do many rebases, you can get annoyed by having to type out 
>>> the actions "edit" or "squash" in total.
>>>
>>> This commit helps that, by allowing you to enter "e" instead of 
>>> "edit", or "s" instead of "squash", and it also plays nice with 
>>> "merge" or "amend" as synonyms to "squash".
>>>       
>> Can we make "amend" like squash, except that it keeps the first commit's 
>> authorship instead of the second?  I often merge a commit with some 
>> minor fix that comes later, and usually want to keep the original author 
>> record.
>>     
>
> I do not necessarily think it is not doable, but I have different 
> suggestion to you:
>
> If you amend the commit with a minor fix that comes later, why not do 
> "rebase -i" _before_ applying the fix, and then using "edit" on the 
> respective commit?
>   

This is what I do now.  Edit the commit, cherry-pick -n, and commit 
--amend.  But it's less pleasant than using the rebase --interactive 
interface.

[This is part of the workflow to prepare a patchset for submitting 
upstream; I don't edit commits on my master branch]

> That way you can even test the result easily, which you cannot do with 
> "squash".
>   

Usually these are trivial fixes, and have already been tested by being 
included in my main branch.

-- 
Any sufficiently difficult bug is indistinguishable from a feature.
