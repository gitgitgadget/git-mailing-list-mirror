X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: bug: git-sh-setup should not be in $PATH
Date: Thu, 07 Dec 2006 14:36:37 +0100
Message-ID: <457818E5.5010008@op5.se>
References: <el6c6o$oa7$1@sea.gmane.org> <200612061627.40359.jnareb@gmail.com> <4576E38F.1020404@xs4all.nl> <200612061656.55888.jnareb@gmail.com> <4576E9DF.5090709@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 13:36:44 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <4576E9DF.5090709@xs4all.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33577>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsJQY-0007AQ-ER for gcvg-git@gmane.org; Thu, 07 Dec
 2006 14:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032210AbWLGNgj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 08:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032215AbWLGNgj
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 08:36:39 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:58866 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1032210AbWLGNgi (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 08:36:38 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 59A986BCBF; Thu,  7 Dec 2006 14:36:37 +0100 (CET)
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:
> Since git does recursive makes, among others in 
> 
>  perl/ 
>  Documentation/
>  templates/
>  contrib/
>   
> there should be Makefiles in said directories. Otherwise, every rule
> in the toplevel Makefile saying
> 
> 
>   $(MAKE) -C subdir/
> 
> will fail because $builddir/ does not have a Makefile in
> $builddir/subdir.
> 

This part should have been in the commit message, possibly without the 
"among others ... (examples)" and possibly with an added "This patch 
makes it so by letting fnurg create them through smurfing the frotz".

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
