X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Fri, 27 Oct 2006 11:34:09 +0200
Message-ID: <4541D291.5020205@op5.se>
References: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 09:34:31 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30315>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdO6Y-0000Aj-Tv for gcvg-git@gmane.org; Fri, 27 Oct
 2006 11:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946263AbWJ0JeN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 05:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946264AbWJ0JeN
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 05:34:13 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:57803 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1946263AbWJ0JeM (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 05:34:12 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 7A7D56BD40; Fri,
 27 Oct 2006 11:34:11 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 122346BCEC; Fri, 27 Oct 2006 11:34:10 +0200 (CEST)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

Horst H. von Brand wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> 
> [...]
> 
>> I'd rather split "Supports Renames" into engine part (does SCM
>> remember/detect that rename took place _as_ rename, not remember/detect it
>> as copiying+deletion; something other than rename) and user interface part:
>> can user easily deal with renames (this includes merging and viewing file
>> history).
> 
> I think that what to tool does in its guts is completely irrelevant, what
> is important is what the user sees. Sadly, it seems hard to describe
> exactly what is meant/wanted here.
> 

Agreed. I'd rather make the definition "Can users, after a rename has 
taken place, follow the history of the file-contents across renames?". 
Mainly because this is clearly unambiguous, doesn't involve 
implementation details and only weighs what really counts: User-visible 
capabilities.

IMNSHO, I'd rather have all the features in the list be along the lines 
of "Can users/admins/random-boon do X?" and instead of "yes/no" list the 
number of commands/the amount of time required to achieve the desired 
effect. This would set a clear limit and put most terminology issues out 
of the way.

> 
>> 13. Plugins. I would put "Somewhat" here, or "Scriptable" in the "Somewhat"
>> or "?" background color for Git. And add note that it is easy to script up
>> porcelanish command, and to add another merge strategy. There also was
>> example plugin infrastructure for Cogito, so I'd opt for "Someahwt"
>> marking.
> 
> Mostly an implementation detail for "extensible"...
> 

Yup. Any fast-growing SCM can clearly be said to be "extensible", 
otherwise it wouldn't be extended ;-)

> [...]
> 
>> 19. Ease of Use. Hmmm... I don't know for Git. I personally find it very
>> easy to use, but I have not much experiences with other SCM. I wonder why
>> Bazaar has "No" there...
> 
> Extremely subjective. Easy to learn doesn't cut it either.

This one just needs to go. Could possibly be replaced with "Has 
tutorial/documentation online" or some such. No SCM is really intuitive 
to users that haven't experienced any of them before, so the only thing 
that really matters is how much documentation one can find online and 
how up-to-date it is.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
