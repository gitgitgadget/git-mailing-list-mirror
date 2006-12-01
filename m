X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 19:08:12 +0100
Message-ID: <45706F8C.3070000@op5.se>
References: <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703174.8000609@op5.se> <20061201134610.GW18810@admingilde.org> <457041AD.4010601@op5.se> <20061201150045.GZ18810@admingilde.org> <45705A94.2070509@op5.se> <20061201165708.GE18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 18:08:38 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061201165708.GE18810@admingilde.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32953>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqCo4-0005L6-TP for gcvg-git@gmane.org; Fri, 01 Dec
 2006 19:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759312AbWLASIO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 13:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759320AbWLASIO
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 13:08:14 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:41120 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1759312AbWLASIN (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 13:08:13 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 9147E6BCC5; Fri,  1 Dec 2006 19:08:12 +0100 (CET)
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org



Martin Waitz wrote:
> On Fri, Dec 01, 2006 at 05:38:44PM +0100, Andreas Ericsson wrote:
>>> But if the supermodule contains changes to the submodule, you still
>>> have to change the submodule.  And this implies changing the submodule
>>> HEAD or some branch.
>>>
>> Not really. I fail to see why HEAD needs to be changed so long as the 
>> commit is in the submodule's odb.
> 
> Because I want the submodule to act as a normal git repository.
> Please note that I also voted against changing HEAD directly, but that
> the new commit which came from the supermodule is just stored in one
> branch of the submodule, as part of the supermodule checkout.
> 

You're assuming the super- and sub-module will share HEAD, or at least 
ODB, I think. I'm not convinced this is necessary. Convince me. I'll go 
drink bear and get some dancing done while you're at it ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
