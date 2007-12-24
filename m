From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] Document git rev-list --first-parent
Date: Mon, 24 Dec 2007 11:40:52 +0200
Message-ID: <476F7EA4.1030001@qumranet.com>
References: <1198484450-16454-1-git-send-email-avi@qumranet.com>	<7v3atstry4.fsf@gitster.siamese.dyndns.org>	<476F6F95.1030506@qumranet.com> <7vprwwsbey.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 10:41:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6joI-0002j9-CZ
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 10:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbXLXJkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 04:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbXLXJky
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 04:40:54 -0500
Received: from il.qumranet.com ([82.166.9.18]:57888 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbXLXJky (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 04:40:54 -0500
Received: from balrog.qumranet.com (balrog.qumranet.com [10.0.57.202])
	by il.qumranet.com (Postfix) with ESMTP id E4582A0009;
	Mon, 24 Dec 2007 11:40:52 +0200 (IST)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7vprwwsbey.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69209>

Junio C Hamano wrote:
> Avi Kivity <avi@qumranet.com> writes:
>
>   
>> Junio C Hamano wrote:
>>     
>>> Avi Kivity <avi@qumranet.com> writes:
>>>
>>>       
>>>> Document git rev-list's --first-parent option.  Documentation taken from
>>>> git log.
>>>> ...
>>>> +--first-parent::
>>>> +	Follow only the first parent commit upon seeing a merge
>>>> +	commit.  This  option gives a better overview of the
>>>> +	evolution of a particular branch.
>>>> +
>>>>
>>>>         
>>> I am afraid that this description is not sufficient.  The
>>> history given by --first-parent is useful only in a very limited
>>> use case, and the user needs to be aware of it.
>>>       
>> I don't know which use case you are referring to...
>>     
>
> Please read the commit log message you snarfed the description
> again.
>
>   

[I assume you mean 0053e902;  I just copied the output of git log --help]

> First-parent is useful only if you are the primary integrator
> and do not fast-forward from other people.  Only in that case,
> you will see the overview of "the primary integration branch".
> Otherwise you will observe the history viewed by whoever
> happened to make a merge, which would switch every time you
> cross the fast-forward boundary.
>
>   

Well, my use case is different.  All of the development merges are 
fast-forwards (or plain patch applications); the only multiple-parent 
merges are pulls I do from the main tree in order to advance the 
baseline, or from upstream submission branches (which are very 
similar).  So, for me --first-parent means "show me actual development, 
not syncs with upstream or cleanup branches".

> Making it sound as if it always will give a better overview is
> misleading.
>   

I'll try to come up with better wording and submit a new patch.

-- 
error compiling committee.c: too many arguments to function
