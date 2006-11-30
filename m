X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 30 Nov 2006 16:50:54 +0100
Message-ID: <456EFDDE.9010705@op5.se>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611301449.55171.andyparkins@gmail.com> <20061130152011.GM12463MdfPADPa@greensroom.kotnet.org> <200611301530.51171.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 15:51:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <200611301530.51171.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32758>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpoBg-0000AX-JL for gcvg-git@gmane.org; Thu, 30 Nov
 2006 16:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030608AbWK3Pu5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 10:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030618AbWK3Pu4
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 10:50:56 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:60881 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030613AbWK3Pu4 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 10:50:56 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id ED36C6BCC3; Thu, 30 Nov 2006 16:50:54 +0100 (CET)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> On Thursday 2006 November 30 15:20, Sven Verdoolaege wrote:
> 
>> You can work on the submodule independently.
> 
> It's not independent if any part of it is in the supermodule.
> 
>>> some of the development of the submodule is contained in the supermodule
>>> then it's not a submodule anymore.
>> On the contrary, that's exactly what a submodule is supposed to be.
> 
> I don't think so.  I think it's just made some complicated normal repository.
> 

I believe that Andy meant "development history" in his above scentence. 
Naturally, using the code from the submodule while being capable of 
developing the submodule separately from the supermodule is what 
submodules are all about.

>> How are you going to checkout the right commit of the lixcb repo if
>> you didn't store it in the supermodule ?
> 
> Well, I know what the commit is /that/ was all that was stored.  So I 
> (actually supermodule-git does):
> 
> cd $DIRECTORY_ASSOCIATED_WITH_SUBMODULE
> git checkout -f $COMMIT_FROM_SUPERMODULE
> 
> Obviously, this is grossly simplified.  It also requires that HEAD be allowed 
> to be an arbitrary commit rather than a branch, but that's already been 
> generally agreed upon as a good thing.
> 

It has? We're not talking supermodule specific things anymore, are we?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
