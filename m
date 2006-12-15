X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] make commit message a little more consistent and conforting
Date: Fri, 15 Dec 2006 11:06:00 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612151104120.18171@xanadu.home>
References: <200612132237.10051.andyparkins@gmail.com>
 <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
 <200612140959.19209.andyparkins@gmail.com>
 <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612141343200.18171@xanadu.home>
 <Pine.LNX.4.64.0612142307160.18171@xanadu.home>
 <20061215042459.GC27343@spearce.org> <45825E0B.5010200@op5.se>
 <20061215150909.GE17860@spearce.org> <4582C022.3030706@op5.se>
 <20061215154025.GF17860@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 15 Dec 2006 16:06:18 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061215154025.GF17860@spearce.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34528>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvFZX-0007J5-H9 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 17:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752784AbWLOQGE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 11:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794AbWLOQGE
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 11:06:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:22871 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752784AbWLOQGB (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 11:06:01 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAB00JJ1OQ014D0@VL-MO-MR004.ip.videotron.ca> for git@vger.kernel.org; Fri,
 15 Dec 2006 11:06:01 -0500 (EST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Fri, 15 Dec 2006, Shawn Pearce wrote:

> I do the same (diff a lot before commit) and thus find commit
> outputting anything at all to be noisy and irritating.  Frankly
> the new
> 
>   git-diff-tree --summary --root --no-commit-id HEAD
> 
> that Junio put on the end is already irritating.
> 
> But it was added to help users verify that commit did what they
> thought it would (see 61f5cb7f).  By the same token sometimes users
> accidentally commit files they didn't mean to, or forget to include
> files they meant to include.  Showing a diffstat would also be a
> final sanity check for them.

Make it with -v.

If the --summary is already irritating to you, imagine how a diffstat 
could be.


