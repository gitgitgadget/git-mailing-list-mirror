X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] git-add update with all-0 object
Date: Thu, 30 Nov 2006 17:49:27 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611301747330.9647@xanadu.home>
References: <Pine.LNX.4.64.0611301634080.20138@iabervon.org>
 <Pine.LNX.4.64.0611301733460.9647@xanadu.home> <eknmju$9ok$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 30 Nov 2006 22:50:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <eknmju$9ok$1@sea.gmane.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32827>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpuii-00018J-MH for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031571AbWK3Wt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031608AbWK3Wt3
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:49:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11581 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1031571AbWK3Wt2
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:49:28 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9K0094CFEF2W40@VL-MO-MR001.ip.videotron.ca> for git@vger.kernel.org; Thu,
 30 Nov 2006 17:49:28 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Thu, 30 Nov 2006, Jakub Narebski wrote:

> Nicolas Pitre wrote:
> 
> > On Thu, 30 Nov 2006, Daniel Barkalow wrote:
> > 
> >> One thing that I think is non-intuitive to a lot of users (either novice 
> >> or who just don't do it much) is that it matters where in the process you 
> >> do "git add <path>" if you're also changing the file. Even if you 
> >> understand the index, you may not realize (or may not have internalized 
> >> the fact) that what git-add does is update the index with what's there 
> >> now.
> > 
> > And actually I think this is a good thing.  This is what makes the index 
> > worth it.  Better find a way to make it obvious to people what's 
> > happening.
> 
> Still, perhaps (perhaps!) it would be useful to have "intent to add"
> git-add.

Well, sure.  It could be an argument to git-add.  But surely not the 
default?

git-add --latest maybe?


