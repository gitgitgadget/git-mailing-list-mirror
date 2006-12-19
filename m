X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Add --remotes option to show-branch
Date: Tue, 19 Dec 2006 00:17:58 -0500
Message-ID: <5D50A3C0-4521-402B-ABD4-5698870A3BD2@silverinsanity.com>
References: <20061218145053.GA5175@178.242.249.10.in-addr.arpa> <7vfybdvsq7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 05:18:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vfybdvsq7.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34784>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwXMt-0002Mc-Qw for gcvg-git@gmane.org; Tue, 19 Dec
 2006 06:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752491AbWLSFSU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 00:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbWLSFSU
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 00:18:20 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:55239 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1752491AbWLSFST (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 00:18:19 -0500
Received: from [192.168.1.6] (cpe-66-67-221-135.rochester.res.rr.com
 [66.67.221.135]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by silverinsanity.com (Postfix) with ESMTP id
 B921E1FFC02B; Tue, 19 Dec 2006 05:18:12 +0000 (UTC)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


On Dec 18, 2006, at 3:45 PM, Junio C Hamano wrote:

> I've never used --heads and --tags myself because
>
> 	git show-branch heads/*
>         git show-branch tags/*
>
> works perfectly well for me, and it often is not very useful to
> look at _all_ the heads (tags are even much less interesting) in
> a topic heavy repository anyway.  IOW, I more often do something
> like:
>
> 	git show-branch --topics master heads/js/*
>
> to see what Johannes has relative to "master".
>
> I actually was thinking about removing these flags, not adding
> --remotes, because
>
> 	git show-branch remotes/origin/*

I agree that tags/* is fairly useless.  Way too much data.  And if  
you want to remote --heads and --tags, then --remotes doesn't have  
much place.  I was simply poking around and thought that if we have  
those two, then the third seemed natural and odd to miss.

However if --all meant all heads, local or remote, I'd be fairly  
pleased.  heads/* is just as easy as --heads (and leaving it blank is  
even easier), but --remotes is significantly easier than "remotes/ 
origin/* remotes/partner/*".  And sometimes I'd really like to know  
where all the branches are in relation to each other.

Pardon if this doesn't make much sense.  It's been a looooong day...

