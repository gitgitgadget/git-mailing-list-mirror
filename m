X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Mon, 18 Dec 2006 17:09:47 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612181708340.18171@xanadu.home>
References: <86y7p57y05.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
 <86r6uw9azn.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181625140.18171@xanadu.home>
 <86hcvs984c.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 18 Dec 2006 22:10:15 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <86hcvs984c.fsf@blue.stonehenge.com>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34743>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwQgC-0001xB-IF for gcvg-git@gmane.org; Mon, 18 Dec
 2006 23:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754681AbWLRWJt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 17:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754682AbWLRWJt
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 17:09:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53163 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1754680AbWLRWJs (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 17:09:48 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAH00DRKPKBP1J1@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Mon,
 18 Dec 2006 17:09:47 -0500 (EST)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org

On Mon, 18 Dec 2006, Randal L. Schwartz wrote:

> >>>>> "Nicolas" == Nicolas Pitre <nico@cam.org> writes:
> 
> Nicolas> Could you try the following please:
> 
> Nicolas> 	time git-index-pack -v -o /dev/null .git/objects/pack/*.pack
> 
> Nicolas> and provide us with the time it took (or an estimate if it is going to 
> Nicolas> be on hour long)?
> 
> Nicolas> Performing the above on my kernel repository (after it was repacked into 
> Nicolas> a single ~150MB pack) takes only 37 seconds.
> 
> I have a single pack.
> 
> "Indexing" took about 30 seconds.
> "Resolving 313037 deltas" looks like it's going to take an hour.
> 
> So that *was* a local delay.

What CPU and amount of ram do you have?

Are you on Windows?


