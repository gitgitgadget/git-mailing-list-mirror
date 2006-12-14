X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: svn versus git
Date: Thu, 14 Dec 2006 23:07:52 +0100
Message-ID: <4581CB38.8050401@op5.se>
References: <200612132200.41420.andyparkins@gmail.com> <200612142000.54409.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 22:08:32 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <200612142000.54409.arekm@maven.pl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34415>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuykZ-00087Q-Ee for gcvg-git@gmane.org; Thu, 14 Dec
 2006 23:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751796AbWLNWIU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 17:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbWLNWIU
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 17:08:20 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:41452 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1751796AbWLNWIU (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 17:08:20 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
 by smtp-gw1.op5.se (Postfix) with ESMTP id 8762F6BCC4; Thu, 14 Dec 2006
 23:08:18 +0100 (CET)
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Sender: git-owner@vger.kernel.org

Arkadiusz Miskiewicz wrote:
> On Wednesday 13 December 2006 23:00, Andy Parkins wrote:
>> Hello,
>>
>> With all the discussion about user interface difficulties, I started to
>> write a comparison with subversion document.  (I was assuming that people
>> find subversion easy).  As much as I love git, I was expecting to find that
>> it's hard to use interface would have subversion as the clear winner.  I
>> was hoping that would then give guidance as to what could be fixed in git.
>>
>> I was surprised, therefore, to find that in each case I was finding that
>> git was the winner.
> 
> subversion is a winner when it comes to options handling (especially --help) 
> and better (error) messages. That's one of reason why people find it easy.
> 

Yup. Most discussions about what git can do to improve usually ends up 
in a patch that fixes either documentation or error- / help-messages.

> ps. I'm blind or there is no documentation about what utilities are needed to 
> get git fully working? (like sed, coreutils, grep, rcs package (merge tool 
> afaik needed)...). 
> 

perl and the standard coreutils, which afaik are required to be present 
on all unix systems. We no longer require external merge tools.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
