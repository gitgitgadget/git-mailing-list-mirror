X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-status always says what branch it's on
Date: Thu, 14 Dec 2006 16:54:26 +0100
Message-ID: <458173B2.5010009@op5.se>
References: <200612141525.23671.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 15:54:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <200612141525.23671.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34355>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gusuo-0001Hp-0O for gcvg-git@gmane.org; Thu, 14 Dec
 2006 16:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932831AbWLNPy2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 10:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932814AbWLNPy2
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 10:54:28 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:35857 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932831AbWLNPy2 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 10:54:28 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id DED0C6BCC7; Thu, 14 Dec 2006 16:54:26 +0100 (CET)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> If the current branch was "master" then git-status wouldn't say
> 
>  # On branch XXXX
> 
> In its output.  This patch makes it so that this message is always
> output; regardless of branch name.
> 

I like it. I know that it's quiet when I'm on 'master', but I still need 
to spend an extra cycle to remember that fact. Uniformity is a good 
thing in program behaviour.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
