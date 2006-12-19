X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Add --remotes option to show-branch
Date: Tue, 19 Dec 2006 13:59:14 -0500
Message-ID: <4102F0A8-3DC4-43D1-B772-A4529D769131@silverinsanity.com>
References: <20061218145053.GA5175@178.242.249.10.in-addr.arpa> <7vfybdvsq7.fsf@assigned-by-dhcp.cox.net> <5D50A3C0-4521-402B-ABD4-5698870A3BD2@silverinsanity.com> <7vpsagtowm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 19:01:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vpsagtowm.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwkDX-0005pS-4V for gcvg-git@gmane.org; Tue, 19 Dec
 2006 20:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932903AbWLSTBc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 14:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932909AbWLSTBc
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 14:01:32 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:41979 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932903AbWLSTBb (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 14:01:31 -0500
Received: from [192.168.1.6] (cpe-66-67-221-135.rochester.res.rr.com
 [66.67.221.135]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by silverinsanity.com (Postfix) with ESMTP id
 40F741FFD321; Tue, 19 Dec 2006 19:01:31 +0000 (UTC)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


On Dec 19, 2006, at 12:50 AM, Junio C Hamano wrote:

> Actually, git show-branch origin/* would work equally well if
> you do not have local "heads/origin/*" branches.

Fair enough.  I'm not strongly attached to the options for the  
various refs.  And there is always showbranch.default.  I still think  
that --all would be good to keep around as meaning refs/heads/* and  
refs/remotes/*/*, however (and NOT refs/tags/*).  If nothing else, so  
a small-ish repository can compare everything fairly easily.

