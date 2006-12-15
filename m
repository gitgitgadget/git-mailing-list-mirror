X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 17:13:45 +0100
Message-ID: <4582C9B9.8090401@op5.se>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com> <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <200612141136.59041.andyparkins@gmail.com> <eluemi$gc0$1@sea.gmane.org> <Pine.LNX.4.64.0612151029080.18171@xanadu.home> <4582C3CE.3000902@op5.se> <Pine.LNX.4.64.0612151106580.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 16:14:00 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <Pine.LNX.4.64.0612151106580.18171@xanadu.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34532>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvFh0-00005b-IF for gcvg-git@gmane.org; Fri, 15 Dec
 2006 17:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752805AbWLOQNs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 11:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806AbWLOQNr
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 11:13:47 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:55814 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1752805AbWLOQNr (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 11:13:47 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id ECC366BCBC; Fri, 15 Dec 2006 17:13:45 +0100 (CET)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre wrote:
> On Fri, 15 Dec 2006, Andreas Ericsson wrote:
> 
>> Nicolas Pitre wrote:
>>> On Fri, 15 Dec 2006, Jakub Narebski wrote:
>>>
>>>> It would be nice to have some generic place in git config to specify
>>>> default options to git commands (at least for interactive shell). It
>>>> cannot be done using aliases. Perhaps defaults.<command> config variable?
>>> I would say the alias facility has to be fixed then.
>>>
>>> In bash you can alias "ls" to "ls -l" and it just works.
>>>
>> I think this is because git scripts that need a certain git command to work a
>> certain way don't want some alias to kick in and destroy things for them.
>> Shell-scripts would have the same problem if you alias "awk" to "grep" f.e.,
>> which is why prudent shell-scripters use the "unalias -a" thing.
> 
> Wouldn't it be possible for aliases to be effective only when issued 
> from an interactive shell?  It is certainly true that aliases just make 
> no sense in a script.
> 

Yes, but then aliases wouldn't work in one-liners, which would be a bit 
of a shame and pretty likely to cause some "interesting" bugreports. 
Perhaps an environment variable GIT_IGNORE_ALIAS=yes that git-scripts 
can set at the beginning of execution?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
