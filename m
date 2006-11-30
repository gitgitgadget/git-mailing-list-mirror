X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 12:37:49 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home>
 <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net> <87ejrlvn7r.wl%cworth@cworth.org>
 <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>
 <20061130164046.GB17715@thunk.org>
 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 30 Nov 2006 17:38:12 +0000 (UTC)
Cc: Theodore Tso <tytso@mit.edu>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32781>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpprD-0003lo-UC for gcvg-git@gmane.org; Thu, 30 Nov
 2006 18:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030820AbWK3Rhv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 12:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030881AbWK3Rhv
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 12:37:51 -0500
Received: from relais.videotron.ca ([24.201.245.36]:26814 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1030820AbWK3Rhu
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 12:37:50 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9K005MT0Z1Q8P0@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 30 Nov 2006 12:37:50 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Thu, 30 Nov 2006, Linus Torvalds wrote:

> The default is: commit everything that you ask for to be committed.
> 
> If you haven't marked anything to be committed (which you can do with "git 
> add" too, or with simply being in the middle of a merge, or by having done 
> something like "git pull -n" or similar that does everything _but_ 
> commit), then git commit will say "nothing to do".

Might it be a good idea to have "git-add" do the same as 
"git-update-index" on already tracked files?  That could be easily 
taught as "you must explicitly _add_ files to your next commit" and 
whether the file is already tracked or not wouldn't matter.  This would 
help newbies actually getting used the index without mentioning the 
dreaded word "index" at all.

Right now git-add on an already tracked file does nothing, not even a 
message to say it did nothing.


