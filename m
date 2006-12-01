X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Resolving conflicts
Date: Thu, 30 Nov 2006 23:57:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611302353580.3695@woody.osdl.org>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
 <456FDF24.1070001@saville.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 07:57:28 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456FDF24.1070001@saville.com>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32864>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq3Gv-0001P3-3D for gcvg-git@gmane.org; Fri, 01 Dec
 2006 08:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936099AbWLAH5W (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 02:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936100AbWLAH5W
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 02:57:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:31162 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S936099AbWLAH5V (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 02:57:21 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB17vIjQ011002
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 23:57:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB17vIqI005541; Thu, 30 Nov
 2006 23:57:18 -0800
To: Wink Saville <wink@saville.com>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Wink Saville wrote:
> 
> Earlier had a problem with git wanting merge but didn't have it and
> couldn't figure out which package it was in Ubuntu:( So I symlinked merge
> to kdiff3 which worked at the time:

Ahh. I'm pretty sure that is it.

No, kdiff3 probably doesn't have the same semantics, so better get the 
"real" merge. It's almost certainly in the rcs package, so "emerge rcs" 
should do it.

Or whatever system Ubuntu uses. 

