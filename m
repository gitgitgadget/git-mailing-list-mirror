X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] git-add update with all-0 object
Date: Thu, 30 Nov 2006 23:41:53 +0100
Organization: At home
Message-ID: <eknmju$9ok$1@sea.gmane.org>
References: <Pine.LNX.4.64.0611301634080.20138@iabervon.org> <Pine.LNX.4.64.0611301733460.9647@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 30 Nov 2006 22:40:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 22
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32822>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpua9-00082o-68 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031598AbWK3Wk3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031601AbWK3Wk2
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:40:28 -0500
Received: from main.gmane.org ([80.91.229.2]:60344 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1031600AbWK3Wk0 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:40:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpuZh-0007z8-AQ for git@vger.kernel.org; Thu, 30 Nov 2006 23:40:13 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 23:40:13 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30 Nov 2006
 23:40:13 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nicolas Pitre wrote:

> On Thu, 30 Nov 2006, Daniel Barkalow wrote:
> 
>> One thing that I think is non-intuitive to a lot of users (either novice 
>> or who just don't do it much) is that it matters where in the process you 
>> do "git add <path>" if you're also changing the file. Even if you 
>> understand the index, you may not realize (or may not have internalized 
>> the fact) that what git-add does is update the index with what's there 
>> now.
> 
> And actually I think this is a good thing.  This is what makes the index 
> worth it.  Better find a way to make it obvious to people what's 
> happening.

Still, perhaps (perhaps!) it would be useful to have "intent to add"
git-add.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

