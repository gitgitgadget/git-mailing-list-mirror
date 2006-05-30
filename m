X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/10] re-based and expanded tree-walker cleanup patches
Date: Mon, 29 May 2006 17:42:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605291739430.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
 <7virno79a7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 30 May 2006 00:43:09 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7virno79a7.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1FksJx-00057a-Q9 for gcvg-git@gmane.org; Tue, 30 May
 2006 02:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751141AbWE3Amr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 29 May 2006
 20:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWE3Amr
 (ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 20:42:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29877 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1751141AbWE3Amr (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 29 May 2006 20:42:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4U0gh2g029140
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 29
 May 2006 17:42:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4U0ggbs022775; Mon, 29 May
 2006 17:42:42 -0700
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Mon, 29 May 2006, Junio C Hamano wrote:
> 
> Sorry for having you have done this -- last night I've merged
> the series without rebasing and have the result in "next".  I'll
> compare to see if you have spotted my mismerges there tonight.

It was interesting. I cleaned up the series and switched the order of some 
commits in my tree by doing first a "git rebase" and then cherry-picking 
them into another branch, and using "git commit --amend" to fix up some of 
the things I had missed.

Pretty powerful, although at one point I was wondering about having a "git 
rebase" that could switch commits around or drop unwanted ones (ie let the 
user edit the cherry-picking list before the actual rebase).

