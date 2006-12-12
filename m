X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Adding a new file as if it had existed
Date: Tue, 12 Dec 2006 14:20:32 +0100
Message-ID: <457EACA0.7050208@op5.se>
References: <7ac1e90c0612120205k38b2fc14jbfd8ea682406efb2@mail.gmail.com> <7vhcw1whfx.fsf@assigned-by-dhcp.cox.net> <7ac1e90c0612120332o20d6778bsa16a788fdc04a3a1@mail.gmail.com> <200612121226.32772.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 13:20:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <200612121226.32772.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34097>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu7Ym-0007OR-4A for gcvg-git@gmane.org; Tue, 12 Dec
 2006 14:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751322AbWLLNUf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 08:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWLLNUf
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 08:20:35 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:57374 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1751322AbWLLNUe (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 08:20:34 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id F3C6F6BCBE; Tue, 12 Dec 2006 14:20:32 +0100 (CET)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> On Tuesday 2006 December 12 11:32, Bahadir Balban wrote:
> 
>> If I don't know which files I may be touching in the future for
>> implementing some feature, then I am obliged to add all the files even
>> if they are irrelevant. I said "performance reasons" assuming all the
>> file hashes need checked for every commit -a to see if they're
>> changed, but I just tried on a PIII and it seems not so slow.
> 
> Here's a handy rule of thumb I've learned in my use of git:
> 
>  "git is fast.  Really fast."
> 

Almost alarmingly so. When I started using git (back in May/June last 
year, when git was 2 - 3 months old), I was worried at first because it 
didn't seem to actually *do* anything, but just returned me to the 
prompt immediately.

> 
> As to your direct concern: git doesn't hash every file at every commit.  There 
> is no need.  git has an "index" that is used to prepare a commit; at the time 
> you do the actual commit, git already knows which files are being checked in.  
> 
> In short - don't worry about making life easy for git - it's a workhorse and 
> does a grand job.
> 

Yup. Now I've gone the other way around and think other scm's are broken 
when they chew disk for 10 seconds whenever I try to do anything with 
them. I usually end up importing the other repo into git and do my work 
there.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
