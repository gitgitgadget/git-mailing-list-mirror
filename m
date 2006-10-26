X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: shortlog, was Re: merge-recursive, was Re: What's in git.git
Date: Thu, 26 Oct 2006 13:35:21 +0200
Message-ID: <45409D79.8010909@op5.se>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0610261114520.3286@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 11:36:01 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <Pine.LNX.4.63.0610261114520.3286@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30193>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd3WF-0005N5-C1 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 13:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932212AbWJZLf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 07:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbWJZLf0
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 07:35:26 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:30348 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751699AbWJZLfY (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 07:35:24 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 9DF786BD3A; Thu,
 26 Oct 2006 13:35:23 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 9A5F96BD02; Thu, 26 Oct 2006 13:35:21 +0200 (CEST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> 
> BTW what happened to the builtin shortlog? It is the last Perl script I 
> use regularly... (should make people happy who are stuck with Activision 
> Perl...)
> 

I keep writing
	git log --short

when I really want
	git log --pretty=short | git shortlog


I'll have a look at making it work if I get a spare moment.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
