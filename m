X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: trouble with git cvsimport
Date: Tue, 12 Dec 2006 09:25:24 +0100
Message-ID: <457E6774.20707@op5.se>
References: <457DE980.50605@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 08:25:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <457DE980.50605@f2s.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34067>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu2x9-0003AI-Qb for gcvg-git@gmane.org; Tue, 12 Dec
 2006 09:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750891AbWLLIZ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 03:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWLLIZ0
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 03:25:26 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:53363 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1750891AbWLLIZ0 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 03:25:26 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id E45CE6BCBE; Tue, 12 Dec 2006 09:25:24 +0100 (CET)
To: Ian Molton <spyro@f2s.com>
Sender: git-owner@vger.kernel.org

Ian Molton wrote:
> Hi.
> 
> I imported a CVS repo with git cvsimport, which went well enough, 
> however subsequent repeats of the same command arent updating the git 
> repo. whats up?
> 
> command Im using is:
> 
> git-cvsimport -d:local:/home/ian/projects/hh.org_cvs/cvs/ -k -m -p x -o 
> hh.org_cvs linux/kernel26


Does linux/kernel26/.git/.git exists? I managed to get something similar 
once and it had me confused a loong time.


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
