X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: shortlog, was Re: merge-recursive, was Re: What's in git.git
Date: Thu, 26 Oct 2006 09:39:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610260937070.12418@xanadu.home>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0610261114520.3286@wbgn013.biozentrum.uni-wuerzburg.de>
 <45409D79.8010909@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 26 Oct 2006 13:40:16 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <45409D79.8010909@op5.se>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30216>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd5SI-0001pn-Qv for gcvg-git@gmane.org; Thu, 26 Oct
 2006 15:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161157AbWJZNjV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 09:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161330AbWJZNjU
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 09:39:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33983 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1161302AbWJZNjU
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 09:39:20 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7Q00IJ7WLJZHB0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Thu,
 26 Oct 2006 09:39:19 -0400 (EDT)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

On Thu, 26 Oct 2006, Andreas Ericsson wrote:

> I keep writing
> 	git log --short
> 
> when I really want
> 	git log --pretty=short | git shortlog
> 
> 
> I'll have a look at making it work if I get a spare moment.

Why don't you simply drop the --pretty=short altogether?

	git log | git shortlog


