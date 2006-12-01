X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 15:52:29 +0100
Message-ID: <457041AD.4010601@op5.se>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703174.8000609@op5.se> <20061201134610.GW18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 14:52:58 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061201134610.GW18810@admingilde.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32929>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq9kh-00015z-ED for gcvg-git@gmane.org; Fri, 01 Dec
 2006 15:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758851AbWLAOwc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 09:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758889AbWLAOwb
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 09:52:31 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:32664 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1758851AbWLAOwb (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 09:52:31 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 081D06BCC5; Fri,  1 Dec 2006 15:52:30 +0100 (CET)
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Martin Waitz wrote:
> hoi :)
> 
> On Fri, Dec 01, 2006 at 02:43:16PM +0100, Andreas Ericsson wrote:
>> So a commit in the supermodule turns into a commit in the submodule? 
> 
> no.
> 
>> If it doesn't, why would the submodule HEAD have to change?
> 
> So how do you update your submodule?
> 

By committing to it separately, or by getting changes from the upstream 
project (openssl, libcurl, ...).

> Remember: if you git-pull in the supermodule, you want to update the
> whole thing, including all submodules.
> 

Only if the new commits I pull into the supermodule DAG has commits 
which includes a new shapshot of the submodule, otherwise it wouldn't be 
necessary.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
