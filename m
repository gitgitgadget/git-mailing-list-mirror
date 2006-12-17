X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 16 Dec 2006 23:35:20 -0500
Message-ID: <3C540990-B78E-405B-ACFF-F558DB776C85@silverinsanity.com>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 04:35:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34675>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvnkM-0007DV-NH for gcvg-git@gmane.org; Sun, 17 Dec
 2006 05:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751895AbWLQEf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 23:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbWLQEf0
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 23:35:26 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:33085 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1751893AbWLQEf0 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 23:35:26 -0500
Received: from [192.168.1.6] (cpe-66-67-221-135.rochester.res.rr.com
 [66.67.221.135]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by silverinsanity.com (Postfix) with ESMTP id
 319881FFD321; Sun, 17 Dec 2006 04:35:25 +0000 (UTC)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

> ** jc/reflog (Thu Dec 14 15:58:56 2006 -0800) 1 commit
>  - Teach show-branch how to show ref-log data.
>
> A strawman to make reflog data a bit more browsable; it would be
> useful while recovering from a mistake you made recently.  Not
> essential and can wait or be dropped if people do not find it
> useful.

I'd prefer not to add clutter into show-branch.  I use it on a  
regular basis to see what I've added to what topic branch recently,  
and to look at branches before rebasing.  It also just seems like the  
wrong place to have that kind of data, although I guess it's more  
useful for people who do merges more often than I do.

What about a "git reflog [<branch>]" command instead?  Would show  
output similar to "git log" (or "git show-branch" for brevity).

