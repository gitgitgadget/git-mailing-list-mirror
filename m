X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [BUG] StGit removed git branch of the same name as StGit branch
Date: Tue, 21 Nov 2006 10:19:00 +0000
Message-ID: <tnx1wnxxfu3.fsf@arm.com>
References: <200611202201.45521.jnareb@gmail.com>
	<b0943d9e0611210126x493848d9xae006af835fc62c7@mail.gmail.com>
	<ejuj2a$2ot$1@sea.gmane.org>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 10:19:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ejuj2a$2ot$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
 21 Nov 2006 11:07:31 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 21 Nov 2006 10:19:20.0441 (UTC) FILETIME=[82198E90:01C70D56]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31983>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmSid-0000AM-4B for gcvg-git@gmane.org; Tue, 21 Nov
 2006 11:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030823AbWKUKTH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 05:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030824AbWKUKTH
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 05:19:07 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:44792 "EHLO
 cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP id
 S1030823AbWKUKTE (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006
 05:19:04 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18]) by
 cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id kALAJ24b017299;
 Tue, 21 Nov 2006 10:19:02 GMT
Received: from localhost.localdomain ([10.1.255.211]) by
 cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0); Tue, 21 Nov 2006
 10:19:20 +0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> Catalin Marinas wrote:
>> I've never thought anyone would see a different meaing for the
>> "branch" command. What you wanted to do was the reverse of the "init"
>> command. Maybe something like "uninit" or a "--uninit" option to
>> "branch".
>
> Yes, that is what I wanted. "stg branch --unmanage" or something
> like that.

I'll put it on my to-do list.

> By the way, why "stg branch --delete" doesn't remove reflog? Not that I'm
> complaining, because it sure saved some work when resurrecting branch, and
> I didn't loose reflog info.

Reflogs came into GIT after the StGIT branch command and never looked
at them in detail. And maybe it should not touch the reflog info,
especially for situations like this, unless GIT has a mechanism for a
trash bin (StGIT has one for patches - .git/patches/<branch>/trash/ -
but undocumented)

-- 
