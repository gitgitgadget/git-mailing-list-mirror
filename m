X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-add --interactive (wip)
Date: Wed, 13 Dec 2006 10:20:34 +0100
Message-ID: <457FC5E2.9040709@op5.se>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com> <7vd56s8t9w.fsf@assigned-by-dhcp.cox.net> <7vslfm23co.fsf_-_@assigned-by-dhcp.cox.net> <200612111147.44964.Josef.Weidendorfer@gmx.de> <7vwt4wpytm.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612122311400.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 09:44:42 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <Pine.LNX.4.63.0612122311400.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34195>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuQfB-0007m3-0D for gcvg-git@gmane.org; Wed, 13 Dec
 2006 10:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932642AbWLMJoa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 04:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbWLMJoa
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 04:44:30 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:41833 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932642AbWLMJo3 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 04:44:29 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id CD6C46BCC3; Wed, 13 Dec 2006 10:20:34 +0100 (CET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 12 Dec 2006, Junio C Hamano wrote:
> 
>> So in short, I think per-hunk update-index is a cute hack and may be 
>> useful in a narrow simple cases, but it would not be so useful in the 
>> real life.
> 
> To the contrary! In spite of having written git-hunk-commit to please 
> those poor souls coming from the darcs side, I already used it myself 
> quite often! I think it is a killer feature.
> 

I've tried it a couple of times as well, and it really is very, very 
nice, especially for young projects where you know you have to make 
loads of changes (often basic and codewise small features).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
