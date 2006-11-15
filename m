X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 13:15:26 +0100
Message-ID: <455B04DE.1040107@op5.se>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net> <7virhhy76h.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142048350.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 12:15:40 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>,
	Carl Worth <cworth@cworth.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <Pine.LNX.4.64.0611142048350.2591@xanadu.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31438>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkJfy-0006BQ-LP for gcvg-git@gmane.org; Wed, 15 Nov
 2006 13:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030421AbWKOMPb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 07:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWKOMPb
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 07:15:31 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:22697 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030421AbWKOMPa (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 07:15:30 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id A1DD86BD9B; Wed,
 15 Nov 2006 13:15:29 +0100 (CET)
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
 by smtp-gw1.op5.se (Postfix) with ESMTP id DC9516BD18; Wed, 15 Nov 2006
 13:15:26 +0100 (CET)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre wrote:

[ axed a lot of stuff that I didn't fully grok ]

> 
> This becomes formalized as:
> 
> 	git_pull [<URL>] [<local_name>]
> 
> If <URL> includes a branch name then <local_name> is a single branch 
> name.  If <URL> doesn't include any branch name then <local_name> 
> becomes a local branch group name containing all branches in the remote 
> repository.

I would change that so "local_name" is always a branch group name, but 
branch group names can be used as refs. That is,

git pull startrek.com/kirk.git:master kirk

would always create the branch-head .git/refs/remote/kirk/master which 
for short can be referenced as just "kirk" (barring clashes ofc), so 
long as it only has one branch tracked.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
