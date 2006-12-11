X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Documentation/git-commit.txt
Date: Mon, 11 Dec 2006 15:58:08 +0100
Message-ID: <457D7200.6010102@op5.se>
References: <200612100011.kBA0BuTo028252@laptop13.inf.utfsm.cl> <200612100923.56707.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 14:59:35 +0000 (UTC)
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <200612100923.56707.alan@chandlerfamily.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34009>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtmcs-0007aq-AM for gcvg-git@gmane.org; Mon, 11 Dec
 2006 15:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936335AbWLKO6N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 09:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936340AbWLKO6M
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 09:58:12 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:41211 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S936335AbWLKO6K (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 09:58:10 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 1BA056BCBF; Mon, 11 Dec 2006 15:58:09 +0100 (CET)
To: Alan Chandler <alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org

Alan Chandler wrote:
> On Sunday 10 December 2006 00:11, Horst H. von Brand wrote:
>> Alan Chandler <alan@chandlerfamily.org.uk> wrote:
>>
>> [...]
>>
>>> How about the following wording here
>>>
>>> Instead of staging the content of each file immediately after
>>> changing it, you can wait until you have completed all the changes
>>> you want to make and then use the `-a` option to tell `git commit`
>>> to look for all changes to the content it is tracking and commit it
>>> automatically. That
>>                  ^^^^^^^
>>                  files
>>                  (or "files whose contents")
>>
>>> is, this example ...
>> [Yes, git tracks the contents of files, but it also has a list of
>> files whose contents it is tracking]
> 
> regardless, I think "it" should become "them"
> 
> ... it is tracking and commit them automatically. 
> 

Works wonderfully, as the syntactically anal will notice that "them" 
refers to "the changes" while newbies glossing over the docs will think 
of "them" as "the files" (which is technically incorrect but amounts to 
the same thing from that same newbies perspective).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
