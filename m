X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Fri, 27 Oct 2006 13:41:56 +0200
Message-ID: <4541F084.2020802@op5.se>
References: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl>	 <4541D291.5020205@op5.se> <8fe92b430610270349k36a39250i7173282aa81c04e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 11:43:04 +0000 (UTC)
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org,
	bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <8fe92b430610270349k36a39250i7173282aa81c04e7@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30324>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdQ6A-0008AZ-SO for gcvg-git@gmane.org; Fri, 27 Oct
 2006 13:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751744AbWJ0LmB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 07:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWJ0LmB
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 07:42:01 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:37842 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751744AbWJ0LmA (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 07:42:00 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 8F49D6BE78; Fri,
 27 Oct 2006 13:41:58 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 810E36BE51; Fri, 27 Oct 2006 13:41:56 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> On 10/27/06, Andreas Ericsson <ae@op5.se> wrote:
>> Horst H. von Brand wrote:
>>> Jakub Narebski <jnareb@gmail.com> wrote:
>>>
>>> [...]
>>>
>>>> I'd rather split "Supports Renames" into engine part (does SCM
>>>> remember/detect that rename took place _as_ rename, not remember/detect
>>>> it as copiying+deletion; something other than rename) and user 
>>>> interface
>>>> part: can user easily deal with renames (this includes merging and
> viewing file
>>>> history).
>>>
>>> I think that what to tool does in its guts is completely irrelevant, 
>>> what
>>> is important is what the user sees. Sadly, it seems hard to describe
>>> exactly what is meant/wanted here.
>>
>> Agreed. I'd rather make the definition "Can users, after a rename has
>> taken place, follow the history of the file-contents across renames?".
>> Mainly because this is clearly unambiguous, doesn't involve
>> implementation details and only weighs what really counts: User-visible
>> capabilities.
> 

[...]

> But equally important for user is another question related to
> "Supporting Renames".
> Namely detection of renames during merge and detection of conflict 
> during merge
> is what I would consider minimal "Merge Renames Support". Causing 
> information
> to be lost is having no "Merge Renames Support". To have "Yes" in this
> column SCM
> have to resolve conflict at least in obvious cases, and "Yes!" if it
> can remember
> resolution of merge conflict involving renames ;-).
> 

True.

>> IMNSHO, I'd rather have all the features in the list be along the lines
>> of "Can users/admins/random-boon do X?" and instead of "yes/no" list the
>> number of commands/the amount of time required to achieve the desired
>> effect. This would set a clear limit and put most terminology issues out
>> of the way.
> 
> This would make the comparison table less clear, unfortunately.
> 

True that. Perhaps just stick with Yes/No and have a timing table to 
compare merge times, multi-parent merge times and stuff like that.

> 
>>> [...]
>>>
>>>> 19. Ease of Use. Hmmm... I don't know for Git. I personally find it 
>>>> very
>>>> easy to use, but I have not much experiences with other SCM. I 
>>>> wonder why
>>>> Bazaar has "No" there...
>>>
>>> Extremely subjective. Easy to learn doesn't cut it either.
>>
>> This one just needs to go. Could possibly be replaced with "Has
>> tutorial/documentation online" or some such. No SCM is really intuitive
>> to users that haven't experienced any of them before, so the only thing
>> that really matters is how much documentation one can find online and
>> how up-to-date it is.
> 
> For example SCM can be easy to use but at the cost of simplifications
> and limited useness.
> 
> On the other side basic concept behind some SCM might be more
> or less understandable...

Yes, but it will always be based on personal opinion and that's why it 
can never be measured in an unbiased way. It would be like playing 
Trivial Pursuit and getting the question "Which 20'th century author 
wrote the best books?". There's actually two problems with that 
question, but the important one is that it can't be answered correctly 
in this wonderful world we live in where everyone has their own opinion.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
