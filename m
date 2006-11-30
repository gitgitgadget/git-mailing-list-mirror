X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] git-add update with all-0 object
Date: Thu, 30 Nov 2006 17:34:58 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611301733460.9647@xanadu.home>
References: <Pine.LNX.4.64.0611301634080.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 30 Nov 2006 22:35:15 +0000 (UTC)
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0611301634080.20138@iabervon.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32819>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpuUi-00072q-Jj for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031586AbWK3WfA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031587AbWK3WfA
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:35:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55532 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1031586AbWK3We7
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:34:59 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9K006W2EQA4K90@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 30 Nov 2006 17:34:58 -0500 (EST)
To: Daniel Barkalow <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org

On Thu, 30 Nov 2006, Daniel Barkalow wrote:

> One thing that I think is non-intuitive to a lot of users (either novice 
> or who just don't do it much) is that it matters where in the process you 
> do "git add <path>" if you're also changing the file. Even if you 
> understand the index, you may not realize (or may not have internalized 
> the fact) that what git-add does is update the index with what's there 
> now.

And actually I think this is a good thing.  This is what makes the index 
worth it.  Better find a way to make it obvious to people what's 
happening.


